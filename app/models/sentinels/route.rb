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
end
