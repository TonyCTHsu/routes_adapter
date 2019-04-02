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
        start_time: @route.time.iso8601,
        end_time: (@route.time + (@node_time.duration.to_f/1000)).iso8601,
      }
    end
  end
end
