require 'rails_helper'

describe Sentinels::Route do

  describe '.process' do
    it do
      string = IO.read('spec/fixtures/sentinels/routes.csv')

      result = described_class.process(string)

      expect(result.size).to eq(7)

      expect(result[0].route_id).to eq(1)
      expect(result[0].node).to eq('alpha')
      expect(result[0].index).to eq(0)
      expect(result[0].time).to eq(Time.utc(2030, 12, 31, 13, 0, 1))

      expect(result[1].route_id).to eq(1)
      expect(result[1].node).to eq('beta')
      expect(result[1].index).to eq(1)
      expect(result[1].time).to eq(Time.utc(2030, 12, 31, 13, 0, 2))

      expect(result[2].route_id).to eq(1)
      expect(result[2].node).to eq('gamma')
      expect(result[2].index).to eq(2)
      expect(result[2].time).to eq(Time.utc(2030, 12, 31, 13, 0, 3))

      expect(result[3].route_id).to eq(2)
      expect(result[3].node).to eq('delta')
      expect(result[3].index).to eq(0)
      expect(result[3].time).to eq(Time.utc(2030, 12, 31, 13, 0, 2))

      expect(result[4].route_id).to eq(2)
      expect(result[4].node).to eq('beta')
      expect(result[4].index).to eq(1)
      expect(result[4].time).to eq(Time.utc(2030, 12, 31, 13, 0, 3))

      expect(result[5].route_id).to eq(2)
      expect(result[5].node).to eq('gamma')
      expect(result[5].index).to eq(2)
      expect(result[5].time).to eq(Time.utc(2030, 12, 31, 13, 0, 4))

      expect(result[6].route_id).to eq(3)
      expect(result[6].node).to eq('zeta')
      expect(result[6].index).to eq(0)
      expect(result[6].time).to eq(Time.utc(2030, 12, 31, 13, 0, 2))
    end
  end

end
