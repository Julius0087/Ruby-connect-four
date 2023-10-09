require "./lib/classes.rb"
require 'colorize'

describe Board do
  describe '#initialize' do

    context 'when a new board is created with default values' do
      subject(:board_init) { described_class.new('John', 'Bob') }

      it 'creates a grid' do
        expect(board_init.grid).to_not be_nil
      end

      it 'creates a hash of already placed' do
        expect(board_init.already_placed).to be_a(Hash)
      end

      it 'the hash keys correspond to the player names' do
        expect(board_init.already_placed.keys).to eq(['John', 'Bob'])
      end
    end
  end

  describe '#column_full?' do
    subject(:board) { described_class.new('Sarah', 'Tom') }
    context 'when the column is full' do

      it 'returns true' do
        column = 3
        board.instance_eval {@grid['5'][column - 1] = 'o'}

        expect(board.column_full?(column)).to be true
      end

    end

    context 'when the column is empty' do

      it 'returns nil' do
        column = 4
        expect(board.column_full?(column)).to be_nil
      end

    end
  end

  describe '#drop_into' do
    subject(:board_drop) { described_class.new('Bill', 'Billie') }
    context 'when a player drops the ball' do

      it 'updates the @grid' do
        player = double('player', color: 'yellow', name: 'Bill')
        column = 3
        board_drop.instance_eval {@grid['0'][column - 1] = 'o'}

        board_drop.drop_into(column, player)
        expect(board_drop.grid['1'][column - 1]).to eq("\e[0;33;49m•\e[0m")
      end
    end
  end

  describe '#win?' do
    subject(:board_win) { described_class.new('John', 'Charlie') }

    context 'when the win is horizontal' do
      

      it 'returns true' do
        player_one = double('player_one', name: 'John')
        winning_arr = [['0', 2], ['0', 3], ['0', 4], ['0', 5]]
        board_win.instance_eval {@already_placed['John'] = winning_arr}

        result = board_win.win?(player_one)
        expect(result).to be true
      end

      it 'prints the winning message' do
        player_one = double('player_one', name: 'John')
        winning_arr = [['0', 2], ['0', 3], ['0', 4], ['0', 5]]
        board_win.instance_eval {@already_placed['John'] = winning_arr}

        winning_message = 'John wins the game!'
        expect(board_win).to receive(:puts).with(winning_message).once
        board_win.win?(player_one)
      end
    end

    context 'when the win is vertical' do

      it 'returns true' do
        player_one = double('player_one', name: 'Bob')
        winning_arr = [['1', 2], ['2', 2], ['3', 2], ['4', 2]]
        board_win.instance_eval {@already_placed['Bob'] = winning_arr}

        result = board_win.win?(player_one)
        expect(result).to be true
      end

      it 'prints the winning message' do
        player_one = double('player_one', name: 'Bob')
        winning_arr = [['1', 2], ['2', 2], ['3', 2], ['4', 2]]
        board_win.instance_eval {@already_placed['Bob'] = winning_arr}

        winning_message = 'Bob wins the game!'
        expect(board_win).to receive(:puts).with(winning_message).once
        board_win.win?(player_one)
      end
    end

    context 'when the win is vertical' do

      it 'returns true when winning left-bottom to right-top' do
        player_one = double('player_one', name: 'Bob')
        winning_arr = [['0', 0], ['1', 1], ['2', 2], ['3', 3]]
        board_win.instance_eval {@already_placed['Bob'] = winning_arr}

        result = board_win.win?(player_one)
        expect(result).to be true
      end

      it 'returns true when winning right-bottom to left-top' do
        player_one = double('player_one', name: 'Bob')
        winning_arr = [['3', 0], ['2', 1], ['1', 2], ['0', 3]]
        board_win.instance_eval {@already_placed['Bob'] = winning_arr}

        result = board_win.win?(player_one)
        expect(result).to be true
      end
    end

    context 'when multiple winning conditions are present' do

      it 'returns true when winning horizontal and vertical' do
        player_one = double('player_one', name: 'Bob')
        winning_arr = [['3', 0], ['3', 1], ['3', 2], ['0', 3], ['1', 3], ['2', 3], ['3', 3]]
        board_win.instance_eval {@already_placed['Bob'] = winning_arr}
  
        result = board_win.win?(player_one)
        expect(result).to be true
      end
    end
  end

  describe '#tie?' do
    subject(:board_tie) { described_class.new('Bob', 'John') }

    context 'when the amount of moves is up' do
      
      it 'returns true' do
        player_one_arr = Array (1..42)
        player_two_arr = Array (1..42)

        board_tie.instance_eval {@already_placed['Bob'] = player_one_arr}
        board_tie.instance_eval {@already_placed['John'] = player_two_arr}

        result = board_tie.tie?
        expect(result).to be true
      end
    end
  end
end
