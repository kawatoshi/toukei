# -*- coding: utf-8 -*-
module Inputkey
	require './imekey'
#	require 'imekey'
	include Imekey
	
	class Inputkey
		def initialize(str, yomigana = nil)
			@word = Imekey::Word.new(str)
			set_source(str, yomigana)
		end
		def set_source(str, yomigana = nil)
			@word.set_source(str)
			@word.yomigana = yomigana if yomigana
		end
		def source
			@word.source
		end
		def romaji
			@word.ime
		end
		def kanakan
			romaji.each do |w|
				if w[1] == Moji::ZEN_KATA
					kana_input(w[0])
				else
					direct_input(w[0])
				end	
			end
		end
		def kana
			words = romaji.map {|w| w[0]}
			oemsplit(words.join)
			key_wait
			enter
		end
		def kana_meigi
			romaji.each do |w|
				oemsplit(w[0].gsub(/x/, "").gsub(/OEM\(\-\)/, "-"))
			end
			key_wait
			enter
		end
		def hiragana
			@word.hiragana
		end
		def key_wait(ms = 150)
			puts ms
		end
		def key(str)
			puts "key #{str}"
		end
		def space(n = 1)
			case n
			when 1, 2
				n.times{ puts "space" }
			else
				puts "<r #{n}>"
				puts "space"
				puts "</r>"
			end
		end
		def enter(n = 1)
			case n
			when 1, 2
				n.times{ puts "enter" }
			else
				puts "<r #{n}>"
				puts "enter"
				puts "</r>"
			end
		end
		def henkan
			key_wait(100)
			space
			key_wait
			enter
		end
		def kanjikey
			key_wait
			puts "LCtrl Down"
			puts "変換"
			puts "LCtrl Up"
			key_wait
		end
		def syubetu(str)
			case str
			when '先方'
				puts '→'
			else
				puts '←'
			end
			enter(1)
		end
		def kouza_syubetu(str)
			case str
			when '当'
				puts '←'
			else
				puts '→'
			end
			enter(1)
		end
		private
		def direct_input(word)
			kanjikey
			oemsplit(word)
			key_wait
			enter
			kanjikey
			key_wait
		end
		def kana_input(word)
			key_wait(100)
			oemsplit(word)
			henkan
		end
		def oemsplit(word)
			ws = word.split
			ws.each do |w|
				case w
				when /^OEM\(.\)/
					puts w
				else
					key w
				end
			end
		end
	end
end
