class Ruby
  def self.l
    @l ||= SemanticLogger["misc"]
  end

  def self.rbenv
    l.info "updating rbenv installation"
    system "curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash"
  end

  def self.all
    rbenv
  end
end
