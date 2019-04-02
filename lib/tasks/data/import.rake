namespace :data do
  namespace :import do
    desc 'Import all objects into database from remote zipfile'
    task all: [:sentinels, :loopholes, :sniffers] do
    end

    desc 'Import sentinels objects into database from remote zipfile'
    task sentinels: :environment do
      puts 'Start sentinels importing...'
      Sentinels.import
      puts 'Complete  sentinels importing...'
    end

    desc 'Import loopholes objects into database from remote zipfile'
    task loopholes: :environment do
      puts 'Start loopholes importing...'
      Loopholes.import
      puts 'Complete  loopholes importing...'
    end

    desc 'Import sniffers objects into database from remote zipfile'
    task sniffers: :environment do
      puts 'Start sniffers importing...'
      Sniffers.import
      puts 'Complete  sniffers importing...'
    end
  end
end
