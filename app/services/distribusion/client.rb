module Distribusion
  class Client
    def initialize(url: 'https://challenge.distribusion.com/the_one'.freeze)
      @conn = Faraday.new(url: url) do |faraday|
        faraday.request  :multipart
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def get(path, params)
      @conn.get(path, params.merge(passphrase: passphrase))
    end

    def post(path, data)
      @conn.post(path, data.merge(passphrase: passphrase))
    end

    private

    def passphrase
      @passphrase ||= ENV['PASSPHRASE'].to_s.freeze
    end
  end
end
