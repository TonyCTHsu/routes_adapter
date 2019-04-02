require 'rails_helper'

describe Sentinels do
  describe '.import' do
    it do
      expect(Distribusion).to receive(:get_sentinels).
        and_return(double(body: IO.read('spec/fixtures/sentinels.zip')))

      expect do
        described_class.import
      end.to change { Sentinels::Route.count }.from(0).to(7)
    end
  end

  describe '.export' do
    it do
      allow(Distribusion).to receive(:get_sentinels).
        and_return(double(body: IO.read('spec/fixtures/sentinels.zip')))
      described_class.import
      [
        { end_node: "beta",  end_time: "2030-12-31T13:00:02", start_node: "alpha", start_time: "2030-12-31T13:00:01" },
        { end_node: "gamma", end_time: "2030-12-31T13:00:03", start_node: "alpha", start_time: "2030-12-31T13:00:01" },
        { end_node: "gamma", end_time: "2030-12-31T13:00:03", start_node: "beta",  start_time: "2030-12-31T13:00:02" },
        { end_node: "beta",  end_time: "2030-12-31T13:00:03", start_node: "delta", start_time: "2030-12-31T13:00:02" },
        { end_node: "gamma", end_time: "2030-12-31T13:00:04", start_node: "delta", start_time: "2030-12-31T13:00:02" },
        { end_node: "gamma", end_time: "2030-12-31T13:00:04", start_node: "beta",  start_time: "2030-12-31T13:00:03" }
      ].each do |attr|
        expect(Distribusion).to receive(:post_sentinels).with(attr).ordered
      end

      described_class.export
    end
  end
end
