class Misc
  def self.l
    @l ||= SemanticLogger["misc"]
  end

  def self.deno
    l.info "upgrading deno"
    system "deno upgrade"
  end

  def self.npm
    l.info "update npm and its packages"
    system "sudo npm update -g npm"
    system "sudo npm update -g"
  end

  def self.flatpak
    l.info "update flatpak"
    system "sudo flatpak update -y"
  end

  def self.all
    deno
    npm
    flatpak
  end
end
