require "rake"

l = SemanticLogger["os"]

module OSType
  OTHER = 0
  RHEL = 1
  GENTOO = 2
  UBUNTU = 3
end

def os
  case File.foreach("/etc/os-release").lazy.grep(/^ID=/).first
  when /fedora/
    OSType::RHEL
  when /gentoo/
    OSType::GENTOO
  when /rocky/
    OSType::RHEL
  when /ubuntu/
    OSType::UBUNTU
  else
    OSType::OTHER
  end
end

taskgroup :os, "upgrade os" do
  describe "run a full os update and cleanup", l
  task all: [:pkg_update, :pkg_clean]

  describe "run the package manager update", l
  task :pkg_update do
    l.info "pulling from package mgr repos, then upgrading OS packages"
    case os
    when OSType::RHEL
      sh "sudo dnf update -y"
    when OSType::GENTOO
      if Date.today > (DateTime.parse File.read "/var/db/repos/gentoo/metadata/timestamp.chk")
        sh "sudo emaint --auto sync"
      end
      sh "sudo emerge -vuDN @world"
    when OSType::UBUNTU
      sh "sudo apt update"
      sh "sudo apt upgrade -y"
    end
  end

  describe "clean the package manager's dependencies", l
  task :pkg_clean do
    case os
    when OSType::RHEL
      sh "sudo dnf autoremove"
    when OSType::GENTOO
      sh "sudo emerge --depclean"
    end
  end
end
