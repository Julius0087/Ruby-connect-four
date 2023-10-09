require 'colorize'
require "./lib/board.rb"
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

  attr_reader :name, :color
  attr_accessor :number_of_players

  def initialize
    @name = get_name
    @color = get_color
    @@number_of_players += 1
  end

  def self.total_num_of_players
    @@number_of_players
  end

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
    input = nil
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

class Game
  attr_reader :player_one, :player_two, :current_player

  def initialize
    @player_one = Player.new
    @player_two = Player.new
    @current_player = @player_two
    @board = Board.new(@player_one.name, @player_two.name)
  end

  def play
    @board.print_grid

    loop do
      @current_player = select_player

      puts "#{@current_player.name}, enter the column number (1-7)"
      column_num = get_coordinates

      @board.drop_into(column_num.to_i, @current_player)
      @board.print_grid
      break if @board.win?(current_player)
      break if @board.tie?
    end
  end

  def select_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def get_coordinates
    loop do
      input = verify_coordinates(gets.chomp)
      return input if input
    end
  end

  def verify_coordinates(input)
    if input.match?(/^[1-7]$/)
      if @board.column_full?(input.to_i)
        puts 'This column is already full.'
      else
        input
      end
    else
      puts 'Invalid coordinates. Please select a single number between 1 and 7'
    end
  end


end
