require 'pathname'
require 'date'

class Appleseed
  require 'appleseed/errors'
  # require 'rubygems/user_interaction'

  autoload :Generator,      'appleseed/generator'

  attr_reader :gemspec, :gemspec_helper, :version_helper
  attr_accessor :base_dir, :output, :repo, :commit

  def initialize(base_dir = '.')

    @base_dir       = base_dir
    @repo           = Git.open(git_base_dir) if in_git_repo?
    @output         = $stdout
    @commit         = true
  end

  def git_base_dir(base_dir = nil)
    if base_dir
      base_dir = File.dirname(base_dir)
    else
      base_dir = File.expand_path(self.base_dir || ".")
    end
    return nil if base_dir==File.dirname("/")
    return base_dir if File.exists?(File.join(base_dir, '.git'))
    return git_base_dir(base_dir)
  end    

  def in_git_repo?
    git_base_dir
  end

end