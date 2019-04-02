describe Distribusion::Client do
  around do |example|
    ClimateControl.modify PASSPHRASE: 'passphrase' do
      example.run
    end
  end

  describe '#get' do
    it 'sends a GET request with params and returns a response' do
      stub_request(:get, /distribusion/).and_return(status: 200)
      client = described_class.new

      result = client.get('path', data: 'data')

      expect(result.status).to eq(200)
      expect(WebMock).to have_requested(:get, 'https://challenge.distribusion.com/the_one/path').
        with(query: { data: 'data', passphrase: 'passphrase' })
    end

    it 'retries when timeout' do
      stub_request(:get, /distribusion/).to_timeout.then.to_return(status: 200)
      client = described_class.new

      result = client.get('path', data: 'data')

      expect(result.status).to eq(200)
      expect(WebMock).to have_requested(:get, 'https://challenge.distribusion.com/the_one/path').
        with(query: { data: 'data', passphrase: 'passphrase' }).twice
    end

    it 'raises error after 3 retries' do
      stub_request(:get, /distribusion/).to_timeout
      client = described_class.new

      expect do
        client.get('path', data: 'data')
      end.to raise_error Faraday::ConnectionFailed

      expect(WebMock).to have_requested(:get, 'https://challenge.distribusion.com/the_one/path').
        with(query: { data: 'data', passphrase: 'passphrase' }).times(4)
    end
  end

  describe '#post' do
    it 'sends a POST request with body and returns a response' do
      stub_request(:post, /distribusion/).and_return(status: 200)
      client = described_class.new

      result = client.post('path', data: 'data')

      expect(result.status).to eq(200)
      expect(WebMock).to have_requested(:post, 'https://challenge.distribusion.com/the_one/path').
        with(body: { data: 'data', passphrase: 'passphrase' })
    end

    it 'retries when timeout' do
      stub_request(:post, /distribusion/).to_timeout.then.to_return(status: 200)
      client = described_class.new

      result = client.post('path', data: 'data')

      expect(result.status).to eq(200)
      expect(WebMock).to have_requested(:post, 'https://challenge.distribusion.com/the_one/path').
        with(body: { data: 'data', passphrase: 'passphrase' }).twice
    end

    it 'raises error after 3 retries' do
      stub_request(:post, /distribusion/).to_timeout
      client = described_class.new

      expect do
        client.post('path', data: 'data')
      end.to raise_error Faraday::ConnectionFailed

      expect(WebMock).to have_requested(:post, 'https://challenge.distribusion.com/the_one/path').
        with(body: { data: 'data', passphrase: 'passphrase' }).times(4)
    end
  end
end
