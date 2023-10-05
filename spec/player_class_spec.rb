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
        expect(player_name.get_name).to eq("Player #{described_class.total_num_of_players}")
      end
    end
  end


end
