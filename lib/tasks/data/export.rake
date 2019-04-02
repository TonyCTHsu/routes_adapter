namespace :data do
  namespace :export do
    desc 'Export all routes from database to remote endpoint'
    task all: [:sentinels, :loopholes, :sniffers] do
    end

    desc 'Export sentinels routes from database to remote endpoint'
    task sentinels: :environment do
      puts 'Start sentinels exporting...'
      Sentinels.export
      puts 'Complete  sentinels exporting...'
    end

    desc 'Export loopholes routes from database to remote endpoint'
    task loopholes: :environment do
      puts 'Start loopholes exporting...'
      Loopholes.export
      puts 'Complete  loopholes exporting...'
    end

    desc 'Export sniffers routes from database to remote endpoint'
    task sniffers: :environment do
      puts 'Start sniffers exporting...'
      Sniffers.export
      puts 'Complete  sniffers exporting...'
    end
  end
end
