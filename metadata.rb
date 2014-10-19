maintainer 'Marcel M. Cary'
maintainer_email 'marcel@oak.homeunix.org'
license 'Apache 2.0'
description 'Installs/Configures APT unattended_upgrades'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version '0.1.2'
name 'unattended_upgrades'

%w(
  ubuntu
  debian
).each do |os|
  supports os
end

attribute 'unattended_upgrades/upgrade_email',
          display_name: 'Unattended Upgrade Email',
          description: 'Email to receive notifications' 'regarding APT package upgrades',
          default: 'root@localhost'

attribute 'unattended_upgrades/auto_reboot',
          display_name: 'Unattended Upgrade Auto-Reboot',
          description: 'Whether to reboot unattended when suggested by package updates',
          default: 'false'
