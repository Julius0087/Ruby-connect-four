require "./lib/classes.rb"

describe Player do
  describe '#initialize' do

    context 'when a new Player object is created' do
      subject(:player_init) { described_class.new }
      # let(:player_double) { instance_double('Player') }

      before do
        allow(player_init).to receive(:get_name).and_return('Jackie')
        allow(player_init).to receive(:get_color).and_return('blue')
      end
      

      it 'increases the number_of_players class variable' do
        number = Player.total_num_of_players
        expect(number).to eq(1)
      end
      

      it 'initializes a name' do
        name = player_init.get_name
        expect(name).to eq('Jackie')
      end

      it 'initializes a color' do
        color = player_init.get_color
        expect(color).to eq('blue')
      end
    end
  end

  # describe '::total_num_of_players' do
  #   it 'returns the number_of_players' do
  #     expect(described_class.total_num_of_players).to eq(3)
  #   end
  # end

  describe '#get_name' do
    subject(:player_name) { described_class.new }
    context 'when an input is given' do
      before do
        allow(player_name).to receive(:gets).and_return('John')
      end

      it 'returns the input string' do
        input = 'John'
        expect(player_name.get_name).to eq(input)
      end
    end

    context 'when no input is given' do
      before do
        allow(player_name).to receive(:gets).and_return('')
      end

      it 'returns Player 1' do
        expect(player_name.get_name).to eq("Player #{described_class.total_num_of_players + 1}")
      end
    end
  end

  describe '#verify_name' do
    subject(:player_name) { described_class.new }

    context 'when valid name is given' do

      it 'returns the name' do
        input = 'Johnny D.'
        result = player_name.verify_name(input)
        expect(result).to eq(input)
      end
    end

    context 'when an invlaid name is given' do

      it 'prints an error message' do
        error_message = 'Name too long. Please select a name of maximum 10 characters.'
        allow(player_name).to receive(:puts).with(error_message)
        expect(player_name).to receive(:puts).with(error_message).once
        player_name.verify_name('MoreThanTen')
      end

      it 'returns nil' do
        input = 'MoreThanTen'
        result = player_name.verify_name(input)
        expect(result).to be_nil
      end
    
    end
  end

  describe '#get_color' do
    subject(:player_color) { described_class.new }

    context 'when an input is given' do
      before do
        # allow(player_color).to receive(:gets).and_return('blue')
        allow(player_color).to receive(:verify_color).with('blue').and_return('blue')
      end

      it 'returns blue' do
        color = 'blue'
        result = player_color.get_color
        expect(result).to eq(color)
      end
    end

    context 'when no input is given' do
      let(:color_mock) { Colors }
      before do
        allow(player_color).to receive(:gets).and_return('')
        allow(player_color).to receive(:verify_color).and_return('')
      end

      it 'returns the default color' do
        color = player_color.color_arr[0]
        expect(player_color.get_color).to eq(color)
      end
    end
  end

  describe '#verify_color' do

    subject(:color_verification) { described_class.new }

    context 'when valid color is given' do

      it 'returns the valid color' do
        input = 'blue'
        result = color_verification.verify_color(input)
        expect(result).to eq(input)
      end
    end

    context 'when an empty string is given' do
      it 'returns the empty string' do
        input = ''
        result = color_verification.verify_color(input)
        expect(result).to eq(input)
      end
    end

    context 'when an invlaid color is given' do

      it 'prints an error message' do
        error_message = 'Color not availible. Please select a valid color.'
        allow(color_verification).to receive(:puts).with(error_message)

        expect(color_verification).to receive(:puts).with(error_message).once
        color_verification.verify_color('NotAColor')
      end

      it 'returns nil' do
        input = 'NotAColor'
        result = color_verification.verify_color(input)
        expect(result).to be_nil
      end
    
    end
  end

end
