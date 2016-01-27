#!/usr/bin/ruby
# -*- coding: utf-8 -*-

open(ARGV[0].chomp, 'r') do |io|
	while line = io.gets
		ary = line.split(/\t/)
		s_code = ary[0]
		u_tanka = ary[2]

		puts "key #{s_code}"
		puts "enter"
		puts "enter"
		puts "800"
		puts "<r 8>"
		puts "enter"
		puts "</r>"
		puts "key #{u_tanka}"
		puts "enter"
		puts "400"
		puts "LMouse Down (1057,1231)"
		puts "LMouse Up (1057,1231)"
		puts "1200"
		puts "enter"
		puts "900"
		puts ""
	end
end

