def rps user_choice
  comp_choice = ['rock', 'paper', 'scissors'].sample

  game_result = ""

  if comp_choice == user_choice
    game_result = "Tie"
  else
    case user_choice
    when 'rock'
      if comp_choice == 'paper'
        game_result = "Loss"
      else
        game_result = 'Won'
      end

    when 'paper'
      if comp_choice == 'scissors'
        game_result = "Loss"
      else
        game_result = 'Won'
      end

    when 'scissors'
      if comp_choice == 'rock'
        game_result = "Loss"
      else
        game_result = 'Won'
      end
    end
  end

  "#{comp_choice}, #{game_result}"

end

user_choice = gets.chomp

until ['rock', 'paper', 'scissors'].include?(user_choice)
  puts "Please enter a valid choice:"
  user_choice = gets.chomp
end

puts rps user_choice