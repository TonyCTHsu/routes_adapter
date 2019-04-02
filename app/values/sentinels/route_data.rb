module Sentinels
  class RouteData
    def initialize(route:)
      @route = route
    end

    def to_h
      {
        start_node: @route.node,
        end_node: @route.other_node,
        start_time: @route.time.strftime('%Y-%m-%dT%H:%M:%S'),
        end_time: @route.other_time.strftime('%Y-%m-%dT%H:%M:%S')
      }
    end
  end
end
