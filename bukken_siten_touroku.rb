#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	siten = Inputkey::Inputkey.new("")
	furigana = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		tatemono_id = ary[0]
		siten_id = ary[1]
		siten.set_source(ary[2])
		furigana.set_source(ary[4])

		siten.key tatemono_id
		siten.enter
		siten.key siten_id
		siten.enter 2
		siten.key_wait 800
		siten.enter
		siten.key_wait 500
		siten.kanakan
		siten.enter
		furigana.kana
		furigana.enter
		siten.kanakan
		siten.enter
		siten.key_wait 300
		puts "F12"
		siten.key_wait 800
		siten.enter
		siten.key_wait 500
	end
end

