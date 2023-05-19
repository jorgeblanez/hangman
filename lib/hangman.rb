require "json"

class Hangman
  attr_reader :dictionary
  attr_accessor :guess,:word,:secret
  
  def initialize
    @wrong_guess_counter = 0
    @guess_control = Array.new
  end

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

  #Create a secret with the same lenght as the word, with "_" representing the missing letters
  def create_secret
    @secret = Array.new(@word.length).map!{|value| value = "_"}
  end

  #Prints the current secret with correct guesses
  def print_secret
    self.secret.each{|value| print value +" "}
    puts
  end

  #Control the guesses already made.
  def guess_control(guess)
    @guess_control.push(guess)
  end

  #Get the guess and make sure it's only letters. If the guess is repeated, make the player guess again.
  def get_guess
    stop = false

    until stop
      stop = true
      puts "Input a guess. Only one letter! Or input \"save\" to save the game!"
      guess = gets.chomp.downcase
      if guess == "save"
        self.save_game
      elsif guess.count("a-zA-Z")!= 1
        puts "Wrong input! Input only one letter!"
        stop = false
      elsif @guess_control.include? guess
        puts "You already guessed #{guess}. Try another guess."
        stop = false
      end
    end
    self.guess_control(guess)
    guess
  end

  def validate_guess(guess)
    if guess == "save"
      puts "Game Saved! You can only have one saved game at a time"
    elsif @word.include?(guess)
      puts "Right guess! The letter '#{guess}' is in the word!"
      @word.each_with_index { |val,index|  val == guess ? @secret[index] = guess : nil}
    else
      @wrong_guess_counter += 1
      @wrong_guess_counter < 10 ?  (puts "Wrong guess! You have #{10 - @wrong_guess_counter} #{@wrong_guess_counter >=9 ? "life" : "lifes"} remaining") : nil
    end
  end

  #Game menu method will be the first one to run, and will have the options to start a new game and to load an existing game.
  def game_menu
    puts "Welcome to TOP's Hangman! Choose an option!"
    puts "[1] Start a New Game"
    puts "[2] Load an existing Game"  
    stop = false

    until stop
      print "Your choice: "
      choice = gets.chomp
      if choice == "1"
        stop = true
        self.new_game
      elsif choice == "2"
        stop = true
        self.load_game
      else
        puts "Wrong option! Choose between options 1 or 2!"
      end
    end
  end

  def load_game
    loaded = JSON.parse(File.read("./save/save.json"),{symbolize_names: true})
    self.word = loaded[:word]
    self.secret = loaded[:secret]
    @wrong_guess_counter = loaded[:wrong_guess_counter]
    self.print_secret
    self.game
  end

  def save_game
    save = {
      word: self.word,
      secret: self.secret,
      wrong_guess_counter: @wrong_guess_counter
    }
    File.write("./save/save.json", JSON.dump(save))
  end

  def new_game
    #Initialize the game
    self.load_dictionary
    self.get_random_word
    self.create_secret
    self.print_secret    
    self.game
  end

  #game loop for hangman
  def game
    #Guess loop
    while @wrong_guess_counter < 10
      if self.secret == self.word then break end
      self.guess = self.get_guess
      self.validate_guess(@guess)
      self.print_secret
    end
    @wrong_guess_counter <10 ? (puts "You won! The word is \"#{self.secret.join("")}\"!") : (puts "You lost! The word was \"#{self.word.join("")}\"")
  end

end