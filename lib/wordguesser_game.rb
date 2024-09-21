class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  #attr_accessor :word_with_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if letter.nil? || letter == '' || !letter.match?(/[[:alpha:]]/)
      raise ArgumentError.new
    end
    l = letter.downcase
    if (@guesses.include? l) || (@wrong_guesses.include? l)
      false
    elsif @word.include? l
      @guesses = @guesses + l
      true
    else
      @wrong_guesses = @wrong_guesses + l
      true
    end
  end

  def word_with_guesses
    holder = ''
    for a in (0...@word.length) do
      if guesses.include? (@word[a])
        holder = holder + @word[a]
      else
        holder = holder + '-'
      end
    end
    holder
  end
    
  def check_win_or_lose
    if wrong_guesses.length >= 7
      :lose
    elsif self.word_with_guesses == word
      :win
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
