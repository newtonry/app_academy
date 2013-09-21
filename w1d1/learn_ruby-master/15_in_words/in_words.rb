class Fixnum
  SINGLE_NUMBERS = [
    "",         # padding, so the index of "one" is 1, etc.
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen"
  ]

  TENS = [
    "",
    "",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety"
  ]

  BIG_NUMBERS = [
    "",
    "thousand",
    "million",
    "billion",
    "trillion"
  ]

  def in_words
    return "zero" if self == 0
    return SINGLE_NUMBERS[self] if self < 20

    numbers = []

    temp_num = self
    times_looped = 0
    while temp_num > 0
      numbers << BIG_NUMBERS[times_looped] if temp_num % 1000 > 0
      numbers << zero_to_999(temp_num % 1000)

      temp_num /= 1000
      times_looped += 1
    end

    numbers.flatten.reverse.reject { |element| element.to_s.empty? }.join(" ")
  end


  private
    def zero_to_999(num)
      numbers = []
      # if num < 100
      if num % 100 < 20
        numbers << SINGLE_NUMBERS[num % 100]
      else
        numbers << SINGLE_NUMBERS[num % 10]
        numbers << TENS[num / 10 % 10]
      end

      if num / 100 > 0
        numbers << "#{SINGLE_NUMBERS[num / 100]} hundred"
      end
      # end

      numbers
    end
end