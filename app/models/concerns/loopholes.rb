require 'zip'
require 'csv'

module Loopholes
  def self.table_name_prefix
    'loopholes_'
  end

  def self.import
    response = Distribusion.get_loopholes

    Tempfile.open(['loopholes', '.zip'], encoding: 'ascii-8bit') do |f|
      f.write(response.body)
      f.rewind

      Zip::File.open(f.path, Zip::File::CREATE) do |zip|
        node_pairs_entry = zip.find_entry('loopholes/node_pairs.json')
        node_pairs = NodePair.process(node_pairs_entry.get_input_stream.read)
        NodePair.import(
          node_pairs,
          on_duplicate_key_update: [:start_node, :end_node]
        )

        routes_entry = zip.find_entry('loopholes/routes.json')
        routes = Route.process(routes_entry.get_input_stream.read, node_pairs.index_by(&:id))
        Route.import(
          routes,
          on_duplicate_key_update: {
            conflict_target: [:route_id, :loopholes_node_pair_id],
            columns: [:start_time, :end_time]
          }
        )
      end
    end
  end

  def self.export
    Route.includes(:node_pair).find_each do |route|
      export_data = RouteData.new(route: route)
      Distribusion.post_loopholes(export_data.to_h)
    end
  end
end
