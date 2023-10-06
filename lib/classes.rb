require 'colorize'
class Colors
  attr_accessor :color_arr

  @@color_arr = ["yellow", "red", "green", "blue", "magenta", "gray", "cyan"]

  def self.print_color_choices
    @@color_arr.each do |color|
      print "#{color}".colorize(color.to_sym)
      print ", "
    end
    print "\n"
  end
end

class Player < Colors
  @@number_of_players = 0

  attr_reader :name
  attr_accessor :number_of_players

  def initialize
    # TODO: add nice message and ability to select name and color of choice
    # @player_number = @@number_of_players + 1
    # @availible_colors = colors
    @name = get_name
    @color = get_color
    @@number_of_players += 1
  end

  def self.total_num_of_players
    @@number_of_players
  end

  # TODO: proper verify for name and color - name: max 10 letters
  # color: must be in arr
  # defaults for both
  def get_name
    player_number = @@number_of_players + 1
    input = ''
    puts "Player #{player_number}, select a name:"
    loop do
      input = verify_name(gets.chomp)
      break if input
    end
    input == '' ? "Player #{player_number}" : input
  end

  def verify_name(input)
    if input.length > 10
      puts 'Name too long. Please select a name of maximum 10 characters.'
    else
      input
    end
  end

  def get_color
    input = ''
    puts "#{@name}, select a color:"
    loop do
      Colors.print_color_choices
      input = verify_color(gets.chomp)
      break if input
    end
    input == '' ? "#{@@color_arr.shift}" : "#{@@color_arr.delete(input)}"
  end

  

  def verify_color(input)
    if @@color_arr.include?(input.downcase) || input == ''
      return input
    else
      puts 'Color not availible. Please select a valid color.'
    end
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

  def print_grid
    @grid.each do |key, value|
      value.each { |hole| print "|#{hole}"}
      print "|\n"
    end
  end

end



class Game
  attr_reader :player_one, :player_two

  def initialize
    @player_one = Player.new
    @player_two = Player.new
    @board = Board.new
  end

end
