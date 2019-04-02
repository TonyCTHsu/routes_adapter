module Distribusion
  class Client
    def initialize(url: 'https://challenge.distribusion.com/the_one'.freeze)
      @conn = Faraday.new(url: url) do |faraday|
        faraday.request  :multipart
        faraday.request  :url_encoded
        faraday.response :logger if Rails.env.development?
        faraday.adapter Faraday.default_adapter
      end
    end

    def get(path, params)
      with_timeout_retry do
        @conn.get(path, params.merge(passphrase: passphrase))
      end
    end

    def post(path, data)
      with_timeout_retry do
        @conn.post(path, data.merge(passphrase: passphrase))
      end
    end

    private

    def passphrase
      @passphrase ||= ENV['PASSPHRASE'].to_s.freeze
    end

    def with_timeout_retry(counter: 0, limit: 3)
      yield
    rescue Faraday::TimeoutError, Faraday::ConnectionFailed => error
      raise if (counter += 1) > limit

      Rails.logger.warn("#{counter} attempt fail due to #{error}")
      retry
    end
  end
end
