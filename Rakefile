require "peppermint/rake/ruby"
require_relative "lib/cvefixer"

task :publish do
  sh "rm -v tmp/*"
  sh "gem build"
  sh "mv cvefixer-#{CVEFixer::VERSION}.gem tmp"
  sh "cd tmp; gem push cvefixer-#{CVEFixer::VERSION}.gem"
end
