module OSType
  OTHER = 0
  RHEL = 1
  GENTOO = 2
  UBUNTU = 3
end

class Os
  def self.l
    @l ||= SemanticLogger["os"]
  end

  def self.get_os
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

  def self.pkg_update
    l.info "pulling from package mgr repos, then upgrading OS packages"
    case get_os
    when OSType::RHEL
      system "sudo dnf update -y"
    when OSType::GENTOO
      if Date.today > (DateTime.parse File.read "/var/db/repos/gentoo/metadata/timestamp.chk")
        system "sudo emaint --auto sync"
      end
      system "sudo emerge -vuDN @world"
    when OSType::UBUNTU
      system "sudo apt update"
      system "sudo apt upgrade -y"
    end
  end

  def self.pkg_clean
    case get_os
    when OSType::RHEL
      system "sudo dnf autoremove"
    when OSType::GENTOO
      system "sudo emerge --depclean"
    end
  end

  def self.all
    pkg_update
    pkg_clean
  end
end
