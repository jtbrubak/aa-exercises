require_relative 'player'

class Game

  def initialize(player_one, player_two, dictionary)
    @players = [player_one, player_two]
    @dictionary = dictionary
    @fragment = ""
    @losses = { player_one => 0, player_two => 0 }
  end

  def run
    play_round until game_over?
  end

  private

  attr_reader :players, :dictionary, :losses
  attr_accessor :fragment

  def play_round
    @fragment = ""
    display_standings
    take_turn(players[0]) until !still_moves?
    puts "#{players[1].name} GETS A LETTER"
    losses[players[1]] += 1
  end

  def still_moves?
    dictionary.any? { |word| word[0...fragment.length] == fragment }
  end

  def display_standings
    puts "STANDINGS"
    puts "#{players[0].name}: #{record(players[0])}"
    puts "#{players[1].name}: #{record(players[1])}"
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

  def game_over?
    players.any? { |player| losses[player] === 5 }
  end


  def valid_play?(string)
    ('a'..'z').include?(string.downcase)
  end

end

if __FILE__ == $PROGRAM_NAME
  dictionary = File.readlines('dictionary.txt').map { |line| line.chomp }
  game = Game.new(Player.new('Jeff'), Player.new('Paige'), dictionary)
  game.run
end
