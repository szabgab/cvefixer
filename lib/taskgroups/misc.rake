l = SemanticLogger["misc"]

describe "upgrade deno", l
task :deno do
  sh "deno upgrade"
end

describe "update npm and its packages", l
task :npm do
  sh "sudo npm update -g npm"
  sh "sudo npm update -g"
end

describe "update flatpak", l
task :flatpak do
  sh "sudo flatpak update -y"
end
