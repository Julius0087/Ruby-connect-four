class Board
  attr_reader :grid, :already_placed

  def initialize(player_one, player_two)
    @grid = {
      '5' => [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '4' => [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '3' => [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '2' => [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '1' => [' ', ' ', ' ', ' ', ' ', ' ', ' '],
      '0' => [' ', ' ', ' ', ' ', ' ', ' ', ' '], 
    }
    @already_placed = {
      player_one => [],
      player_two => []
    }
  end

  def print_grid
    @grid.each do |key, value|
      value.each { |hole| print "|#{hole}"}
      print "|\n"
    end
    print " 1 2 3 4 5 6 7 \n"
  end

  def column_full?(input)
    return true unless @grid['5'][input - 1] == ' '
  end

  def drop_into(column, current_player)
    index = column - 1
    @grid.each do |row, row_arr|
      if row == '0' || @grid[(row.to_i - 1).to_s][index] != ' '
        row_arr[index] = '•'.colorize(current_player.color.to_sym)
        @already_placed[current_player.name] << [row, index]
        return
      end
    end
  end

  def win?(current_player)
    placed_arr = @already_placed[current_player.name]
    last_placed = placed_arr.last

    if win_horizontal?(placed_arr, last_placed) ||
      win_vertical?(placed_arr, last_placed) ||
      win_diagonal_ul_dr?(placed_arr, last_placed) ||
      win_diagonal_ur_dl?(placed_arr, last_placed)

      puts "#{current_player.name} wins the game!"
      return true
    end
  end

  def tie?
    if @already_placed.values.flatten.length >= 84
      puts "No moves left. It's a tie!"
      return true
    end
  end


  private

  def win_horizontal?(placed_arr, node)
    left_count = win_horizontal_recursive(placed_arr, node, :left)
    right_count = win_horizontal_recursive(placed_arr, node, :right)

    return true if left_count + right_count >= 3

  end

  def win_horizontal_recursive(placed_arr, node, direction, count = 0)
    i = direction == :left ? -1 : 1

    if index = placed_arr.index([node[0], node[1] + i])
      count += 1
      count = win_horizontal_recursive(placed_arr, placed_arr[index], direction, count)
    end
    count
      
  end

  def win_vertical?(placed_arr, node)
    # no reason to check upwards, as the last placed ball will always be on top
    down_count = win_vertical_recursive(placed_arr, node)

    return true if down_count >= 3
  end

  def win_vertical_recursive(placed_arr, node, count = 0)
    if index = placed_arr.index([(node[0].to_i - 1).to_s, node[1]])
      count += 1
      count = win_vertical_recursive(placed_arr, placed_arr[index], count)
    end
    count
  end

  def win_diagonal_ul_dr?(placed_arr, node)
    up_left_count = win_diagonal_recursive(placed_arr, node, :up_left)
    down_right_count = win_diagonal_recursive(placed_arr, node, :down_right)

    return true if up_left_count + down_right_count >= 3
  end

  def win_diagonal_ur_dl?(placed_arr, node)
    up_right_count = win_diagonal_recursive(placed_arr, node, :up_right)
    down_left_count = win_diagonal_recursive(placed_arr, node, :down_left)

    return true if up_right_count + down_left_count >= 3
  end

  def win_diagonal_recursive(placed_arr, node, direction, count = 0)
    case direction
    when :up_left
      x = -1
      y = 1
    when :down_right
      x = 1
      y = -1
    when :up_right
      x = 1
      y = 1
    when :down_left
      x = -1
      y = -1
    end

    if index = placed_arr.index([(node[0].to_i + y).to_s, node[1] + x])
      count += 1
      count = win_diagonal_recursive(placed_arr, placed_arr[index], direction, count)
    end
    count
  end
end
