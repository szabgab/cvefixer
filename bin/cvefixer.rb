#!/usr/bin/env ruby
require "fileutils"
require "semantic_logger"
require_relative "../lib/cvefixer"
require_relative "../lib/taskgroups/misc"
require_relative "../lib/taskgroups/os"
require_relative "../lib/taskgroups/ruby"
require_relative "../lib/taskgroups/rust"
require "thor"

SemanticLogger.add_appender(io: $stdout, formatter: :color)
SemanticLogger["main"]

class App < Thor
  desc "all", "update everything"
  def all
    Misc.all
    Os.all
    Ruby.all
    Rust.all
  end
  desc "misc", "update miscellaneous apps"
  def misc
    Misc.all
  end
  desc "os", "update OS packages"
  def os
    Os.all
  end
  desc "ruby", "update Ruby-related items"
  def ruby
    Ruby.all
  end
  desc "rust", "update Rust-related items"
  def rust
    Rust.all
  end
  desc "version", "what version am I running?"
  def version
    puts "cvefixer #{CVEFixer::VERSION}"
  end
end

App.start
