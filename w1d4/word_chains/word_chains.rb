class WordChains
  @current_words = []
  @visited_words = []

  def make_regexes (word)
    regexes = []

    word.length.times do |index|
      regex = word.split('')
      regex[index] = '\w'
      regexes << regex.join('')
    end
    regexes
  end


  def open_dictionary
    File.readlines('./dictionary.txt').map do |word|
      word.chomp
    end
  end

  def adjacent_words(word, dictionary)
   # @visited_words << word


    dictionary.select do |dict_word|
      dict_word.length == word.length && adjacent?(word, dict_word)
    end
  end

  def adjacent? (word1, word2)
    regexes = make_regexes(word1)
    regexes.each do |regex|
      if word2.match(regex)
        return true
      end
    end
    false
  end

  def find_chain(start_word, end_word, dictionary)
    @current_words << word
    new_words = adjacent_words(word, open_dictionary)

    loop do

      new_words =
      @visited.push(*new_words)

      if

    end

  end

end

thing = WordChains.new

#puts thing.adjacent_words("cat", thing.open_dictionary)
