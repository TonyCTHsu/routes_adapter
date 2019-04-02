require 'rails_helper'

describe Loopholes::NodePair do
  it do
    is_expected.
      to have_many(:routes).
        class_name('Loopholes::Route').
        with_foreign_key(:loopholes_node_pair_id)
  end

  describe '.process' do
    it do
      string = IO.read('spec/fixtures/loopholes/node_pairs.json')

      result = described_class.process(string)

      expect(result.size).to eq(3)

      expect(result[0].id).to eq(1)
      expect(result[0].start_node).to eq('gamma')
      expect(result[0].end_node).to eq('theta')

      expect(result[1].id).to eq(2)
      expect(result[1].start_node).to eq('beta')
      expect(result[1].end_node).to eq('theta')

      expect(result[2].id).to eq(3)
      expect(result[2].start_node).to eq('theta')
      expect(result[2].end_node).to eq('lambda')
    end
  end
end
