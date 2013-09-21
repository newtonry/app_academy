def guess
  rand_int = (1..100).to_a.sample

  count = 0

  loop do

    guess = gets.chomp.to_i
    count += 1

    puts "Too low" if guess < rand_int
    puts "Too high" if guess > rand_int


    break if guess == rand_int
  end

  puts "You took #{count} guesses"


end

guess