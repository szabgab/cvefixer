class Ruby
  def self.l
    @l ||= SemanticLogger["misc"]
  end

  def self.rbenv
    l.info "updating rbenv installation"
    system "git", "-C", File.join(ENV["HOME"],".rbenv"), "pull", "origin"
  end

  def self.all
    rbenv
  end
end
