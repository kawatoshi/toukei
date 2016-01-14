#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	sasidasi = Inputkey::Inputkey.new("")
	mei = Array.new
	while line = io.gets
		ary = line.split(/\t/)
		s_id = ary[0]
		mei[0] = ary[1]
		mei[1] = ary[3]
		mei[2] = ary[5]
		mei[3] = ary[7]
		mei[4] = ary[9]
		mei[5] = ary[11]
		mei[6] = ary[13]
		mei[7] = ary[15]

		sasidasi.key s_id
		sasidasi.enter
		sasidasi.key_wait
		0.upto(7) do |i|
			sasidasi.set_source(mei[i], mei[i])
			sasidasi.kanakan
			sasidasi.enter
		end
		sasidasi.enter 8
		sasidasi.key_wait 300
		puts "space"
	end
	puts "300"
	puts "F12"
	puts "1000"
	puts "enter"
	puts "2000"
	puts "shift+tab"
	puts "500"
	puts "F4"
	puts "500"
	puts "↓"
	puts "Enter"
end

