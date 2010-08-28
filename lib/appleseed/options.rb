class Appleseed
  class Generator
    class Options < Hash
      attr_reader :opts, :orig_args

      def initialize(args)
        super()

        @orig_args = args.clone

        git_config =  if Pathname.new("~/.gitconfig").expand_path.exist?
                        Git.global_config
                      else
                        {}
                      end
        self[:user_name]       = ENV['GIT_AUTHOR_NAME']  || ENV['GIT_COMMITTER_NAME']  || git_config['user.name']
        self[:user_email]      = ENV['GIT_AUTHOR_EMAIL'] || ENV['GIT_COMMITTER_EMAIL'] || git_config['user.email']
        self[:github_username] = git_config['github.user']
        self[:github_token]    = git_config['github.token']

        require 'optparse'
        @opts = OptionParser.new do |o|
          o.banner = "Usage: #{File.basename($0)} [options] web-app-name\ne.g. #{File.basename($0)} new-years-2011"

          o.separator ""

          o.on('--description [DESCRIPTION]', 'specify a description of the project') do |description|
            self[:description] = description
          end

          o.separator ""

          o.on('--user-name [USER_NAME]', "the user's name, ie that is credited in the LICENSE") do |user_name|
            self[:user_name] = user_name
          end

          o.on('--user-email [USER_EMAIL]', "the user's email, ie that is credited in the Gem specification") do |user_email|
            self[:user_email] = user_email
          end

          o.separator ""

          o.on('--github-username [GITHUB_USERNAME]', "name of the user on GitHub to set the project up under") do |github_username|
            self[:github_username] = github_username
          end

          o.on('--github-token [GITHUB_TOKEN]', "GitHub token to use for interacting with the GitHub API") do |github_token|
            self[:github_token] = github_token
          end

          o.on('--git-remote [GIT_REMOTE]', 'URI to set the git origin remote to') do |git_remote|
            self[:git_remote] = git_remote
          end

          o.on('--no-github', 'don\'t create the repository on GitHub') do
            self[:no_github] = true
          end

          o.on_tail('-h', '--help', 'display this help and exit') do
            self[:show_help] = true
          end
        end

        begin
          @opts.parse!(args)
          self[:project_name] = args.shift
        rescue OptionParser::InvalidOption => e
          self[:invalid_argument] = e.message
        end
      end

      def merge(other)
        self.class.new(@orig_args + other.orig_args)
      end

    end
  end
end