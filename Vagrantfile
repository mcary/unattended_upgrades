# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'vagrantup.com/lucid64'
  config.vm.box_url = 'http://files.vagrantup.com/lucid64.box'

  config.vm.define '10.04', primary: true do
    # Just the global config
  end

  config.vm.define '12.04', autostart: false do |precise|
    precise.vm.box = 'hashicorp/precise64'
    precise.vm.box_url = 'https://vagrantcloud.com/hashicorp/precise64'
  end

  config.vm.define '14.04', autostart: false do |trusty|
    trusty.vm.box = 'phusion/trusty64'
    trusty.vm.box_url = 'https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box'
  end

  excludes = [
    '/.git',
    '/.vagrant',
    '/tmp',
    '.*.swp',
    '.*.swo'
  ]

  excl = excludes.map { |e| "--exclude '#{e}'" }.join(' ')
  config.vm.provision 'shell', inline: <<-EOF
    set -e
    set -x
    cd /vagrant
    mkdir -p tmp/cookbooks
    rsync -av --delete ./ tmp/cookbooks/unattended_upgrades #{excl}
    apt-get update
  EOF

  config.vm.provision 'chef_solo' do |chef|
    chef.cookbooks_path = 'tmp/cookbooks'
    chef.add_recipe 'unattended_upgrades'
  end
end
