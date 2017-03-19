require_relative '../../../lib/2/finder'

RSpec.shared_examples_for 'a finder' do |size, pairs = []|
  let(:finder) { described_class.new(size, arr) }

  context 'with adjacent elements missing' do
    1.upto(size).each_cons(2) do |pair|
      context "with #{pair} missing" do
        let(:missing) { pair.to_a }
        let(:arr) { 1.upto(size).to_a - missing }

        it { is_expected.to eq missing }
      end
    end
  end

  context 'with opposite elements missing' do
    1.upto(size / 2).each do |elem|
      second_missing = size - elem + 1
      context "with #{[elem, second_missing]} missing" do
        let(:missing) { [elem, second_missing] }
        let(:arr) { 1.upto(size).to_a - missing }

        it { is_expected.to eq missing }
      end
    end
  end

  context 'with exact elements missing' do
    pairs.each do |pair|
      context "with #{pair} missing" do
        let(:missing) { pair.to_a }
        let(:arr) { 1.upto(size).to_a - missing }

        it { is_expected.to eq missing }
      end
    end
  end
end

RSpec.describe Finder do
  describe '#call' do
    subject { finder.call }

    context 'with size of 15' do
      it_should_behave_like 'a finder', 15, [[3, 6], [13, 15]]
    end

    context 'with size of 150' do
      it_should_behave_like 'a finder', 150, [[31, 33], [59, 133], [133, 150], [38, 74], [75, 81], [1, 146]]
    end
  end
end
