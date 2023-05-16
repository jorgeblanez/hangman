class Hangman
  attr_reader :dictionary,:word, :secret

  def load_dictionary
    #Load dictionary from file into an array
    @dictionary = File.readlines("google-10000-english-no-swears.txt")
  end
  
  #Get a random word from the dictionary between 5 and 12 characters
  def get_random_word
    @word = @dictionary.sample.chomp.chars
    while @word.length < 5 || word.length >12
      @word = @dictionary.sample.chomp.chars
    end
  end

  def create_secret
    @secret = Array.new(@word.length)
    @secret.map!{|value| value = "_"}
  end

  def print_secret
    self.secret.each{|value| print value +" "}
    puts
  end

  def game
    @guess = self.create_secret
  end

end