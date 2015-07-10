default[:unattended_upgrades][:upgrade_email] = "root@localhost"
default[:unattended_upgrades][:auto_reboot] = false
default[:unattended_upgrades][:enable_upgrades] = true

default[:unattended_upgrades][:blacklist] = %w() # %w(vim libc6 libc6-dev libc6-i686)
