require_relative 'player'

class Game

  def initialize(dictionary, *players)
    @players = players
    @dictionary = dictionary
    @fragment = ""
    @losses = {}
    populate_losses_hash
  end

  def run
    play_round until game_over?
    end_game(players.last)
  end

  private

  attr_reader :players, :dictionary, :losses
  attr_accessor :fragment

  def populate_losses_hash
    players.each { |player| losses[player] = 0 }
  end

  def play_round
    @fragment = ""
    display_standings
    take_turn(players[0]) until !still_moves?
    puts "#{players.last.name} GETS A LETTER"
    losses[players.last] += 1
  end

  def still_moves?
    dictionary.any? { |word| word[0...fragment.length] == fragment }
  end

  def display_standings
    puts "STANDINGS"
    players.each do |player|
      puts "#{player.name}: #{record(player)}"
    end
  end

  def record(player)
    "GHOST"[0...losses[player]]
  end

  def next_player!
    players.rotate!
  end

  def take_turn(player)
    puts "CURRENT WORD: " + fragment
    guess = ""
    until valid_play?(guess)
      guess = player.guess
      player.alert_invalid_guess unless valid_play?(guess)
    end
    @fragment += guess
    next_player!
  end

  def end_game(player)
    puts "#{player.name} HAS GHOST!"
  end

  def game_over?
    players.any? { |player| losses[player] === 5 }
  end

  def valid_play?(string)
    ('a'..'z').include?(string.downcase)
  end

end

if __FILE__ == $PROGRAM_NAME
  dictionary = File.readlines('dictionary.txt').map { |line| line.chomp }
  game = Game.new(dictionary, Player.new('Jeff'), Player.new('Paige'), Player.new('Billy'))
  game.run
end
