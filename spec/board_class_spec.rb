require "./lib/classes.rb"
require 'colorize'

describe Board do
  describe '#initialize' do

    
    context 'when a new board is created with default values' do
      subject(:board_init) { described_class.new }

      it 'creates a grid' do
        expect(board_init.grid).to_not be_nil
      end

      it 'creates a hash of already placed' do
        expect(board_init.already_placed).to be_a(Hash)
      end

      it 'the hash keys correspond to the colors' do
        expect(board_init.already_placed.keys).to eq(['yellow', 'red'])
      end
    end

    context 'when a new board is created with specified values' do
      subject(:board_init_custom) { described_class.new('blue', 'orange') }

      it 'creates a hash of already placed' do
        expect(board_init_custom.already_placed).to be_a(Hash)
      end

      it 'the hash keys correspond to the colors' do
        expect(board_init_custom.already_placed.keys).to eq(['blue', 'orange'])
      end
    end
  end

  describe '#column_full?' do
    subject(:board) { described_class.new }
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
    subject(:board_drop) { described_class.new }
    context 'when a player drops the ball' do

      it 'updates the @grid' do
        player = double('player', color: 'yellow')
        column = 3
        board_drop.instance_eval {@grid['0'][column - 1] = 'o'}

        board_drop.drop_into(column, player)
        expect(board_drop.grid['1'][column - 1]).to eq("\e[0;33;49m•\e[0m")
      end
    end
  end

end

