#!/usr/bin/ruby
# -*- coding: utf-8 -*-

open(ARGV[0].chomp, 'r') do |io|
	while line = io.gets
		ary = line.split(/\t/)
		s_code = ary[0]

		puts "key #{s_code}"
		puts "enter"
		puts "enter"
		puts "1200"
		puts "<r 9>"
		puts "tab"
		puts "</r>"
		puts "key 8"
		puts "<r 6>"
		puts "tab"
		puts "</r>"
		puts "key 8"
		puts "enter"
		puts "500"
		puts "LMouse Down (1135,679)"
		puts "LMouse Up (1135,679)"
		puts "1000"
		puts "enter"
		puts "600"
		puts ""
	end
end

