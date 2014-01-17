#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

def touroku
	puts "300"
	puts "F12"
	puts "800"
	puts "enter"
	puts "900"
end

open(ARGV[0].chomp, 'r') do |io|
	while line = io.gets
		ary = line.split(/\t/)
		k_id = ary[0].to_i
		s_id = ary[2]
		kouza = ary[5].gsub(/\s+/, '')
		kouza2 = ary[5].split[-1]
		puts <<"COMMAND1"
key #{k_id}
Enter
Enter
Enter
1000
keys Ctrl+Tab
300

<r 3>
keys shift+tab
100
</r>

key #{s_id}
Enter
Enter

<r 29>
enter
</r>

F4
↑
200
enter
200
enter

key #{kouza}
100
enter

F4
↓
200
enter
enter

key 2
enter
100
key 0
enter
100

enter
key #{kouza2}
enter
100
key nasi
200
enter

100
enter
enter
200
space
200
COMMAND1
#		break
		touroku
	end
end

