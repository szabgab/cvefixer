class Misc
  def self.l
    @l ||= SemanticLogger["misc"]
  end

  def self.deno
    if command? "deno"
    l.info "upgrading deno"
    system "deno upgrade"
    else 
      l.info "skipping; you don't use deno"
    end
  end

  def self.npm
    if command? "npm"
    l.info "update npm and its packages"
    system "sudo npm update -g npm"
    system "sudo npm update -g"
    else 
      l.info "skipping; you don't use npm"
    end
  end

  def self.flatpak
    if command? "flatpak"
    l.info "update flatpak"
    system "sudo flatpak update -y"
    else 
      l.info "skipping; you don't use flatpak"
    end
  end

  def self.all
    deno
    npm
    flatpak
  end
end
