require "rake"

module OSType
  OTHER = 0
  RHEL = 1
  GENTOO = 2
end

def os
  case File.foreach("/etc/os-release").lazy.grep(/^ID=/).first
  when /fedora/
    OSType::RHEL
  when /gentoo/
    OSType::GENTOO
  when /rocky/
    OSType::RHEL
  else
    OSType::OTHER
  end
end

taskgroup :os, "upgrade os" do
  desc "run a full os update and cleanup"
  task all: [:pkg_update, :pkg_clean]

  desc "run the package manager update"
  task :pkg_update do
    case os
    when OSType::RHEL
      sh "sudo dnf update -y"
    when OSType::GENTOO
      if Date.today > (DateTime.parse File.read "/var/db/repos/gentoo/metadata/timestamp.chk")
        sh "sudo emaint --auto sync"
      end
      sh "sudo emerge -vuDN @world"
    end
  end

  desc "clean the package manager's dependencies"
  task :pkg_clean do
    case os
    when OSType::RHEL
      sh "sudo dnf autoremove"
    when OSType::GENTOO
      sh "sudo emerge --depclean"
    end
  end
end
