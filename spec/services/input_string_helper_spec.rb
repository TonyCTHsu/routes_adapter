describe InputStringHelper do
  describe '.format' do
    it do
      string = "\"route_id\", \"time\", \"time_zone\""

      expect(described_class.format(string)).to eq('route_id,time,time_zone')
    end
  end
end
