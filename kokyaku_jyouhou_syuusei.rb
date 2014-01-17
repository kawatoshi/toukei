#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

def touroku
	puts "300"
	puts "F12"
	puts "900"
	puts "enter"
	puts "1700"
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

open(ARGV[0].chomp, 'r') do |io|
	honten = Inputkey::Inputkey.new("")
	honten_kana = Inputkey::Inputkey.new("")
	honten_ryaku = Inputkey::Inputkey.new("")
	siten = Inputkey::Inputkey.new("")
	siten_kana = Inputkey::Inputkey.new("")
	siten_ryaku = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		k_id = ary[0].to_i
		k_sub = ary[1].to_i
		work = workdivision(ary[3])
		bill = billdivision(ary[4])
		honten.set_source(ary[5], ary[5])
		honten_kana.set_source(ary[8], ary[8])
		honten_ryaku.set_source(ary[9], ary[9])
		siten.set_source(ary[11], ary[11])
		siten_kana.set_source(ary[14], ary[14])
		siten_ryaku.set_source(ary[9], ary[9])

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
		if k_sub == 0 then
			honten.kanakan
			honten.enter
			honten_kana.kana
			honten.enter
			honten_ryaku.kanakan
			honten.enter
			num = 15
		else
			siten.kanakan
			siten.enter
			siten_kana.kana
			siten.enter
			siten_ryaku.kanakan
			siten.enter
			num = 8
		end

		puts <<"COMMAND2"
<r #{num}>
enter
</r>

delete
F4
key #{work}
100
enter

enter
delete
F4
key #{bill}
enter
COMMAND2
#		break
		touroku
	end
end

