def times_two(integer_array)
  integer_array.map { |num| num * 2 }
end




class Array
  def my_each
    index = 0
    while index < self.length
      yield(self[index])

      index += 1
    end

    self
  end
end

def median(integer_array)
  sorted_array = integer_array.sort
  if sorted_array.length.odd?
    sorted_array[sorted_array.length / 2]
  else
    (sorted_array[sorted_array.length / 2 - 1] + sorted_array[sorted_array.length / 2]) / 2.0
  end
end


def concatenate(strings)
  strings.inject(:+)
end


# p times_two([1, 2, 3, 4])

# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end

# p median([1, 3, 2, 4])

p concatenate(["Yay ", "for ", "strings!"])