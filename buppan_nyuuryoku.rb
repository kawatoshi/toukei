#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	s_name = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		s_code = ary[0]
		soukoid = ary[1]
		siireid = ary[2]
		cell = ary[3]
		cost = ary[4]
		devision = ary[5]

		s_name.key s_code
		s_name.enter
		s_name.key_wait 200
		s_name.enter 2
		s_name.key soukoid
		s_name.enter
		s_name.key_wait
		s_name.key siireid
		s_name.enter
		s_name.key_wait 200
		puts "key 0"
		s_name.enter
		s_name.key cell
		s_name.enter 2
		s_name.key cost
		s_name.enter 6
		s_name.key "2"
		s_name.enter 2
		s_name.key devision
		s_name.enter 2
		puts "space"
		s_name.key_wait 600
	end
	break
	puts "F12"
	s_name.key_wait(1000)
	puts "enter"
	s_name.key_wait(100)
	puts "enter"
end

