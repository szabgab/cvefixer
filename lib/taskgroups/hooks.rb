class Hooks
  def self.l
    @l ||= SemanticLogger["hooks"]
  end

  def self.all(config)
    if config["hooks"].is_a? Array
      config["hooks"].each do |hook|
        if hook.is_a? String
          system hook
        else
          l.error "bad hook given in config: #{hook}"
        end
      end
    end
  end
end
