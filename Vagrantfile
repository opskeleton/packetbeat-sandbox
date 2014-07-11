# -*- mode: ruby -*-
# vi: set ft=ruby :
update = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak s/us.archive/il.archive/g /etc/apt/sources.list
  sudo aptitude update 
  touch /tmp/up
fi
SCRIPT


Vagrant.configure("2") do |config|

  bridge = ENV['VAGRANT_BRIDGE']
  bridge ||= 'eth0'
  env  = ENV['PUPPET_ENV']
  env ||= 'dev'

  config.vm.box = 'ubuntu-14.04_puppet-3.6.1' 
  config.vm.network :public_network, :bridge => bridge
  config.vm.hostname = 'packerbeat.local'

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', 4048, '--cpus', 4]
  end

  config.vm.provision :shell, :inline => update
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = 'default.pp'
    puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"

  end

end
