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
        Route.import(
          records,
          on_duplicate_key_update: {
            conflict_target: [:route_id, :index],
            columns: [:node, :time]
          }
        )
      end
    end
  end

  def self.export
    Route.ascending_combinations.find_each do |route|
      export_data = RouteData.new(route: route)
      Distribusion.post_sentinels(export_data.to_h)
    end
  end
end
