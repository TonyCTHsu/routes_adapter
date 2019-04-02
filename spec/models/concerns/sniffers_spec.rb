require 'rails_helper'

describe Sniffers do
  describe '.import' do
    it do
      expect(Distribusion).to receive(:get_sniffers).
        and_return(double(body: IO.read('spec/fixtures/sniffers.zip')))

      expect do
        described_class.import
      end.to change { [Sniffers::NodeTime.count, Sniffers::Route.count, Sniffers::Sequence.count] }.
        from([0, 0, 0]).to([4, 3, 6])
    end
  end

  describe '.export' do
    it do
      allow(Distribusion).to receive(:post_sniffers)
      allow(Distribusion).to receive(:get_sniffers).
        and_return(double(body: IO.read('spec/fixtures/sniffers.zip')))
      described_class.import
      [
        { end_node: "tau",   end_time: "2030-12-31T13:00:07", start_node: "lambda", start_time: "2030-12-31T13:00:06" },
        { end_node: "psi",   end_time: "2030-12-31T13:00:07", start_node: "tau",    start_time: "2030-12-31T13:00:06" },
        { end_node: "omega", end_time: "2030-12-31T13:00:07", start_node: "psi",    start_time: "2030-12-31T13:00:06" },
        { end_node: "psi",   end_time: "2030-12-31T13:00:08", start_node: "lambda", start_time: "2030-12-31T13:00:07" },
        { end_node: "omega", end_time: "2030-12-31T13:00:08", start_node: "psi",    start_time: "2030-12-31T13:00:07" }
      ].each do |attr|
        expect(Distribusion).to receive(:post_sniffers).with(attr).ordered
      end

      described_class.export
    end
  end
end
