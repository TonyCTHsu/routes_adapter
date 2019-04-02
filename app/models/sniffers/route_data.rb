module Sniffers
  class RouteData < BaseRouteData
    def initialize(route:, node_time:)
      @route = route
      @node_time = node_time
    end

    private

    def start_node
      @node_time.start_node
    end

    def end_node
      @node_time.end_node
    end

    def start_time
      @route.time
    end

    def end_time
      @route.time + (@node_time.duration.to_f/1000)
    end
  end
end
