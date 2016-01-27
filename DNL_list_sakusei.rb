#!/usr/bin/ruby
require 'yaml'
#DNLの新価格表作成マクロ
#daifuji_DNL.yamlに記載された価格リストと現登録データを照合して該当カテゴリーの価格を適用した表を標準出力する
#元データは同一フォルダ内kankyuu.txt固定となっている、また一覧出力から読み込みデータ用に列囲うが必要なことにも注意

class Goods
	class Item
		attr_accessor :id, :name, :cost, :price
		attr_reader :type
		def initialize
			@id = ""
			@name = ""
			@type = nil
			@cost = {}
			@price = {}
		end
		def parce_type
			@type.split("_")
		end
		def maker
			case
			when dnl?
				"DNL"
			else
				"unknown"
			end
		end
		def dnl?
			name =~ /\Adn_/
		end
		def dnl_sprit
			ans = []
			if dnl?
				if md = name.match(/(dn_)(F[LSH][RLA])([0-9]{2,4})([TR][56])(.*)/)
					ans.push(md[1],md[2],md[3],md[4],md[5])
					ans.push(dnl_lamp_type(md[2],md[3],md[4],md[5]))
					@type = ans[5]
				end
			end
		end
		private
		def dnl_lamp_type(typename, num, size, color)
			case typename
			when "FLR", "FSL"
				case size
				when "T6", "R6"
					flrsl_color(color,num,size)
				else
					"FLRSL_SIZEunknown"
				end
			when "FHA"
				case size
				when "T5", "R5"
					fha_color(color,num,size)
				else
					"FHA_SIZEunknown"
				end
			else
				"TYPEunknown"
			end
		end
		def fha_color(color, num, size)
			case size
			when "T5"
				case color
				when /\AE[NLWD][^A-Z].*NU\Z/, /\AEWW[^A-Z].*NU\Z/, /\ADL[256].*NU\Z/, /\AEL30.*NU\Z/, /\AEL25.*NU\Z/
					"FHA_sanpaNU" + fha_size(num,size)
				when "EN", "EL", "EW", "EWW", "ED", /\ADL[256]\Z/, "EL30", "EL25"
					"FHA_sanpa" + fha_size(num,size)
				when /\A(WW|DL|N-SDL|N|N-DL|LP|NW|PK|ORN|BW|LG|YY|B|R|G|V)[^A-Z].*NU/
					"FHA_othercolorNU" + fha_size(num,size)
				when "WW", "DL", "N-SDL", "N", "N-DL", "LP", "NW", /\A[RGBV]\Z/, "PK", "ORN", "BW", "LG", "YY"
					"FHA_othercolor" + fha_size(num,size)
				when "FR"
					"FHA_redfilm" + fha_size(num,size)
				when "FPK", "FOR", /\AF[YGBV]\Z/
					"FHA_otherfilm" + fha_size(num,size)
				when "L", "EW-C", "EXL-J", "UN", "CLK", "EX-DH", "LV", "WWDL", "W-OH", "JP1", "DW", "DL", /\ADL[346]\Z/
					"FHA_COLORterminated"
				else
					"FHA_COLORunknown"
				end
			when "R5"
				"FHA_R5"
			else
				"FHA_SIZEunknown"
			end
		end
		def fha_size(num, size)
			case size
			when "T5"
				case num.to_i
				when 22, 25, 28, 30, 32
					"_num8-2"
				when 225, 303, 397, 455, 606, 710
					"_num8-3"
				when 34, 36, 39, 42
					"_num9-2"
				when 757, 860, 910
					"_num_9-3"
				when 45, 48, 54
					"_num10-2"
				when 1060, 1200, 1212, 1250
					"_num10-3"
				when 57, 60,64
					"_num11-2"
				when 1365, 1500, 1515
					"_num11-3"
				when 72
					"_num12-2"
				when 1667
					"_num12-3"
				when (180..742)
					"_num8-1"
				when (744..998)
					"_num9-1"
				when (1000..1301)
					"_num10-1"
				when (1303..1555)
					"_num11-1"
				when (1557..1758)
					"_num12-1"
				else
					"_NUMunknown"
				end
			when "R5"
				"_numR5"
			else
				"_NUMunknown"
			end
		end
		def flrsl_color(color, num, size)
			case size
			when "T6"
				case color
				when /\A[WD]\Z/
					"FLRSL_wd" + flrsl_size(num, size)
				when "EX-N", "EX-W", "EX-L", "EX-WW", "EX-D", /\ADL[256]\Z/, "EX-L30", "EX-L25"
					"FLRSL_sanpa" + flrsl_size(num, size)
				when "WW", "DL", "N-SDL", "N", "N-DL", "LP", "NW", "R", "G", "B", "PK", "V", "BW","LG"
					"FLRSL_othercolor" + flrsl_size(num, size)
				when /\A(L|EW-C|EXL-J|UN|CLK|EX-DH|LV|WWDL|W-OH|JP1|DW|DL)\Z/, /\ADL[346]\Z/
					"FLRSL_COLORterminated"
				else
					"FLRSL_COLORunknown"
				end
			when "R6"
				"FLRSL_R6" + flrsl_size(num, size)
			else
				"FLRSL_SIZEunknown"
			end
		end
		def flrsl_size(num, size)
			case size
			when "T6"
				case num.to_i
				when 18, 22, 24, 25, 28, 30, 32
					"_num1-2"
				when 303,397,455,606
					"_num1-3"
				when 34, 36, 42
					"_num2-2"
				when 757, 910
					"_num2-3"
				when 45, 48, 54
					"_num3-2"
				when 1060, 1200, 1212, 1250
					"_num3-3"
				when 57, 60, 64
					"_num4-2"
				when 1365, 1500, 1515
					"_num4-3"
				when 72
					"_num5-2"
				when 1667
					"_num5-3"
				when 1818
					"_num6-2"
				when 96
					"_num7-2"
				when (180..742)
					"_num1-1"
				when (744..998)
					"_num2-1"
				when (1000..1301)
					"_num3-1"
				when (1303..1555)
					"_num4-1"
				when (1557..1758)
					"_num5-1"
				when (1760..1817)
					"_num6-1"
				when (1819..2367)
					"_num7-1"
				else
					"_NUMunknown"
				end
			when "R6"
				"_numR6"
			else
				"_numNON"
			end
		end
	end

	def initialize
		@goods = []
	end
	def openfile
		File.open("./kankyuu.txt") do |lines|
			lines.each do |line|
				item = Item.new
				l = line.strip.split(/\t/)
				item.id = l[0]
				item.name = l[1]
				item.cost["sale"] = l[2]
				item.cost["standerd"] = l[3]
				@goods.push(item)
			end
		end
		@goods
	end
	def each
		for item in @goods
			yield item
		end
	end
end

def get_cost(item, yml)
	keys = item.parce_type
	if keys.count == 3 then
		begin
			yml[keys[0]][keys[1]][keys[2]]
		rescue
			nil
		end
	end
end

daifujidata = YAML.load_file("./daifuji_DNL.yaml")
g = Goods.new.openfile
g.each do |item|
	dnldata = item.dnl_sprit
	if dnldata
		if cost = get_cost(item, daifujidata)
			item.cost["daifuji"] = cost.to_i
		end
		puts "#{item.id} : #{item.name} : #{item.cost["sale"].to_s} : #{item.cost["standerd"].to_s} : #{item.cost["daifuji"].to_s}"
	end
end
