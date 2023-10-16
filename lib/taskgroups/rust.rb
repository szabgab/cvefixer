class Rust
  def self.l
    @l ||= SemanticLogger["rust"]
  end

  def self.rustup
    if command? "rustup"
      l.info "run rustup update"
      system "rustup update"
    else
      l.info "skipping; you don't use rustup"
    end
  end

  def self.cargo
    if command? "cargo"
      l.info "update cargo packages"
      system "cargo install --list | grep -Ev '^[[:space:]]' " \
        "| cut -d ' ' -f 1 | xargs cargo install"
    else
      l.info "skipping; you don't use cargo"
    end
  end

  def self.all
    rustup
    cargo
  end
end
