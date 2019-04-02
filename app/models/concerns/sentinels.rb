require 'zip'
require 'csv'

module Sentinels
  def self.table_name_prefix
    'sentinels_'
  end

  def self.import
    response = Distribusion.get_sentinels

    Tempfile.open(['sentinels', '.zip'], encoding: 'ascii-8bit') do |f|
      f.write(response.body)
      f.rewind

      Zip::File.open(f.path, Zip::File::CREATE) do |zip|
        routes_entry = zip.find_entry('sentinels/routes.csv')
        records = Route.process(routes_entry.get_input_stream.read)
        Route.import(records)
      end
    end
  end

  def self.export
    Route.
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
      ).
      joins('INNER JOIN sentinels_routes AS other ON sentinels_routes.route_id = other.route_id').
      where('sentinels_routes.index < other.index').
      find_each do |route|
        export_data = RouteData.new(route: route)
        Distribusion.post_sentinels(export_data.to_h)
      end
  end
end
