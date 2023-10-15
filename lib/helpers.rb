require "open3"

def command?(name)
  system "which", name, out: File::NULL
  $?.success?
end

def which(name)
  (Open3.capture2 "which", name)[0].chop
end

def selinux_context(name)
  ctx = (Open3.capture2 "stat", which(name))[0].match(/Context: (.*)/)
  if ctx.instance_of Array
    ctx[1]
  end
end
