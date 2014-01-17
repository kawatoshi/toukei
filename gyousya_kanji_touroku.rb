#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

gyousyamei = Inputkey::Inputkey.new("")
open(ARGV[0].chomp, 'r') do |io|
	while line = io.gets
		ary = line.split(/\t/)
		gyousyaid = ary[0]
		gyousyamei.set_source(ary[2], ary[1])

		gyousyamei.key gyousyaid
		gyousyamei.enter(3)
		gyousyamei.key_wait(700)
		gyousyamei.kanakan
		gyousyamei.enter 2
		gyousyamei.kanakan
		gyousyamei.key_wait(600)
		puts "F12"
		gyousyamei.key_wait(1200)
		puts "LMouse Down (1967,595)"
		gyousyamei.key_wait(100)
		puts "LMouse Up (1967,595)"
		gyousyamei.key_wait(1000)
	end
end
