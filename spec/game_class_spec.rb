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
end
        