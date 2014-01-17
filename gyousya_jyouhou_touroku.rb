#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	while line = io.gets
		ary = line.split(/\t/)
		gyousyaid = ary[0]
		kouzaname = ary[1]
		yomigana = ary[2]
		gyousyaname = ary[3]
		bankid = ary[5]
		sitenid = ary[7]
		syu = ary[8]
		kouza = ary[9]
		tesuuryou = ary[10]
		kouzameigi = Inputkey::Inputkey.new(kouzaname)
		gyousyamei = Inputkey::Inputkey.new(gyousyaname, yomigana)

		gyousyamei.key gyousyaid
		gyousyamei.enter(3)
		gyousyamei.key_wait(700)
		gyousyamei.kanakan
		gyousyamei.enter
		gyousyamei.kana
		gyousyamei.enter
		gyousyamei.kanakan
		gyousyamei.enter(17)
		gyousyamei.key bankid
		gyousyamei.enter
		gyousyamei.key sitenid
		gyousyamei.enter
		gyousyamei.kouza_syubetu kouza
		gyousyamei.key kouza
		gyousyamei.enter
		kouzameigi.kana_meigi
		kouzameigi.enter
		gyousyamei.syubetu syu
		gyousyamei.key_wait(600)
		puts "F12"
		gyousyamei.key_wait(1200)
		puts "LMouse Down (1967,595)"
		gyousyamei.key_wait(100)
		puts "LMouse Up (1967,595)"
		gyousyamei.key_wait(1000)
	end
end
