require 'debugger'

def num_to_s num, base
#  debugger

key = (("0".."9").to_a << ("A".."F").to_a).flatten


  output_string = ''

  while num > 0
    output_string << key[(num%base)]
    num = num/base
  end

  output_string.reverse

end


# p num_to_s(1234, 16)

def caesar(word, shift)
  output = ""

  word.each_char do |char|
    if ("a".."z").include?(char)
      output << shift_character(char, shift)
    else
      output << char
    end
  end

  output
end

def shift_character(char, shift)
  offset = "a".ord
  ((char.ord + shift - offset) % 26 + offset).chr
end

p caesar("helloz allz!", 29)