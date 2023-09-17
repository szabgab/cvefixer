require "peppermint/rake/ruby"
require "fileutils"
require "semantic_logger"
require_relative "lib/rake_helpers/taskgroup"
require_relative "lib/rakesible"

SemanticLogger.add_appender(io: $stdout, formatter: :color)
logger = SemanticLogger["main"]

taskgroup :upgrade, "upgrade this computer" do
  ["misc", "os", "ruby", "rust"].each { |t| load "lib/taskgroups/#{t}.rake" }
end

task default: [:version, :upgrade]

task :install do
  logger.info "Ensuring $HOME/.local/bin/ exists"
  FileUtils.mkdir_p File.join ENV["HOME"], ".local/bin"
  logger.info "Creating and overwriting $HOME/.local/bin/rakesible"
  File.open (File.join ENV["HOME"], ".local/bin/rakesible"), "w", 0o744 do |f|
    f.write <<~SHELL
      #!/usr/bin/zsh
      set -e
      set -o pipefail
      cd '#{__dir__}'
      bundle exec rake "$@"
    SHELL
  end
end

task :version do
  logger.info "Rakesible version " + Rakesible::VERSION
end
