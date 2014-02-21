#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'cgi'
require 'erb'
require './module/buppan'

def camma(num)
	num.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse
end
cgi = CGI.new
honten = cgi["honten"]
table = CSV.read('/var/data/buppan/buppan.csv')
c = Buppan::BuppanList.new(table)
u = c.utiwake_with_honten_siten(cgi["honten_code"], cgi["siten"], "nomal")
erb = ERB.new(File.read('../rhtml/m_utiwake.rhtml'), nil, '-')
puts "Content-Type:text/html; charset=utf-8\n\n"
puts erb.result(binding)
