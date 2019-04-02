require 'rails_helper'

describe Sniffers::Sequence do
  it do
    is_expected.
      to belong_to(:node_time).
        class_name('Sniffers::NodeTime').
        with_foreign_key(:sniffers_node_time_id)
  end
  it do
    is_expected.
      to belong_to(:route).
        class_name('Sniffers::Route').
        with_foreign_key(:sniffers_route_id)
  end

   describe '.process' do
    it do
      string = IO.read('spec/fixtures/sniffers/sequences.csv')

      result = described_class.process(string)

      expect(result.size).to eq(6)

      expect(result[0].sniffers_route_id).to eq(1)
      expect(result[0].sniffers_node_time_id).to eq(1)

      expect(result[1].sniffers_route_id).to eq(1)
      expect(result[1].sniffers_node_time_id).to eq(2)

      expect(result[2].sniffers_route_id).to eq(1)
      expect(result[2].sniffers_node_time_id).to eq(3)

      expect(result[3].sniffers_route_id).to eq(2)
      expect(result[3].sniffers_node_time_id).to eq(4)

      expect(result[4].sniffers_route_id).to eq(2)
      expect(result[4].sniffers_node_time_id).to eq(3)

      expect(result[5].sniffers_route_id).to eq(3)
      expect(result[5].sniffers_node_time_id).to eq(9)
    end
  end
end
