gem 'cucumber'
gem 'cucumber-rails'
gem 'capybara'

run 'bundle install'

# Generate Cucumber infrastructure.
run 'rails generate cucumber:install --rspec --capybara'