require 'rails_helper'

describe Loopholes::RouteData do
  describe '#to_h' do
    it do
      node_pair = double(start_node: 'start_node', end_node: 'end_node')
      route = double(
        node_pair: node_pair,
        start_time: Time.utc(2000, 1, 1, 20, 15, 1),
        end_time: Time.utc(2000, 1, 1, 20, 15, 10)
      )

      result = described_class.new(route: route).to_h

      expect(result).to eq(
        start_node: 'start_node',
        end_node: 'end_node',
        start_time: '2000-01-01T20:15:01',
        end_time: '2000-01-01T20:15:10'
      )
    end
  end
end
