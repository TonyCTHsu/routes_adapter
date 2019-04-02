module Loopholes
  class RouteData
    def initialize(route:)
      @route = route
      @node_pair = route.node_pair
    end

    def to_h
      {
        start_node: @node_pair.start_node,
        end_node: @node_pair.end_node,
        start_time: @route.start_time.strftime('%Y-%m-%dT%H:%M:%S'),
        end_time: @route.end_time.strftime('%Y-%m-%dT%H:%M:%S')
      }
    end
  end
end
