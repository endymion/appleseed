class Appleseed
  class Generator
    class Application
      class << self
        def run!(*arguments)
          env_opts = if ENV['APPLESEED_OPTS']
            Appleseed::Generator::Options.new(ENV['APPLESEED_OPTS'].split(' '))
          end
          options = Appleseed::Generator::Options.new(arguments)
          options = options.merge(env_opts) if env_opts

          if options[:invalid_argument]
            $stderr.puts options[:invalid_argument]
            options[:show_help] = true
          end

          if options[:show_help]
            $stderr.puts options.opts
            return 1
          end

          if options[:project_name].nil? || options[:project_name].squeeze.strip == ""
            $stderr.puts options.opts
            return 1
          end

          begin
            generator = Appleseed::Generator.new(options)
            generator.run
            return 0
          rescue Appleseed::NoGitUserName
            $stderr.puts %Q{No user.name found in ~/.gitconfig. Please tell git about yourself (see http://help.github.com/git-email-settings/ for details). For example: git config --global user.name "mad voo"}
            return 1
          rescue Appleseed::NoGitUserEmail
            $stderr.puts %Q{No user.email found in ~/.gitconfig. Please tell git about yourself (see http://help.github.com/git-email-settings/ for details). For example: git config --global user.email mad.vooo@gmail.com}
            return 1
          rescue Appleseed::NoGitHubUser
            $stderr.puts %Q{No github.user found in ~/.gitconfig. Please tell git about your GitHub account (see http://github.com/blog/180-local-github-config for details). For example: git config --global github.user defunkt}
            return 1
          rescue Appleseed::NoGitHubToken
            $stderr.puts %Q{No github.token found in ~/.gitconfig. Please tell git about your GitHub account (see http://github.com/blog/180-local-github-config for details). For example: git config --global github.token 6ef8395fecf207165f1a82178ae1b984}
            return 1
          rescue Appleseed::FileInTheWay
            $stderr.puts "The directory #{options[:project_name]} already exists. Maybe move it out of the way before continuing?"
            return 1
          end
        end
      end

    end
  end
end