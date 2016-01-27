#!/usr/bin/ruby

item = []
File.open("./genka.txt") do |lines|
	lines.each do |line|
		l = line.strip.split(/\t/)
		puts "key #{l[0]}"
		puts "enter"
		puts "enter"
		puts "900"
		puts "<r 16>"
		puts "tab"
		puts "</r>"
		puts "300"
		puts "key 6"
		puts "enter"
		puts "key 1"
		puts "enter"
		puts "key #{l[3]}"
		puts "enter"
		puts "100"
		puts "space"
		puts "LMouse Down (2215,810)"
		puts "LMouse Up (2215,810)"
		puts "1800"
		puts "enter"
		puts "500"
		puts ""
	end
end

