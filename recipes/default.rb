#
# Cookbook Name:: unattended_upgrades
#

# Required for problem notification
package "mailutils"

package "unattended-upgrades"

template "/etc/apt/apt.conf.d/50unattended-upgrades" do
  mode "444"
  variables(
    :upgrade_email => node[:unattended_upgrades][:upgrade_email]
  )
end
