#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

def t_ryaku_name(ary)
	case ary[3]
	when ""
		ary[1]
	else
		ary[3]
	end
end
def t_ryaku_kana(ary)
	case ary[4]
	when ""
		ary[2]
	else
		ary[4]
	end
end

command = <<"EOS"
enter
key 1
enter
enter
700
key koujyo
700
space
300
enter
100
<r 11>
enter
</r>
F4
key ↓↓
enter
200
enter
F4
key ↓↓↓↓
enter
EOS

open(ARGV[0].chomp, 'r') do |io|
	kokyaku = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		kokyaku_id = ary[0]

		kokyaku.key kokyaku_id
		puts command

		puts "F12"
		kokyaku.key_wait 800
		kokyaku.enter
		kokyaku.key_wait 700
	end
end

