require 'rails_helper'

describe Loopholes::Route do
  it do
    is_expected.
      to belong_to(:node_pair).
        class_name('Loopholes::NodePair').
        with_foreign_key(:loopholes_node_pair_id)
  end

  describe '.process' do
    it do
      string = IO.read('spec/fixtures/loopholes/routes.json')
      node_pairs_map = {
        1 => double(id: 1),
        2 => double(id: 2),
        3 => double(id: 3),
      }

      result = described_class.process(string, node_pairs_map)

      expect(result.size).to eq(5)

      expect(result[0].route_id).to eq(1)
      expect(result[0].loopholes_node_pair_id).to eq(1)
      expect(result[0].start_time).to eq(Time.utc(2030, 12, 31, 13, 0, 4))
      expect(result[0].end_time).to eq(Time.utc(2030, 12, 31, 13, 0, 5))

      expect(result[1].route_id).to eq(1)
      expect(result[1].loopholes_node_pair_id).to eq(3)
      expect(result[1].start_time).to eq(Time.utc(2030, 12, 31, 13, 0, 5))
      expect(result[1].end_time).to eq(Time.utc(2030, 12, 31, 13, 0, 6))

      expect(result[2].route_id).to eq(2)
      expect(result[2].loopholes_node_pair_id).to eq(2)
      expect(result[2].start_time).to eq(Time.utc(2030, 12, 31, 13, 0, 5))
      expect(result[2].end_time).to eq(Time.utc(2030, 12, 31, 13, 0, 6))

      expect(result[3].route_id).to eq(2)
      expect(result[3].loopholes_node_pair_id).to eq(3)
      expect(result[3].start_time).to eq(Time.utc(2030, 12, 31, 13, 0, 6))
      expect(result[3].end_time).to eq(Time.utc(2030, 12, 31, 13, 0, 7))

      expect(result[4].route_id).to eq(3)
      expect(result[4].loopholes_node_pair_id).to eq(nil)
      expect(result[4].start_time).to eq(Time.utc(2030, 12, 31, 13, 0, 0))
      expect(result[4].end_time).to eq(Time.utc(2030, 12, 31, 13, 0, 0))
    end
  end
end
