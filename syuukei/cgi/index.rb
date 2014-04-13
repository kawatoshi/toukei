#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'yaml'
require 'erb'

data = YAML.load_file('/var/data/buppan/config/config.yaml')
erb = ERB.new(File.read('../rhtml/index.rhtml'), nil, '-')

def get_param(content, m_list_one)
	ary = []
	content["params"].each{|key|
		if m_list_one["params"][key] then
			ary << "#{key}=#{m_list_one["params"][key]}"
		end
	}
	"#{content["command"]}#{ary.join("&")}"
end
title = data["main"]["title"]
puts "Content-Type:text/html; charset=utf-8\n\n"
puts erb.result(binding)
#p get_param(data["main"]["contents"][2], data["m_list"][0])
#data["main"]["contents"].each{|con|
#	puts con["name"]
#	data["m_list"].each{|list_one|
#		puts get_param(con, list_one)
#	}
#}
