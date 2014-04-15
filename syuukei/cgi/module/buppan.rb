#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require 'csv'
require 'bigdecimal'

module Buppan
	class Utiwake
		require 'date'
		require 'erb'
		attr_accessor :customer, :division, :data
		def initialize(bill_month, customer, division, ary_data)
			@bill_month = parsedate(bill_month)
			@customer = customer
			@division = division
			@data = ary_data
			@utiwake_list = []
			list
		end
		def lines
			@utiwake_list
		end
		def pagenate_lines(first_page_row, other_row)
			if @utiwake_list.size <= first_page_row -1
				[] << @utiwake_list
			else
				first_page_lines = @utiwake_list.each_slice(first_page_row).first
				other_lines = @utiwake_list[first_page_row..-1].each_slice(other_row).to_a
				other_lines.unshift(first_page_lines)
			end
		end
		def getudo
			"平成#{@bill_month.year - 1988}年#{@bill_month.month}月度"
		end
		def total_price
			@utiwake_list.inject(0){|sum, line|
				sum + line.sum
			}
		end
		def total_tax
			(BigDecimal(total_price.to_s) * BigDecimal("0.08")).floor
		end
		def total_price_with_tax
			total_price + total_tax
		end
		def total_cost
			@utiwake_list.inject(0){|sum, line|
				sum + (line.units * line.cost)
			}
		end
		def total_gain
			total_price - total_cost
		end
		def honten
			@data.first[0].gsub(/株式会社/, '')
		end

		private
		def list
			utiwake_list = []
			@data.each{|line_data|
				@utiwake_list << line(line_data)
			}
		end
		def line(line_data)
			utiwakeline = Struct.new(:day,
															 :customer_name, :place,
															 :siten_name,
															 :code, :uriba,
															 :item,
															 :price, :units,
															 :sum, :cost)
			utiwakeline.new(parsedate(line_data[5]),
											line_data[2], line_data[6],
											line_data[1],
											get_code(line_data[2]), get_uriba(line_data[2]),
											line_data[7],
											decamma(line_data[8]), decamma(line_data[9]),
											decamma(line_data[10]), decamma(line_data[11]))
		end
		def shipped_day(date)
			parsedate(date).strftime("%m/%d")	
		end
		def parsedate(date)
			case date
			when Date
				date
			else
				ary = date.split("/")
				Date.new(ary[0].to_i, ary[1].to_i, ary[2].to_i)
			end
		end
		def decamma(str)
			str.gsub(/,/, '').to_i
		end
		def get_code(str)
			code = str.split
			if code[0] =~ /\A\d{4,6}\Z/
				code[0]
			end
		end
		def get_uriba(str)
			if get_code(str)
				ans = str.split
				ans.delete_at(0)
				ans.join(" ")
			else
				str
			end
		end
	end

	class BuppanList
		attr_reader :rows
		def initialize(ary_csv)
			ary_csv.delete_at 0
			@rows = ary_csv
		end
		def keijyou_list
			list = []
			@rows.each{|row|
				list << row[9]
			}
			list.uniq
		end
		def find_row_nums(column, keyword)
			list = []
			@rows.each_with_index{|row, i|
				if row[column] == keyword
					list << i
				end
			}
			list
		end
		def utiwake_with_honten_siten(honten_id, siten_id, utiwake_type)
			list1 = find_row_nums(0, honten_id)
			list2 = find_row_nums(1, siten_id)
			list3 = find_row_nums(14, '売上')
			utiwake(list1 & list2 & list3, utiwake_type)
		end
		def utiwake_koujyo_on_honten(keijyou_id)
			ary = UtiwakeList.new
			koujyo_all = koujyo_rows(keijyou_id)
			koujyo_hontenid_list(keijyou_id).each {|honten|
				koujyo_honten = find_row_nums(0, honten)
				ary << utiwake(koujyo_all & koujyo_honten, "nomal")
			}
			ary
		end
		def utiwake_gaibu_on_honten(keijyou_id)
			ary = UtiwakeList.new
			gaibu_all = gaibu_rows(keijyou_id)
			gaibu_hontenid_list(keijyou_id).each {|honten|
				gaibu_honten = find_row_nums(0, honten)
				ary << utiwake(gaibu_all & gaibu_honten, "nomal")
			}
			ary
		end
		def utiwake(row_nums, utiwake_type)
			ary = []
			row_nums.each{|row|
				data = @rows[row]
				ary << [data[2], data[3], data[5], data[9], data[11],
						 data[18], data[20], data[22], data[23],
						 data[24], data[26],data[36]]
			}
			case utiwake_type
			when "nomal"
				Utiwake.new(ary.last[5], ary[0][1], ary[0][3], ary) 
			end
		end
		def koujyo_hontenid_list(keijyou_id)
			ary = []
			list = koujyo_rows(keijyou_id)
			list.each {|row|
				data = @rows[row]
				ary << data[0]
			}
			ary.uniq.sort
		end
		def gaibu_hontenid_list(keijyou_id)
			ary = []
			list = gaibu_rows(keijyou_id)
			list.each {|row|
				data = @rows[row]
				ary << data[0]
			}
			ary.uniq.sort
		end
		def koujyo_rows(keijyou_id)
			list1 = find_row_nums(3, "控除")
			list2 = find_row_nums(8, keijyou_id)
			list1 & list2
		end
		def gaibu_rows(keijyou_id)
			exclusion_list1 = find_row_nums(0, "000001")
			exclusion_list2 = find_row_nums(3, "控除")
			list1 = find_row_nums(14, "売上")
			list2 = find_row_nums(8, keijyou_id)
			list1 & list2 - exclusion_list1 - exclusion_list2
		end
		class UtiwakeList < Array
			def total_price
				self.inject(0){|sum, line| sum + line.total_price}
			end
			def total_cost
				self.inject(0){|sum, line| sum + line.total_cost}
			end
			def total_gain
				self.total_price - self.total_cost
			end
		end
	end
end
