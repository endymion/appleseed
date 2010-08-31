generate 'rspec'

gsub_file 'config/application.rb', /^\s*config.generators do \|g\|$/, %{
  config.generators do |g|
    g.test_framework :rspec, :fixture => true, :views => false
    g.integration_tool :rspec, :fixture => true, :views => true
}
