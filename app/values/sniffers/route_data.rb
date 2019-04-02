module Sniffers
  class RouteData
    def initialize(route:, node_time:)
      @route = route
      @node_time = node_time
    end

    def to_h
      {
        start_node: @node_time.start_node,
        end_node: @node_time.end_node,
        start_time: @route.time.strftime('%Y-%m-%dT%H:%M:%S'),
        end_time: (@route.time + (@node_time.duration.to_f/1000)).strftime('%Y-%m-%dT%H:%M:%S')
      }
    end
  end
end
