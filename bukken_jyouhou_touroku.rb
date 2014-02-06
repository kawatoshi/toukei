#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

def touroku
	puts "300"
	puts "F12"
	puts "1000"
	puts "enter"
	puts "700"
end
def kensaku
	puts <<"COMMAND1"
key #{b_id}
Enter
Enter
Enter
1000
COMMAND1
end

open(ARGV[0].chomp, 'r') do |io|
	tatemono = Inputkey::Inputkey.new("")
	tatemono_kana = Inputkey::Inputkey.new("")
	tatemono_ryaku = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		b_id = ary[0]
		tatemono.set_source(ary[2], ary[2])
		tatemono_kana.set_source(ary[4], ary[4])
		tatemono_ryaku.set_source(ary[5], ary[5])
		kensaku
		tatemono.kanakan
		tatemono.enter
		tatemono_kana.kana
		tatemono.enter
		tatemono_ryaku.kanakan
		tatemono.enter
#		break
		touroku
	end
end

