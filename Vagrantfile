$preboot_script = <<PREBOOT
#!/bin/sh
set -eu

export DEBIAN_FRONTEND=noninteractive
echo "deb http://ftp.debian.org/debian stretch-backports main" | sudo tee /etc/apt/sources.list.d/backports.list

# Basic hygiene.
apt-get -y update
apt-get -y upgrade
apt-get -y install apt-transport-https openjdk-11-jdk maven postgresql-9.6

sudo -u postgres /usr/bin/createuser -s vagrant
sudo -u postgres /usr/bin/createdb tempo -O vagrant
sudo -u vagrant /usr/bin/psql -d tempo -c "ALTER ROLE vagrant WITH LOGIN PASSWORD 'postgres'"

sudo -u vagrant ln -sf /vagrant ~vagrant/tempo

PREBOOT

$post_up_msg = <<MSG
tempo development VM
=======================

Now run `vagrant ssh` to get into the VM.

Working directory is in `tempo/service`.

Run `mvn clean install` to compile and `mvn exec:java -pl tempo-core` to build.

MSG

Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian9"
  config.vm.box_version = "~> 1.8"
  config.vm.synced_folder ".", "/vagrant"
  config.vm.hostname = "tempo.box"
  config.vm.provision :shell, :inline => $preboot_script
  # config.vm.provision :reload
  # TODO: can we force-converge in a postboot script?

  # Host-to-guest networking.
  # Your host: 172.16.0.1; the VM: 172.16.0.2.
  config.vm.network "private_network", ip: "172.16.0.2"

  # Interface that DHCPs to whatever router is on your network.
  # Generally used for outbound Internet access.
  config.vm.network "public_network"

  config.vm.post_up_message = $post_up_msg
end
