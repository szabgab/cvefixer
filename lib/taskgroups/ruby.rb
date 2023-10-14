require_relative "../helpers"

class Ruby
  def self.l
    @l ||= SemanticLogger["misc"]
  end

  def self.rbenv
    if command? "rbenv"
    l.info "updating rbenv installation"
    system "git", "-C", File.join(ENV["HOME"],".rbenv"), "pull", "origin"
    else 
      l.info "skipping; you don't use rbenv"
    end
  end

  def self.all
    rbenv
  end
end
