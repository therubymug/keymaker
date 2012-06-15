require 'rails'

class Railtie < Rails::Railtie
  rake_tasks do
    load "keymaker/rails_tasks.rb"
  end
end
