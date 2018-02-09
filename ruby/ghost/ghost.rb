class Game

  def initalize(player_one, player_two, dictionary)
    @current_player = player_one
    @previous_player = player_two
    @dictionary = dictionary
    @fragment = ""
  end

  def play_round
    take_turn(current_player)
  end

  private

  attr_reader :previous_player, :current_player, :dictionary

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def take_turn(player)
    guess = ""
    until valid_play?(guess)
      guess = player.guess
      player.alert_invalid_guess unless valid_play?(guess)
    end
    @fragment += guess
    next_player!
  end

  def valid_play?(string)
    ('a'..'z').includes?(string.lowercase)
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Player.new('Jeff'), Player.new('Paige'))
end
