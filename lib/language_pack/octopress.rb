require "language_pack"
require "language_pack/jekyll"

# Octopress Language Pack.
class LanguagePack::Octopress < LanguagePack::Jekyll

  def self.use?
    super && has_generate_task?
  end

  def self.has_generate_task?
    #File.read("Rakefile") =~ /task :generate/
  #rescue Errno::ENOENT
   # false
   true
  end

  def name
    "Octopress"
  end

  def generate_jekyll_site
    topic("Building Octopress site")
    pipe("env PATH=$PATH git init")
    pipe("env PATH=$PATH git remote add upstream git://github.com/austenito/austenito.com.git")
    pipe("env PATH=$PATH git pull upstream master")
    pipe("env PATH=$PATH bundle install --without development:test --path vendor/bundle --binstubs bin/ --deployment")
    pipe("env PATH=$PATH bundle exec rake generate 2>&1")
  end
end
