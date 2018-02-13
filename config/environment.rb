# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
module MyApp
  class Application < Rails::Application
    config.lkp = config_for(:lkp)
  end
end
