class Misc
  def self.l
    @l ||= SemanticLogger["misc"]
  end

  def self.deno
    if command? "deno"
      cmd_path = which "deno"
      l.info "upgrading deno"
      if cmd_path.index(ENV["HOME"]) == 0
        system "deno upgrade"
      else
        context = selinux_context "deno"
        system "sudo deno upgrade"
        system "sudo", "chcon", context, which("deno")
      end
    else
      l.info "skipping; you don't use deno"
    end
  end

  def self.npm
    if command? "npm"
      l.info "update npm and its packages"
      (system "sudo npm update -g npm") || return
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
