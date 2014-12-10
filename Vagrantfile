# -*- mode: ruby -*-
# vim: set ft=ruby ts=2 sw=2 et sts=2 :

VAGRANTFILE_API_VERSION = "2"
CURRENT_USER = `whoami`.chomp

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "{{ name }}-#{CURRENT_USER}"

  config.vm.box = "stackstrap/ubuntu-trusty"

  config.vm.network :public_network

  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/home/vagrant/domains/{{ name }}",
    owner: "vagrant",
    group: "vagrant",
    mount_options: ["dmode=755,fmode=644"]

  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
  end

  config.vm.provision :shell,
    inline: "echo; echo; echo \"Your development environment is now configured\"; echo \"You can access it at http://{{ name }}-#{CURRENT_USER}.local/\"; echo"
end
