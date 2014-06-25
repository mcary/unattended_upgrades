#!/bin/sh
set -e

# Make sure a 2nd copy doesn't start via run-parts /etc/cron.daily
mv /etc/crontab /etc/crontab.disabled

echo "APT::Periodic::RandomSleep 1;" > /etc/apt/apt.conf.d/short_sleep
echo "APT::Periodic::Verbose 2;" > /etc/apt/apt.conf.d/verbose

# Update every time; don't wait a day
echo "APT::Periodic::Update-Package-Lists -1;" > /etc/apt/apt.conf.d/update_interval

# For 14.04 VM, root mail doesn't go to vagrant by default
if ! grep '^root:' /etc/aliases; then
    echo 'root: vagrant' >> /etc/aliases
    newaliases
fi

# These are specified as 1 in the default config, but need to be -1 to rerun
#echo "APT::Periodic::Download-Upgradeable-Packages -1;" > /etc/apt/apt.conf.d/download_upgradable_interval # download every time
#echo "APT::Periodic::Unattended-Upgrade -1;" > /etc/apt/apt.conf.d/55upgrade_interval # upgrade every time

# This could be adjusted to be root in /etc/aliases to work on Travis...
inbox=/var/mail/vagrant
if [ -s "$inbox" ]; then
  cat /dev/null > /var/mail/vagrant
fi

#rm /var/lib/apt/periodic/*

/etc/cron.daily/apt

echo -n "Waiting for mail in $inbox "
for i in `seq 1 10`; do
  if [ -s "$inbox" ]; then
    echo -n " received."
    break
  fi
  echo -n .
  sleep 1
done
echo


check_presence () {
  flags="$1"
  descr="$2"
  shift 2
  status=0

  echo "$descr"
  for expr in "$@"; do
    if grep -qE $flags "$expr" $inbox; then
      echo "  Ok: $expr"
    else
      echo "  Er: $expr"
      status=1
    fi
  done
  return $status
}

check_presence "" "Important parts of email" \
  "Subject: unattended-upgrades result for '(lucid64|precise64|ubuntu-14)'" \
  "Unattended upgrade returned: True" \
  "Packages that (were|are) upgraded:" \
  "Package installation log:" \
  "All upgrades installed" \

check_presence "" "Ensure at least *something* was installed" \
  "Preconfiguring packages" \
  "Unpacking (replacement |.+ over )" \
  "Setting up" \

# Only included with verbose level 3
#check_presence "" "Counts" \
#  "InstCount=" \
#  "BrokenCout=0" \
#
#check_presence "-v" "Non-zero installed" \
#  "InstCount=0" \

echo
echo "Tests Passed."
