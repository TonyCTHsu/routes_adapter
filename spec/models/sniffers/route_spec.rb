require 'rails_helper'

describe Sniffers::Route do
  it do
    is_expected.
      to have_many(:sequences).
        class_name('Sniffers::Sequence').
        with_foreign_key(:sniffers_route_id)
  end
  it do
    is_expected.
      to have_many(:node_times).
        class_name('Sniffers::NodeTime').
        through(:sequences)
  end

  describe '.process' do
    it do
      string = IO.read('spec/fixtures/sniffers/routes.csv')

      result = described_class.process(string)

      expect(result.size).to eq(3)

      expect(result[0].id).to eq(1)
      expect(result[0].time).to eq(Time.utc(2030, 12, 31, 13, 0, 6))

      expect(result[1].id).to eq(2)
      expect(result[1].time).to eq(Time.utc(2030, 12, 31, 13, 0, 7))

      expect(result[2].id).to eq(3)
      expect(result[2].time).to eq(Time.utc(2030, 12, 31, 13, 0, 0))
    end
  end
end
