require_relative "../helpers"

class Ruby
  def self.l
    @l ||= SemanticLogger["ruby"]
  end

  def self.rbenv
    if command? "rbenv"
      l.info "updating rbenv installation"
      (system "git", "-C", File.join(ENV["HOME"], ".rbenv"), "pull", "origin") || return
      self.gem
    else
      l.info "skipping; you don't use rbenv"
    end
  end

  def self.gem
    l.info "updating gems"
    gem_path = File.join ENV["HOME"], ".rbenv/shims/gem"
    (system gem_path, "update") || return
    system gem_path, "update", "--system"
  end

  def self.all
    rbenv
  end
end
