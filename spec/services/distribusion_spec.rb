describe Distribusion do
  describe '.get_sentinels' do
    it do
      client = double(get: :result)
      expect(Distribusion::Client).to receive(:new).and_return(client)

      result = described_class.get_sentinels

      expect(result).to eq(:result)
      expect(client).to have_received(:get).with('routes', source: 'sentinels')
    end
  end

  describe '.get_loopholes' do
    it do
      client = double(get: :result)
      expect(Distribusion::Client).to receive(:new).and_return(client)

      result = described_class.get_loopholes

      expect(result).to eq(:result)
      expect(client).to have_received(:get).with('routes', source: 'loopholes')
    end
  end

  describe '.get_sniffers' do
    it do
      client = double(get: :result)
      expect(Distribusion::Client).to receive(:new).and_return(client)

      result = described_class.get_sniffers

      expect(result).to eq(:result)
      expect(client).to have_received(:get).with('routes', source: 'sniffers')
    end
  end

  describe '.post_sentinels' do
    it do
      client = double(post: :result)
      expect(Distribusion::Client).to receive(:new).and_return(client)

      result = described_class.post_sentinels(data: 'data')

      expect(result).to eq(:result)
      expect(client).to have_received(:post).with('routes', source: 'sentinels', data: 'data')
    end
  end

  describe '.post_loopholes' do
    it do
      client = double(post: :result)
      expect(Distribusion::Client).to receive(:new).and_return(client)

      result = described_class.post_loopholes(data: 'data')

      expect(result).to eq(:result)
      expect(client).to have_received(:post).with('routes', source: 'loopholes', data: 'data')
    end
  end

  describe '.post_sniffers' do
    it do
      client = double(post: :result)
      expect(Distribusion::Client).to receive(:new).and_return(client)

      result = described_class.post_sniffers(data: 'data')

      expect(result).to eq(:result)
      expect(client).to have_received(:post).with('routes', source: 'sniffers', data: 'data')
    end
  end

  describe '.client' do
    it do
      client = double
      expect(Distribusion::Client).to receive(:new).and_return(client)

      result = described_class.client

      expect(result).to eq(client)
    end
  end
end
