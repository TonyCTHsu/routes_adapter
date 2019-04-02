require 'rails_helper'

describe Sniffers::NodeTime do
  it do
    is_expected.
      to have_many(:sequences).
        class_name('Sniffers::Sequence').
        with_foreign_key(:sniffers_node_time_id)
  end
  it do
    is_expected.
      to have_many(:routes).
        class_name('Sniffers::Route').
        through(:sequences)
  end

  describe '.process' do
    it do
      string = IO.read('spec/fixtures/sniffers/node_times.csv')

      result = described_class.process(string)

      expect(result.size).to eq(4)

      expect(result[0].id).to eq(1)
      expect(result[0].start_node).to eq('lambda')
      expect(result[0].end_node).to eq('tau')
      expect(result[0].duration).to eq(1000)

      expect(result[1].id).to eq(2)
      expect(result[1].start_node).to eq('tau')
      expect(result[1].end_node).to eq('psi')
      expect(result[1].duration).to eq(1000)

      expect(result[2].id).to eq(3)
      expect(result[2].start_node).to eq('psi')
      expect(result[2].end_node).to eq('omega')
      expect(result[2].duration).to eq(1000)

      expect(result[3].id).to eq(4)
      expect(result[3].start_node).to eq('lambda')
      expect(result[3].end_node).to eq('psi')
      expect(result[3].duration).to eq(1000)
    end
  end
end
