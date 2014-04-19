#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'cgi'
require 'erb'
require 'yaml'
require './module/buppan'

def camma(num)
	num.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse
end
def get_table(filename)
	if filename then
		CSV.read("/var/data/buppan/old/buppan_#{filename}.csv", encoding: "SJIS:UTF-8")
	else
		CSV.read('/var/data/buppan/buppan.csv', encoding: "SJIS:UTF-8")
	end
end
def pagenate_str(txt, first_page_row, other_row)
	lines = txt.split("\n")
	if lines.size <= first_page_row -1
		[] << lines
	else
		first_page_lines = lines.each_slice(first_page_row).first
		other_lines = lines[first_page_row..-1].each_slice(other_row).to_a
		other_lines.unshift(first_page_lines)
	end
end
cgi = CGI.new
data = YAML.load_file('/var/data/buppan/config/config.yaml')
case cgi["filename"]
when /\A\d{6}/
	table = get_table(cgi["filename"])
else
	table = get_table(nil)
end
c = Buppan::BuppanList.new(table)
case cgi["list_name"]
when "m_syounin", "m_utiwake"
	case cgi["list_name"]
	when "m_syounin"
		main_title = data["negai"]["title"]
		signature = true
	else
		main_title = data["m_utiwake"]["title"]
		signature = false
	end
	u = c.utiwake_with_honten_siten(data["honten_code"], cgi["siten"], "nomal")
	pagenate_u = u.pagenate_lines(data["first_page_rows"], data["other_page_rows"])
	pages = pagenate_u.size
	erb = ERB.new(File.read('../rhtml/m_syounin.rhtml'), nil, '-')
when "t_utiwake"
	utiwake_list = c.utiwake_koujyo_on_honten(cgi["keijyou_id"])
	erb = ERB.new(File.read('../rhtml/t_utiwake_contents.rhtml'), nil, '-')
	txt = erb.result(binding)
	pagenate_contents = pagenate_str(txt, data["t_utiwake"]["first_page_rows"], data["t_utiwake"]["other_page_rows"])
	erb = ERB.new(File.read('../rhtml/t_utiwake.rhtml'), nil, '-')
when "g_utiwake"
	utiwake_list = c.utiwake_gaibu_on_honten(cgi["keijyou_id"])
	erb = ERB.new(File.read('../rhtml/g_utiwake_contents.rhtml'), nil, '-')
	txt = erb.result(binding)
	pagenate_contents = pagenate_str(txt, data["t_utiwake"]["first_page_rows"], data["t_utiwake"]["other_page_rows"])
	erb = ERB.new(File.read('../rhtml/g_utiwake.rhtml'), nil, '-')
when "bill_list"
	m_list = c.utiwake_with_honten_siten(data["honten_code"], cgi["siten"], "nomal")
	t_lists = c.utiwake_koujyo_on_honten(cgi["keijyou_id"])
	g_lists = c.utiwake_gaibu_on_honten(cgi["keijyou_id"])
	t_lists_total_price = t_lists.total_price
	erb = ERB.new(File.read('../rhtml/bill_list.rhtml'), nil, '-')
when "earnings_report"
	m_list = c.utiwake_with_honten_siten(data["honten_code"], cgi["siten"], "nomal")
	t_lists = c.utiwake_koujyo_on_honten(cgi["keijyou_id"])
	g_lists = c.utiwake_gaibu_on_honten(cgi["keijyou_id"])
	t_lists_total_price = t_lists.total_price
	cost_of_t_and_g = t_lists.total_cost + g_lists.total_cost
	gain = t_lists_total_price - cost_of_t_and_g
	erb = ERB.new(File.read('../rhtml/earnings_report.rhtml'), nil, '-')
end
puts "Content-Type:text/html; charset=utf-8\n\n"
puts erb.result(binding)
