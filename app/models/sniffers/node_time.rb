class Sniffers::NodeTime < ApplicationRecord
  has_many :sequences, class_name: 'Sniffers::Sequence', foreign_key: :sniffers_node_time_id
  has_many :routes, through: :sequences, class_name: 'Sniffers::Route'

  def self.process(string)
    formatted_string = InputStringHelper.format(string)

    CSV.parse(formatted_string, headers: true).map do |row|
      new(
        id: row['node_time_id'],
        start_node: row['start_node'],
        end_node: row['end_node'],
        duration: row['duration_in_milliseconds']
      )
    end
  end
end
