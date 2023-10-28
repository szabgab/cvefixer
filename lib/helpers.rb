require "open3"

def command?(name)
  system "which", name, out: File::NULL, err: File::NULL
  $?.success?
end

def which(name)
  (Open3.capture2 "which", name).first.chop
end

def selinux_context(name)
  (Open3.capture2 "stat", which("deno")).first.match(/Context: (.*)/)[1]
end
