#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'cgi'
require 'erb'
require 'yaml'
require './module/buppan'

def camma(num)
	num.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse
end
cgi = CGI.new
publish_format = cgi["publish_format"]
data = YAML.load_file('/var/data/buppan/config/config.yaml')
case publish_format
when "negai"
	main_title = data["negai"]["title"]
	signature = true
else
	main_title = data["m_utiwake"]["title"]
	signature = false
end
first_page_rows = data["first_page_rows"]
other_page_rows = data["other_page_rows"]
table = CSV.read('/var/data/buppan/buppan.csv', encoding: "SJIS:UTF-8")
c = Buppan::BuppanList.new(table)
u = c.utiwake_with_honten_siten(cgi["honten_code"], cgi["siten"], "nomal")
pagenate_u = u.pagenate_lines(first_page_rows, other_page_rows)
pages = pagenate_u.size
erb = ERB.new(File.read('../rhtml/m_syounin.rhtml'), nil, '-')
puts "Content-Type:text/html; charset=utf-8\n\n"
puts erb.result(binding)
