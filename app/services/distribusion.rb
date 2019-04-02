module Distribusion
  def self.get_sentinels
    client.get('routes', source: 'sentinels')
  end

  def self.get_loopholes
    client.get('routes', source: 'loopholes')
  end

  def self.get_sniffers
    client.get('routes', source: 'sniffers')
  end

  def self.post_sentinels(data)
    client.post('routes', data.merge(source: 'sentinels'))
  end

  def self.post_loopholes(data)
    client.post('routes', data.merge(source: 'loopholes'))
  end

  def self.post_sniffers(data)
    client.post('routes', data.merge(source: 'sniffers'))
  end

  def self.client
    Client.new
  end
end
