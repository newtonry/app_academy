def range(range_start, range_end)
  if range_start == range_end
    [range_start]
  else
    range(range_start, range_end - 1) + [range_end]
  end
end

def iterative_sum(numbers)
  sum = 0
  numbers.each do |number|
    sum += number
  end
  sum
end

def recursive_sum(numbers)
  if numbers.length == 1
    numbers[0]
  else
    numbers[0] + recursive_sum(numbers[1..-1])
  end
end

def exponent1(base, exponent)
  if exponent == 0
    1
  else
    base * (exponent1(base, exponent - 1))
  end
end

def exponent2(base, exponent)
  if exponent == 0
    1
  elsif exponent.even?
    square_root = exponent2(base, exponent / 2)
    square_root * square_root
  else
    base * (exponent2(base, exponent - 1))
  end
end

def deep_dup(array)
  array.map do |element|
    if element.is_a?(Array)
      deep_dup(element)
    else
      element
    end
  end
end

def fibonacci (n)
  if n == 1
    [0]
  elsif n == 2
    [0, 1]
  else
    fibs = fibonacci(n - 1)
    fibs << (fibs[-1] + fibs[-2])
  end
end

def binary_search(list, target)
  midpoint = list.length / 2
  item = list[midpoint]
  if list.length == 1 && target != list[0]
    nil
  elsif item == target
    midpoint
  elsif item < target
    location = binary_search(list[midpoint + 1..-1], target)
    if location.nil?
      location
    else
      location + midpoint + 1
    end
  else
    binary_search(list[0..midpoint], target)
  end
end


def make_change(amount, coins)
  if coins.include?(amount)
    [amount]
  elsif coins.empty?
    []
  else
    new_coins = []
    while (amount >= coins[0])
      new_coins << coins[0]
      amount -= coins[0]
    end
    new_coins + make_change(amount, coins[1..-1])
  end
end


def merge_sort numbers
  if numbers.length == 1
    numbers
  else
    midpoint = numbers.length / 2
    merge(merge_sort(numbers[0..midpoint - 1]), merge_sort(numbers[midpoint..-1]))
  end
end

def merge list1, list2
  sorted = []
  until list1.empty? || list2.empty?
    if list1.first < list2.first
      sorted << list1.shift
    else
      sorted << list2.shift
    end
  end

  sorted + list1 + list2
end


def subsets(set)
  if set.length == 1
    [set]
  else
    first = [set[0]]
    sublists = subsets(set[1..-1])
    a = [first] + sublists + sublists.map do |sublist|
      sublist + first
    end
    a.sort_by { |item| item.length }
  end
end

#p merge_sort([7,3,1,2,4,5, 8])

#p subsets(["a", "b", "c", "d"])

#p make_change(237, [25,10,5,1]) #didn't do the bonus =()



# p i = rand(20000)
#p binary_search((1..10000).to_a, i)

#p fibonacci(10)

#p range(1, 100)
#p iterative_sum([1,2,3,4,5])
#p recursive_sum([1,2,3,4,5])

#p exponent2(5,4)