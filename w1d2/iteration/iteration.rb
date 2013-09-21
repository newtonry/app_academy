require 'set'
def looper
  i = 0
  until i > 250 and i % 7 == 0
    i += 1
  end
  i
end

def factors(number)
  (1..number).select do |i|
    number % i == 0
  end
end

def bubble_sort unsorted_array
  sorted = unsorted_array.dup

  stop = 0
  while stop == 0
    stop = 1

    sorted[0..-2].each_with_index do |el, i|
      if el > sorted[i+1]
        sorted[i], sorted[i+1] =  sorted[i+1], el
        stop = 0
      end
    end
  end
  sorted
end

def substrings bigstring
  substrings = []
  (0...bigstring.length).each do |i|
    (i...bigstring.length).each do |j|
      substrings << bigstring[i..j]
    end
  end
  substrings.uniq
end

def subwords bigstring
  dictionary = Set.new()
  File.foreach("dictionary.txt") do |line|
    dictionary << line.chomp
  end
  substrings(bigstring).select do |substring|
    dictionary.include?(substring)
  end
end




p subwords("catapult")
#p bubble_sort([2,3,7,1,2])
#p looper
#p factors(12)


