#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'cgi'
require 'erb'
require 'yaml'
require './module/buppan'

def camma(num)
	num.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse
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
table = CSV.read('/var/data/buppan/buppan.csv', encoding: "SJIS:UTF-8")
buppan = Buppan::BuppanList.new(table)
utiwake_list = buppan.utiwake_gaibu_on_honten(cgi["keijyou_id"])
erb = ERB.new(File.read('../rhtml/g_utiwake_contents.rhtml'), nil, '-')
txt = erb.result(binding)
pagenate_contents = pagenate_str(txt, 40, 40)
erb = ERB.new(File.read('../rhtml/g_utiwake.rhtml'), nil, '-')
puts "Content-Type:text/html; charset=utf-8\n\n"
puts erb.result(binding)
