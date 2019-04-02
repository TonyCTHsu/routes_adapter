module Sentinels
  class RouteData < BaseRouteData
    def initialize(route:)
      @route = route
    end

    private

    def start_node
      @route.node
    end

    def end_node
      @route.other_node
    end

    def start_time
      @route.time
    end

    def end_time
      @route.other_time
    end
  end
end
