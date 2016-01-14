#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require './inputkey'
include Inputkey

open(ARGV[0].chomp, 'r') do |io|
	kokyaku = Inputkey::Inputkey.new("")
	kokyaku_kana = Inputkey::Inputkey.new("")
	kokyaku_ryaku = Inputkey::Inputkey.new("")
	while line = io.gets
		ary = line.split(/\t/)
		k_id = ary[0]
		kokyaku.set_source(ary[2], ary[1])
		kokyaku_kana.set_source(ary[2], ary[3])
		kokyaku_ryaku.set_source(ary[4], ary[4])
		seikyuusaki_code = ary[6]
		busyo = ary[7]

		puts <<"COMMAND1"
key #{k_id}
<r 3>
Enter
</r>
700
COMMAND1
		kokyaku.kanakan
		kokyaku.enter
		kokyaku_kana.kana
		kokyaku.enter
		kokyaku_ryaku.kanakan
		kokyaku.enter

		puts <<"COMMAND2"
<r 15>
enter
</r>

F4
key ↓↓
100
enter

enter
F4
key ↓
enter

100
F3

200
key #{seikyuusaki_code}
enter
enter

300
enter

<r 14>
enter
</r>

key #{busyo}
enter
300

<r 13>
enter
</r>

F4
100
key ↓
enter
200

<r 10>
enter
</r>

200
space

300
F12
700
enter
900
COMMAND2
	end
end

