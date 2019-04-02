require 'zip'
require 'csv'

module Sentinels
  def self.table_name_prefix
    'sentinels_'
  end

  def self.import
    url = 'https://challenge.distribusion.com/the_one'
    passphrase = ENV['PASSPHRASE'].to_s

    conn = Faraday.new(url: url) do |faraday|
      faraday.request  :multipart
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.get('routes', passphrase: passphrase, source: 'sentinels')

    Tempfile.open(['sentinels', '.zip'], encoding: 'ascii-8bit') do |f|
      f.write(response.body)
      f.rewind

      Zip::File.open(f.path, Zip::File::CREATE) do |zip|
        entry = zip.find_entry('sentinels/routes.csv')
        table = CSV.parse(entry.get_input_stream.read.tr('\"', '').gsub(', ', ','), headers: true)

        records = table.map do |row|
          Route.new(
            route_id: row['route_id'],
            node: row['node'],
            index: row['index'],
            time: Time.zone.parse(row['time'].to_s)
          )
        end

        Route.import(records)
      end
    end
  end
end
