CarrierWave.configure do |config|
  config.root = Rails.root

  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider => "AWS",
      :aws_access_key_id => ENV["AKIAJFHCYOG6JA6AD6RQ"],
      :aws_secret_access_key => ENV["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"],
    }
    config.fog_directory = ENV["i5okie-files"]
  else
    config.storage = :file
  end
end