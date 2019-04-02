require 'zip'
require 'csv'

module Sniffers
  def self.table_name_prefix
    'sniffers_'
  end

  def self.import
    url = 'https://challenge.distribusion.com/the_one'
    passphrase = ENV['PASSPHRASE'].to_s

    conn = Faraday.new(url: url) do |faraday|
      faraday.request  :multipart
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.get('routes', passphrase: passphrase, source: 'sniffers')

    Tempfile.open(['sniffers', '.zip'], encoding: 'ascii-8bit') do |f|
      f.write(response.body)
      f.rewind

      Zip::File.open(f.path, Zip::File::CREATE) do |zip|
        routes_entry = zip.find_entry('sniffers/routes.csv')
        routes_string = routes_entry.get_input_stream.read.encode('ascii-8bit').force_encoding('utf-8').tr('\"', '').gsub(', ', ',')
        routes = CSV.parse(routes_string, headers: true).map do |row|
          Route.new(
            id: row['route_id'],
            time: Time.zone.parse(row['time'].to_s + row['time_zone'].to_s)
          )
        end
        Route.import(routes, on_duplicate_key_update: true)

        node_times_entry = zip.find_entry('sniffers/node_times.csv')
        node_times_string = node_times_entry.get_input_stream.read.tr('\"', '').gsub(', ', ',')
        node_times = CSV.parse(node_times_string, headers: true).map do |row|
          NodeTime.new(
            id: row['node_time_id'],
            start_node: row['start_node'],
            end_node: row['end_node'],
            duration: row['duration_in_milliseconds']
          )
        end
        NodeTime.import(node_times, on_duplicate_key_update: true)

        sequences_entry = zip.find_entry('sniffers/sequences.csv')
        sequences_string = sequences_entry.get_input_stream.read.tr('\"', '').gsub(', ', ',')
        sequences = CSV.parse(sequences_string, headers: true).map do |row|
          Sequence.new(
            sniffers_route_id: row['route_id'],
            sniffers_node_time_id: row['node_time_id']
          )
        end
        Sequence.import(sequences, on_duplicate_key_ignore: true)
      end
    end
  end
end
