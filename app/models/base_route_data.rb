class BaseRouteData
  def initialize(_options = {})
  end

  def to_h
    {
      start_node: start_node,
      end_node: end_node,
      start_time: start_time.strftime('%Y-%m-%dT%H:%M:%S'),
      end_time: end_time.strftime('%Y-%m-%dT%H:%M:%S')
    }
  end

  private

  def start_node
    raise NotImplementedError
  end

  def end_node
    raise NotImplementedError
  end

  def start_time
    raise NotImplementedError
  end

  def end_time
    raise NotImplementedError
  end
end
