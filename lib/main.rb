require_relative "hangman.rb"

game = Hangman.new
game.load_dictionary
game.get_random_word
p game.word
game.create_secret
game.print_secret