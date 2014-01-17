#!/usr/bin/ruby
# -*- coding: utf-8 -*-

open(ARGV[0].chomp, 'r') do |io|
	while line = io.gets
		ary = line.split(/\t/)
		num = ary[0]

		puts <<"KOUMOKU"
key #{num}
Enter
Enter
Enter
600
Enter
Enter
Enter
Enter
Enter
Delete
F12
1200
Enter
500
KOUMOKU
	end
end
