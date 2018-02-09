class Player

  def initialize(name)
    @name = name
  end

  def guess
    puts "Enter guess: "
    gets.chomp
  end

  def alert_invalid_guess
    puts "Invalid guess!"
  end

end
