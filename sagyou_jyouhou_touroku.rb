#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	sagyou = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		s_id = ary[0]
		sagyou.set_source(ary[1], ary[2])
		g_code = ary[3]

		sagyou.key s_id
		sagyou.enter 2
		sagyou.key_wait 600
		sagyou.kanakan
		sagyou.enter
		sagyou.kana
		sagyou.enter
		sagyou.kanakan
		sagyou.enter
		sagyou.key g_code
		sagyou.enter
		puts "F4"
		puts "delete"
		puts "↓"
		sagyou.enter 2
		puts "F12"
		sagyou.key_wait 700
		puts "LMouse Down (1943,596)"
		puts "LMouse Up (1943,596)"
		sagyou.key_wait 700
	end
end

