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
      l.info "detected RHEL-like OS"
      system "sudo dnf update -y"
    when OSType::GENTOO
      l.info "detected gentoo (you are hard-core)"
      if Date.today > (DateTime.parse File.read "/var/db/repos/gentoo/metadata/timestamp.chk")
        system "sudo emaint --auto sync"
      end
      system "sudo emerge -vuDN @world"
    when OSType::UBUNTU
      l.info "detected ubuntu"
      system "sudo apt update"
      system "sudo apt upgrade -y"
    else
      l.error "i don't know what OS we're using"
    end
  end

  def self.pkg_clean
    l.info "cleaning packages"
    case get_os
    when OSType::RHEL
      l.info "detected RHEL-like OS"
      system "sudo dnf autoremove"
    when OSType::GENTOO
      l.info "detected gentoo (you are hard-core)"
      system "sudo emerge --depclean"
    else
      l.error "i don't know what OS we're using"
    end
  end

  def self.all
    pkg_update
    pkg_clean
  end
end
