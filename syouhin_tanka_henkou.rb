#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	s_name = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		s_code = ary[0]
		u_tanka = ary[2]

		s_name.key s_code
		s_name.enter 2
		s_name.key_wait 800
		s_name.enter 8
		s_name.key u_tanka
		s_name.enter
		s_name.key_wait 400

		puts "F12"
		s_name.key_wait(700)
		s_name.enter
		s_name.key_wait(900)
	end
end

