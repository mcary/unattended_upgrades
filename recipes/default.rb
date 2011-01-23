#
# Cookbook Name:: unattended_upgrades
#

# Required for problem notification
package "mailutils"

package "unattended-upgrades"

cookbook_file "/etc/apt/apt.conf.d/50unattended-upgrades"
