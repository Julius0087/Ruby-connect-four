class Player
  @@number_of_players = 0

  attr_reader :name
  attr_accessor :number_of_players

  def initialize
    # TODO: add nice message and ability to select name and color of choice
    @name = get_name
    @color = get_color
    @player_number = @@number_of_players + 1
    @@number_of_players += 1
  end

  def self.total_num_of_players
    @@number_of_players
  end

  def get_name
    input = gets.chomp
    return input == '' ? "Player #{@player_number}" : input
  end

  def get_color
  end
end

class Board
  attr_reader :grid, :already_placed

  def initialize(color_one = 'yellow', color_two = 'red')
    @grid = {
      '5': [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '4': [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '3': [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '2': [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '1': [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '0': [' ', ' ', ' ', ' ', ' ', ' ', ' '], 
    }
    @already_placed = {
      color_one => [],
      color_two => []
    }
  end

end

class Game
  def initialize
    @player_one = Player.new
    @player_two = Player.new
    @board = Board.new
  end

end

