require "json"

class Config
  def self.l
    @l ||= SemanticLogger["config"]
  end

  def self.read_config
    config_path = %w[.config/cvefixer/cvefixer.json
      .config/cvefixer/config.json
      .config/cvefixer.json
      cvefixer.json
      .cvefixer.json].shuffle.lazy.map do |file|
        File.join(ENV["HOME"], file)
      end.filter do |file|
                    File.file? file
                  end
      .take(1).to_a[0]
    if config_path.nil?
      nil
    else
      begin
        JSON.parse(File.read(config_path))
      rescue
        l.error "invalid JSON at #{config_path}"
        nil
      end
    end
  end
end
