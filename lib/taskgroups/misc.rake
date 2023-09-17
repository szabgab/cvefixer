desc "upgrade deno"
task :deno do
  sh "deno upgrade"
end

desc "update npm"
task :npm do
  sh "sudo npm update -g npm"
  sh "sudo npm update -g"
end

desc "update flatpak"
task :flatpak do
  sh "sudo flatpak update -y"
end
