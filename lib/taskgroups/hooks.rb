class Hooks
  def self.l
    @l ||= SemanticLogger["hooks"]
  end

  def self.all(config)
    if config["hooks"].is_a? Array
      config["hooks"].each do |hook|
        if hook.is_a? String
          l.info "running hook #{hook}"
          system hook
        else
          l.error "bad hook given in config: #{hook}"
        end
      end
    else
      l.info "not running hook scripts; no config file found"
    end
  end
end
