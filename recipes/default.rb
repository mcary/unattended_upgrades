#
# Cookbook Name:: unattended_upgrades
#

# Required for problem notification
package "mailutils"

package "unattended-upgrades"

template "/etc/apt/apt.conf.d/50unattended-upgrades" do
  mode "444"
  variables({
    :upgrade_email => node[:unattended_upgrades][:upgrade_email],
    :auto_reboot => node[:unattended_upgrades][:auto_reboot]
  })
end
