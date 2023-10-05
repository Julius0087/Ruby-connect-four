require "./lib/classes.rb"

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
end

