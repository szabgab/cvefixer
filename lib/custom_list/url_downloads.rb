require "json"

class URLDownloads
  def self.l
    @l ||= SemanticLogger["URL download JSON parsing"]
  end

  def app_list
    @app_list ||= []
  end

  def read_from_file(path)
    data = JSON.parse(File.open(path))
    if data.is_a? Array
      data.each do |entry|
        if !(entry.is_a? Hash)
          l.error "bad JSON format in #{path}. no hash"
          return nil
        elsif !((entry.has_key? "name") && (entry.has_key? "url"))
          l.error "bad JSON format in #{path}. name/url keys"
          return nil
        elsif !((entry.name.is_a? String) && (entry.url.is_a? String))
          l.error "bad JSON format in #{path}. name/url keys - i want a string"
          return nil
        end
      end
    end
    @app_list = data
    true
  end

  def initialize(foobaz)
    @foobaz = foobaz
  end

  def say_something
    puts "here's the foobaz you ordered: #{foobaz}"
  end
end
