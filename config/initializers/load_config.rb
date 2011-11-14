# load all the configuration variables for plans
APP_CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/config.yml")[::Rails.env]
