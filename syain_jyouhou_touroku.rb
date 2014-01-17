#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

def input_sex(num)
	puts "F4"
	puts "key ↑↑↑"
	case num
	when "2"
		puts "key ↓"
	end
	puts "enter"
end
def input_anbun(code)
	puts "key 100000"
	puts "enter"
	puts "200"
	puts "key 0"
	puts "enter"
	puts "key 800000"
	puts "enter"
	puts "200"
	puts "key 0"
	puts "enter"
	puts "key 1"
	puts "enter"
	puts "100"
	puts "key 1000"
	puts "enter"
	puts "100"
	puts "key 1000"
	puts "enter"
	puts "100"
	puts "key 100"
	puts "enter"
	puts "100"
	puts "key #{code}"
	puts "enter"
	puts "enter"
	puts "space"
end
def input_anbun_keisan
	puts "F4"
	puts "key ↓"
	puts "enter"
end

open(ARGV[0].chomp, 'r') do |io|
	syain = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		s_id = ary[5]
		syain.set_source(ary[1], ary[6])
		s_code = ary[0]
		syozoku = ary[3]
		sex = ary[4]

		syain.key s_id
		syain.enter 2
		syain.key_wait 600
		syain.kanakan
		syain.enter
		syain.kana
		syain.enter
		syain.key syozoku
		syain.enter
		input_anbun_keisan
		syain.enter 4
		syain.key s_code
		syain.enter 3
		input_sex sex
		syain.key_wait 300
		puts "F12"
		syain.key_wait 700
		puts "LMouse Down (1943,596)"
		puts "LMouse Up (1943,596)"
		syain.key_wait 100
	end
end

