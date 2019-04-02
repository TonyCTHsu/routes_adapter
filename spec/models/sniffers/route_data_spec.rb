require 'rails_helper'

describe Sniffers::RouteData do
  describe '#to_h' do
    it do
      node_time = double(start_node: 'start_node', end_node: 'end_node', duration: 1000)
      route = double(time: Time.utc(2000, 1, 1, 20, 15, 1))

      result = described_class.new(route: route, node_time: node_time).to_h

      expect(result).to eq(
        start_node: 'start_node',
        end_node: 'end_node',
        start_time: '2000-01-01T20:15:01',
        end_time: '2000-01-01T20:15:02'
      )
    end
  end
end
