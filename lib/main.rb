require_relative "hangman.rb"

game = Hangman.new
p game.dictionary
game.get_random_word
p game.word