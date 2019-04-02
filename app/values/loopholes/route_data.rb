module Loopholes
  class RouteData < BaseRouteData
    def initialize(route:)
      @route = route
      @node_pair = route.node_pair
    end

    private

    def start_node
      @node_pair.start_node
    end

    def end_node
      @node_pair.end_node
    end

    def start_time
      @route.start_time
    end

    def end_time
      @route.end_time
    end
  end
end
