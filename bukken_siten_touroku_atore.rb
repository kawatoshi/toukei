#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	siten = Inputkey::Inputkey.new("")
	ryaku = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		tatemono_id = ary[0]
		siten_id = ary[1]
		siten.set_source(ary[5])
		ryaku.set_source(ary[7])

		siten.key tatemono_id
		siten.enter
		siten.key siten_id
		siten.enter 2
		siten.key_wait 800
		siten.enter
		siten.key_wait 500
		siten.kanakan
		siten.enter
		siten.enter
		ryaku.kanakan
		ryaku.enter
		siten.key_wait 300
		puts "F12"
		siten.key_wait 800
		siten.enter
		siten.key_wait 500
	end
end

