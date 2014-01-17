#!/usr/bin/ruby
# -*- coding: utf-8 -*-

open(ARGV[0].chomp, 'r') do |io|
	while line = io.gets
		ary = line.split(/\t/)
		name = ary[0]
		yotei = ary[1]
		units = ary[2]

		puts <<"KOUMOKU"
enter
enter
@#{name}
100
enter
enter
@#{yotei}
100
<r 13>
enter
20
</r>
F4
key ↓
enter
100
enter
key #{units}
enter
<r 7>
enter
</r>
200
space
300
<r 21>
tab
</r>
F4
#key ↓
enter
100
enter
key #{units}
200
<r 8>
enter
200
</r>
space
300
<r 38>
keys Shift+Tab
</r>
50
F4
key ↓
100
enter
300
KOUMOKU
	end
end
