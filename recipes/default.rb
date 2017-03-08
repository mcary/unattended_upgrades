#
# Cookbook Name:: unattended_upgrades
#

# Required for problem notification
package "mailutils"

package "unattended-upgrades" do
  notifies :run, 'execute[unattended-upgrades]', :delayed if node[:unattended_upgrades][:run_immediately]
end

template "/etc/apt/apt.conf.d/50unattended-upgrades" do
  mode "444"
  variables(
    :upgrade_email => node[:unattended_upgrades][:upgrade_email],
    :auto_reboot => node[:unattended_upgrades][:auto_reboot],
    :enable_upgrades => node[:unattended_upgrades][:enable_upgrades]
  )
end

execute 'unattended-upgrades' do
  action :nothing
end
