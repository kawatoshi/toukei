#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	kokyaku = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		kokyaku_id = ary[0]
		seikyuu_id = ary[4]
		kokyaku.set_source(ary[6], ary[5])
		ryaku_name = ary[7]
		busyo_id = ary[8]

		puts <<"EOS"
key #{kokyaku_id}
enter
0
enter
enter
700
keys Ctrl+tab
500

<r 3>
keys Shift+tab
100
</r>
key #{seikyuu_id}
enter
enter
600
EOS
		puts <<"COM"
enter
enter
半角/全角
key #{ryaku_name}
Enter
300
<r 35>
enter
30
</r>
300
space
600
COM
		break
		puts "F12"
		kokyaku.key_wait 900
		kokyaku.enter
		kokyaku.key_wait 1100
	end
end

