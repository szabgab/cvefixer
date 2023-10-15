require "open3"

def command?(name)
  system "command", "-v", name, out: File::NULL
  $?.success?
end

def which(name)
  (Open3.capture2 "command", "-v", name)[0].chop
end

def selinux_context(name)
  (Open3.capture2 "stat", which(name))[0].match(/Context: (.*)/)[1]
end
