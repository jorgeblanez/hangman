class Hangman
  attr_reader :dictionary,:word
  def initialize
    @dictionary = File.readlines("google-10000-english-no-swears.txt")
  end
  
  #Get a random word from the dictionary between 5 and 12 characters
  def get_random_word
    @word = @dictionary.sample.chomp
    while @word.length < 5 || word.length >12
      @word = @dictionary.sample.chomp
    end
  end

end