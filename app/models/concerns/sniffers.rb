require 'zip'
require 'csv'

module Sniffers
  def self.table_name_prefix
    'sniffers_'
  end

  def self.import
    response = Distribusion.get_sniffers

    Tempfile.open(['sniffers', '.zip'], encoding: 'ascii-8bit') do |f|
      f.write(response.body)
      f.rewind

      Zip::File.open(f.path, Zip::File::CREATE) do |zip|
        routes_entry = zip.find_entry('sniffers/routes.csv')
        routes = Route.process(
          routes_entry.get_input_stream.read.encode('ascii-8bit').force_encoding('utf-8')
        )
        Route.import(routes, on_duplicate_key_update: :all)

        node_times_entry = zip.find_entry('sniffers/node_times.csv')
        node_times = NodeTime.process(node_times_entry.get_input_stream.read)
        NodeTime.import(node_times, on_duplicate_key_update: :all)

        sequences_entry = zip.find_entry('sniffers/sequences.csv')
        sequences = Sequence.process(sequences_entry.get_input_stream.read)
        Sequence.import(sequences, on_duplicate_key_ignore: true)
      end
    end
  end

  def self.export
    Route.includes(:node_times).find_each do |route|
      route.node_times.each do |node_time|
        export_data = RouteData.new(route: route, node_time: node_time)

        Distribusion.post_sniffers(export_data.to_h)
      end
    end
  end
end
