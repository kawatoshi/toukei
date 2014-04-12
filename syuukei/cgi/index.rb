#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'yaml'
require 'erb'

data = YAML.load_file('/var/data/buppan/config/config.yaml')
erb = ERB.new(File.read('../rhtml/index.rhtml'), nil, '-')
title = data["main"]["title"]
puts "Content-Type:text/html; charset=utf-8\n\n"
puts erb.result(binding)
