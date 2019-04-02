class Sentinels::Route < ApplicationRecord
  def self.process(string)
    formatted_string = InputStringHelper.format(string)

    CSV.parse(formatted_string, headers: true).map do |row|
      new(
        route_id: row['route_id'],
        node: row['node'],
        index: row['index'],
        time: Time.zone.parse(row['time'].to_s)
      )
    end
  end

  scope :ascending_combinations, -> do
    select(
      'sentinels_routes.id,'\
      'sentinels_routes.route_id,'\
      'sentinels_routes.index,'\
      'sentinels_routes.node,'\
      'sentinels_routes.time,'\
      'other.id AS other_id,'\
      'other.route_id AS other_route_id,'\
      'other.index AS other_index,'\
      'other.node AS other_node,'\
      'other.time AS other_time'
    ).joins('INNER JOIN sentinels_routes AS other ON sentinels_routes.route_id = other.route_id').
      where('sentinels_routes.index < other.index')
  end
end
