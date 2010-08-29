require 'rubygems'
require 'git'
require 'erb'

require 'net/http'
require 'uri'

require 'fileutils'
require 'pathname'

class Appleseed
  class NoGitUserName < StandardError
  end
  class NoGitUserEmail < StandardError
  end
  class FileInTheWay < StandardError
  end
  class NoGitHubRepoNameGiven < StandardError
  end
  class NoGitHubUser < StandardError
  end
  class NoGitHubToken < StandardError
  end
  class GitInitFailed < StandardError
  end    

  class Generator    

    require 'appleseed/generator/github_mixin'

    attr_accessor :target_dir, :user_name, :user_email, :summary, :homepage,
                  :description, :project_name, 
                  :repo, :should_create_github_repository, 
                  :should_create_heroku_deployment, 
                  :testing_framework, :documentation_framework,
                  :should_use_cucumber, :should_use_bundler,
                  :should_setup_rubyforge, :should_use_reek, :should_use_roodi,
                  :development_dependencies,
                  :options,
                  :git_remote,
                  :template_url

    def initialize(options = {})
      self.options = options

      self.project_name   = options[:project_name]
      if self.project_name.nil? || self.project_name.squeeze.strip == ""
        raise NoGitHubRepoNameGiven
      end

      self.target_dir             = self.project_name

      self.summary                = options[:summary] || 'TODO: one-line summary of your gem'
      self.description            = options[:description] || 'TODO: longer description of your gem'

      # self.template_url    = options[:template_url] || 'http://github.com/endymion/appleseed/raw/master/templates/default.rb'
      self.template_url    = options[:template_url] || 'http://localhost/projects/appleseed/templates/default.rb'

      self.user_name       = options[:user_name]
      self.user_email      = options[:user_email]
      self.homepage        = options[:homepage]

      self.git_remote      = options[:git_remote]

      raise NoGitUserName unless self.user_name
      raise NoGitUserEmail unless self.user_email

      extend GithubMixin

      self.should_create_heroku_deployment = !options[:no_heroku]
      
    end

    def run
      create_files
      create_version_control
      $stdout.puts "Appleseed has prepared your new web application project in #{target_dir}"
      if should_create_github_repository
        create_and_push_repo
        $stdout.puts "Appleseed has pushed your git repository to #{git_remote}"
      end
      if should_create_heroku_deployment
        create_and_push_deployment
        $stdout.puts "Appleseed has pushed your web application to heroku"
      end
    end

    def constant_name
      self.project_name.split(/[-_]/).collect{|each| each.capitalize }.join
    end

    def lib_filename
      "#{project_name}.rb"
    end

    def require_name
      self.project_name
    end

    def file_name_prefix
      self.project_name.gsub('-', '_')
    end

    def lib_dir
      'lib'
    end

    def feature_filename
      "#{project_name}.feature"
    end

    def steps_filename
      "#{project_name}_steps.rb"
    end

    def features_dir
      'features'
    end

    def features_support_dir
      File.join(features_dir, 'support')
    end

    def features_steps_dir
      File.join(features_dir, 'step_definitions')
    end

  private

    def create_files
      if File.exists?(target_dir) || File.directory?(target_dir)
        raise FileInTheWay, "The directory #{target_dir} already exists, aborting. Maybe move it out of the way before continuing?"
      end

      create_rails_application target_dir

    end

    def render_template(source)
      template_contents = File.read(File.join(template_dir, source))
      template          = ERB.new(template_contents, nil, '<>')

      # squish extraneous whitespace from some of the conditionals
      template.result(binding).gsub(/\n\n\n+/, "\n\n")
    end

    def template_dir
      File.join(File.dirname(__FILE__), 'templates')
    end

    def create_rails_application(target_dir)
      result = system("rails new #{self.project_name} --template #{self.template_url}")
      
      $stdout.puts "\tgenerate rails app\t#{target_dir}"
    end

    def create_version_control
      Dir.chdir(target_dir) do
        begin
          @repo = Git.init()
        rescue Git::GitExecuteError => e
          raise GitInitFailed, "Encountered an error during gitification. Maybe the repo already exists, or has already been pushed to?"
        end

        begin
          @repo.add('.')
        rescue Git::GitExecuteError => e
          #raise GitAddFailed, "There was some problem adding this directory to the git changeset"
          raise
        end

        begin
          @repo.commit "Initial commit to #{project_name}."
        rescue Git::GitExecuteError => e
          raise
        end

        begin
          @repo.add_remote('github', git_remote)
        rescue Git::GitExecuteError => e
          puts "Encountered an error while adding origin remote. Maybe you have some weird settings in ~/.gitconfig?"
          raise
        end
      end
    end
    
    def create_and_push_repo
      Net::HTTP.post_form URI.parse('http://github.com/api/v2/yaml/repos/create'),
                                'login' => github_username,
                                'token' => github_token,
                                'description' => description,
                                'name' => project_name
      # TODO do a HEAD request to see when it's ready?
      @repo.push('github')
    end
    
    def create_and_push_deployment
      Dir.chdir(target_dir) do
        # Try to create a Heroku project with the given name, but fail over to a Heroku-assigned
        # name if necessary.
        unless system("heroku create #{project_name}")
          result = system("heroku create")
        end
      
        @repo.push('heroku')
      end
    end
    
  end
end