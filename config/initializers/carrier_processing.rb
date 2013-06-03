if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
    config.store_dir = "/uploads/images"
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
  end
end


CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
#    :aws_access_key_id      => ENV['AWS_ID'],                        # required
    :aws_access_key_id       => ENV['AWS_ID'],
    :aws_secret_access_key   => ENV['AWS_SECRET'],
    # :aws_secret_access_key  => ENV['AWS_SECRET'],                        # required
    # :region                 => 'us-west-2'
  }
  config.fog_directory  = 'ap-antimony-dev'                     # required
  #config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end