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
	CSV.read('/var/data/buppan/buppan.csv', encoding: "SJIS:UTF-8")
end
cgi = CGI.new
data = YAML.load_file('/var/data/buppan/config/config.yaml')
table = get_table(nil)
c = Buppan::BuppanList.new(table)
m_list = c.utiwake_with_honten_siten(data["honten_code"], cgi["siten"], "nomal")
t_lists = c.utiwake_koujyo_on_honten(cgi["keijyou_id"])
g_lists = c.utiwake_gaibu_on_honten(cgi["keijyou_id"])
t_lists_total_price = t_lists.total_price
case cgi["list_name"]
when "bill_list"
	erb = ERB.new(File.read('../rhtml/bill_list.rhtml'), nil, '-')
when "earnings_report"
	cost_of_t_and_g = t_lists.total_cost + g_lists.total_cost
	gain = t_lists_total_price - cost_of_t_and_g
	erb = ERB.new(File.read('../rhtml/earnings_report.rhtml'), nil, '-')
end
puts "Content-Type:text/html; charset=utf-8\n\n"
puts erb.result(binding)
