module Misc
  SemanticLogger["misc"]
  def deno
    l.info "upgrading deno"
    sh "deno upgrade"
  end

  def npm
    l.info "update npm and its packages"
    sh "sudo npm update -g npm"
    sh "sudo npm update -g"
  end

  def flatpak
    l.info "update flatpak"
    sh "sudo flatpak update -y"
  end

  def all
    deno
    npm
    flatpak
  end
end
