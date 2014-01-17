#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	s_name = Inputkey::Inputkey.new("")
	furigana = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		s_code = ary[0]
		s_name.set_source(ary[2], ary[1])
		furigana.set_source(ary[3])
		u_tanka = ary[6]
		s_tanka = ary[7]
		sagyou_code = ary[4]
		utiwake_code = ary[5]
		siire_code = ary[8]
		siire_eda = "0"

		s_name.key s_code
		s_name.enter 2
		s_name.key_wait 800
		s_name.kanakan
		s_name.enter
		furigana.kana
		s_name.enter
		puts "F4"
		s_name.key_wait 400
		puts "delete"
		puts "↓"
		puts "↓"
		s_name.enter 2
		s_name.enter 3
		s_name.key sagyou_code
		s_name.key_wait
		s_name.enter
		s_name.key utiwake_code
		s_name.key_wait
		s_name.enter
		s_name.key u_tanka
		s_name.enter 5
		s_name.key_wait
		puts "tab"
		s_name.key s_tanka
		s_name.key_wait
		s_name.enter 2
		s_name.key siire_code
		s_name.enter
		s_name.key siire_eda
		s_name.enter
		s_name.key s_tanka
		s_name.enter
		puts "space"

		puts "F12"
		s_name.key_wait(700)
		s_name.enter
		s_name.key_wait(900)
	end
end

