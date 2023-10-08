require "./lib/classes.rb"

describe Game do

  describe '#initialize' do

    subject(:game_init) { described_class.new }
    context 'when a new Game object is created' do
      before do
        allow(Player).to receive(:new)
        allow(Board).to receive(:new)
      end

      it 'creates two players' do
        expect(Player).to receive(:new).twice
        described_class.new
      end

      it 'creates one board' do
        expect(Board).to receive(:new).once
        described_class.new
      end
    end
  end

  describe '#select_player' do
    subject(:game_players) { described_class.new }

    context 'when current player is player_one' do
      # let(:player_one) { double('player1') }
      # let(:player_two) { double('player2') }

      before do
        # allow(player_one).to receive(:name) { 'Johnny' }
        # allow(player_two).to receive(:name) { 'Bobby' }
        # allow(game_players).to receive(:player_one) { player_one }
        # allow(game_players).to receive(:player_two) { player_two }
        # allow(game_players).to receive(:current_player) { player_one }
      end

      it 'selects the second player' do
        expect(game_players.select_player).to eq(game_players.player_two)
      end

    end

    context 'when current player is player_two' do
      it 'selects the first player' do
        game = described_class.new
        game.instance_eval {@current_player = game.player_two}
        expect(game.select_player).to eq(game.player_one)
      end
    end

  end

  describe '#verify_coordinates' do
    subject(:game_verify) { described_class.new }

    context 'when valid coordinates are given' do
      it 'does not print an error message' do
        error_message = 'Invalid coordinates. Please select a single number between 1 and 7'
        valid_input = '6'
        expect(game_verify).not_to receive(:puts).with(error_message)
        game_verify.verify_coordinates(valid_input)
      end

      it 'prints an error message if column is full' do
        board = double('board')
        allow(board).to receive(:column_full?).with(4).and_return(true)
        game_verify.instance_eval {@board = board}
        error_message = 'This column is already full.'

        expect(game_verify).to receive(:puts).with(error_message)
        game_verify.verify_coordinates('4')
      end

      it 'returns the input if column is not full' do
        board = double('board')
        allow(board).to receive(:column_full?).with(4).and_return(false)
        game_verify.instance_eval {@board = board}

        result = game_verify.verify_coordinates('4')
        expect(result).to eq('4')
      end
    end

    context 'when invalid coordinates are given' do
      it 'prints an error message' do
        error_message = 'Invalid coordinates. Please select a single number between 1 and 7'
        invalid_input = 'bb'
        expect(game_verify).to receive(:puts).with(error_message)
        game_verify.verify_coordinates(invalid_input)
      end
    end
  end

end
        