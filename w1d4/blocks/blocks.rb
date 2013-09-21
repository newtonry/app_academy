class Array
  def my_each (&block)
    length.times do |index|
      block.call(self[index])
    end
    self
  end

  def my_map (&block)
    mapped_array = []
    my_each do |element|
      mapped_array << block.call(element)
    end
    mapped_array
  end

  def my_select (&block)
    selected_array = []

    my_each do |element|
      selected_array << element if block.call(element)
    end
    selected_array
  end

  def my_inject (&block)
    return_value = self[0]

    self[1..-1].my_each do |element|
      return_value = block.call(return_value,element)
    end

    return_value
  end

  def my_sort!(&block) # think about how to do this with my_each
    length.times do |time|
      (length - time).times do |index|
        if block.call(self[index], self[index + 1]) == 1
          self[index], self[index + 1] = self[index + 1], self[index]
        end
      end
    end

    self
  end
end


def splat_into_block (*arr, &prc)
  raise "NO BLOCK GIVEN!" if prc.nil?
  p arr
  # p *arr

  prc.call(*arr)


end

splat_into_block(1,2,3) {|a, b, c| p a, b, c}




# [1, 3, 5].my_sort! { |num1, num2| num1 <=> num2 }

# p [1, 3, 6, 89, 2, 14, 26, 21, 11, 2].my_sort! { |num1, num2| num1 <=> num2 }


# [1,2,3].my_each do |n|
#   puts n + 1
# end
#
# a = [1,2,3].my_map do |element|
#   element + 1
# end
#
# p a
#
# x = [1,2,3,4,5,6].my_select do |n|
#   n.odd?
# end
#
# puts x

# x = [1,2,3,4].my_inject {|orig, newer| orig + newer }
#
#
# puts x