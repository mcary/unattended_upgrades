# # encoding: utf-8

# Inspec test for recipe unattended_upgrades::default

describe package('mailutils') do
  it { should be_installed }
end

describe package('unattended-upgrades') do
  it { should be_installed }
end

describe file('/etc/apt/apt.conf.d/50unattended-upgrades') do
  it { should exist }
  its('mode') { should cmp '0444' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
end
