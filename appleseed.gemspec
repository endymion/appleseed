# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{appleseed}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Alyn Porter"]
  s.date = %q{2011-07-25}
  s.default_executable = %q{appleseed}
  s.description = %q{Generator for a Rails 3 app that will also push the project to GitHub and Heroku.}
  s.executables = ["appleseed"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "appleseed.gemspec",
    "bin/appleseed",
    "lib/appleseed.rb",
    "lib/appleseed/application.rb",
    "lib/appleseed/errors.rb",
    "lib/appleseed/generator.rb",
    "lib/appleseed/generator/github_mixin.rb",
    "lib/appleseed/options.rb",
    "spec/appleseed_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "templates/bundle_install.rb",
    "templates/compass.rb",
    "templates/compass_gem.rb",
    "templates/cucumber.rb",
    "templates/cucumber_gems.rb",
    "templates/default.rb",
    "templates/development.rb",
    "templates/gitignore.rb",
    "templates/haml.rb",
    "templates/haml_gem.rb",
    "templates/jquery.rb",
    "templates/jquery_gem.rb",
    "templates/root_controller.rb",
    "templates/rspec.rb",
    "templates/rspec_gem.rb"
  ]
  s.homepage = %q{http://github.com/endymion/appleseed}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Kick-start a Rails 3 project, push it to GitHub, deploy it to Heroku.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<rails>, [">= 0"])
      s.add_runtime_dependency(%q<git>, [">= 0"])
      s.add_runtime_dependency(%q<heroku>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<git>, [">= 0"])
      s.add_dependency(%q<heroku>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<git>, [">= 0"])
    s.add_dependency(%q<heroku>, [">= 0"])
  end
end

