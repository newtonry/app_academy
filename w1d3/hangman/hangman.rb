class Hangman
  def initialize(chooser = nil, guesser = nil)
    @chooser, @guesser = chooser, guesser
  end

  def play
    get_players if @chooser == nil

    result = @chooser.choose_word
    puts result
    num_guesses = 0

    while result.include?("_")
      puts "Previously guessed letters: #{@guesser.guessed_letters.to_s}" unless @guesser.guessed_letters.empty?
      result = @chooser.check_guess(@guesser.prompt_guess(result))
      num_guesses += 1
      puts result
    end

    puts "The guesser has won in #{num_guesses} guesses!"
  end

  def get_players
    @chooser = make_player("chooser")
    @guesser = make_player("guesser")
  end

  def make_player(type)
    puts "Would you like the #{type} to be H or C:"
    gets.chomp.upcase == "H" ? HumanPlayer.new : ComputerPlayer.new
  end
end

class HumanPlayer
  attr_reader :guessed_letters

  def initialize
    @guessed_letters = []
  end

  def choose_word
    puts "Choose a word and remember it. How many letters are in it?"
    @guessed = "_" * gets.chomp.to_i
  end

  def check_guess guess
    puts "The other player has guessed the letter \"#{guess}\". Which positions contain that letter? Separate with spaces. Hit enter if none"
    positions = gets.strip.split.map { |pos| pos.to_i - 1 }
    positions.each { |pos| @guessed[pos] = guess }

    @guessed
  end

  def prompt_guess guessed
    guess = nil
    until ("a".."z").include?(guess)
      puts "Guess a letter:"
      guess = gets.strip.downcase
    end
    @guessed_letters << guess
    guess
  end
end


class ComputerPlayer
  attr_reader :guessed_letters

  def initialize
    @possible_words, @guessed_letters = [], []
    @dictionary = File.readlines("dictionary.txt").map do |line|
      line.chomp.downcase.gsub("-" ,"")
    end
  end

  def choose_word
    puts "How long should the word be? 0 or hit enter for random:"
    input = gets.chomp
    word_size = input.empty? ? 0 : input.to_i
    @word = @dictionary.select do |line|
      word_size == 0 || line.length == word_size
    end.sample.downcase
    @guessed = "_" * @word.length.to_i
  end

  def check_guess guess
    @word.each_char.with_index do |letter, index|
      @guessed[index] = letter if letter == guess
    end
    @guessed
  end

  def prompt_guess guessed
    if @possible_words.empty?
      @possible_words = get_possible_words guessed.length
    else
      filter_possibilities guessed
    end

    raise "Impossible word" if @possible_words.empty?
    guess_letter = most_frequent_possible_letter
    @guessed_letters << guess_letter
    guess_letter
  end

  def get_possible_words word_size
    @possible_words = @dictionary.select { |line| line.length == word_size }
  end

  def most_frequent_possible_letter
    frequencies = Hash.new(0)
    possible_characters = (@possible_words.join("").split("") - @guessed_letters)

    possible_characters.each do |letter|
      frequencies[letter] += 1
    end

    frequencies.sort_by { |letter, frequency| -frequency }.first.first
  end

  def filter_possibilities guessed
    @possible_words = @possible_words.select do |word|
      possible = true
      word.each_char.with_index do |letter, index|
        if (@guessed_letters.include?(letter) && !guessed.include?(letter)) || (guessed[index] != "_" && guessed[index] != letter)
          possible = false
          break
        end
        possible
      end
    end
  end
end

Hangman.new.play