class Rust
  def self.l
    @l ||= SemanticLogger["misc"]
  end

  def self.rustup
    l.info "run rustup update"
    system "rustup update"
  end

  def self.cargo
    if command? "cargo"
      l.info "update cargo packages"
      system "cargo install --list | grep -E '^[[:space:]]' " \
        "| sed -E -e 's/[[:space:]]+//g' | xargs cargo install"
    else
      l.info ""
    end
  end

  def self.all
    rustup
    cargo
  end
end
