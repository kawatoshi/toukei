#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	while line = io.gets
		ary = line.split
		bankid = ary[1]
		sitenid = ary[4]
		siten = Inputkey::Inputkey.new(ary[3], ary[2])

		siten.key bankid
		siten.enter
		siten.key_wait
		siten.key sitenid
		siten.enter
		siten.enter
		siten.key_wait(700)
		siten.enter(2)
		siten.kanakan
		siten.enter
		siten.kana
		siten.enter
		puts "F12"
		siten.key_wait(400)
		puts "LMouse Down (670,580)"
		siten.key_wait
		puts "LMouse Up (670,580)"
		siten.key_wait(500)
	end
end
