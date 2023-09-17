require "mutiny-devel/rake/ruby"
require_relative "lib/rake_helpers/taskgroup"
require_relative "lib/rakesible"

taskgroup :upgrade, "upgrade this computer" do
  ["misc", "os", "ruby", "rust"].each { |t| load "lib/taskgroups/#{t}.rake" }
end

task default: [:version, :upgrade]

task :version do
  puts "Rakesible version " + Rakesible::VERSION
end
