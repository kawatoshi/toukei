#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

def find_data(k_id, k_sub)
		puts <<"COMMAND1"
key #{k_id}
100
enter
key #{k_sub}
<r 2>
Enter
</r>
700
COMMAND1
end

def tab_chenge
	puts <<"COMMAND"
keys ctrl+tab
500
COMMAND
end

def input_seikyuusaki_code(s_id)
	puts <<"COMMAND"
500
<r 3>
keys shift+tab
100
</r>
key #{s_id}
100
enter
enter
400
COMMAND
end

def touroku
	puts "300"
	puts "F12"
	puts "2000"
	puts "enter"
	puts "1000"
end
def workdivision(str)
	case str
	when "外部"
		"↓↓↓↓"
	else
		"↓↓"
	end
end
def billdivision(str)
	case str
	when "請求"
		"↓"
	when "テナント控除"
		"↓↓↓↓"
	when "納伝"
		"↓↓↓"
	else
		"↓"
	end
end
def hakkou_off
		puts <<"COMMAND"
<r 23>
enter
</r>
100
F4
↓
enter
200
<r 15>
enter
</r>
300
space
200
COMMAND
end

open(ARGV[0].chomp, 'r') do |io|
	while line = io.gets
		ary = line.split(/\t/)
		k_id = ary[0].to_i
		k_sub = 0
		s_id = ary[1].to_i

		find_data(k_id, k_sub)
		tab_chenge
		input_seikyuusaki_code(s_id)
		hakkou_off
		touroku
	end
end

