require 'zip'
require 'csv'

module Loopholes
  def self.table_name_prefix
    'loopholes_'
  end

  def self.import
    url = 'https://challenge.distribusion.com/the_one'
    passphrase = ENV['PASSPHRASE'].to_s

    conn = Faraday.new(url: url) do |faraday|
      faraday.request  :multipart
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.get('routes', passphrase: passphrase, source: 'loopholes')

    Tempfile.open(['loopholes', '.zip'], encoding: 'ascii-8bit') do |f|
      f.write(response.body)
      f.rewind

      Zip::File.open(f.path, Zip::File::CREATE) do |zip|
        node_pairs_entry = zip.find_entry('loopholes/node_pairs.json')
        node_pairs_data = JSON.parse(node_pairs_entry.get_input_stream.read, symbolize_names: true)[:node_pairs]

        node_pairs = node_pairs_data.map { |data| NodePair.new(data) }.index_by(&:id)

        routes_entry = zip.find_entry('loopholes/routes.json')
        routes_data = JSON.parse(routes_entry.get_input_stream.read, symbolize_names: true)[:routes]

        routes_data.map do |data|
          Route.new(
            id: data[:route_id],
            loopholes_node_pair_id: node_pairs[data[:node_pair_id].to_i].try(:id),
            start_time: Time.zone.parse(data[:start_time].to_s),
            end_time: Time.zone.parse(data[:end_time].to_s)
          )
        end
      end
    end
  end
end
