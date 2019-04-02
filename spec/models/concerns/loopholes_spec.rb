require 'rails_helper'

describe Loopholes do
  describe '.import' do
    it do
      expect(Distribusion).to receive(:get_loopholes).
        and_return(double(body: IO.read('spec/fixtures/loopholes.zip')))

      expect do
        described_class.import
      end.to change { [Loopholes::NodePair.count, Loopholes::Route.count] }.from([0, 0]).to([3, 4])
    end
  end

  describe '.export' do
    it do
      allow(Distribusion).to receive(:get_loopholes).
        and_return(double(body: IO.read('spec/fixtures/loopholes.zip')))
      described_class.import
      [
        { start_node: "gamma", end_node: "theta",  start_time: "2030-12-31T13:00:04", end_time: "2030-12-31T13:00:05" },
        { start_node: "theta", end_node: "lambda", start_time: "2030-12-31T13:00:05", end_time: "2030-12-31T13:00:06" },
        { start_node: "beta",  end_node: "theta",  start_time: "2030-12-31T13:00:05", end_time: "2030-12-31T13:00:06" },
        { start_node: "theta", end_node: "lambda", start_time: "2030-12-31T13:00:06", end_time: "2030-12-31T13:00:07" }
      ].each do |attr|
        expect(Distribusion).to receive(:post_loopholes).with(attr).ordered
      end

      described_class.export
    end
  end
end
