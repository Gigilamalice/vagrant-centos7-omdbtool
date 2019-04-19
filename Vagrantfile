$samplescript = <<SCRIPT

# yum update -y

yum install -y wget
yum install -y git
# yum -y install python-pip -y

# fix locale warning

echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

su vagrant
cd ~

git clone https://github.com/bgr/omdb-cli.git

echo "alias omdbtool='python /home/vagrant/omdb-cli/omdbtool.py'" >> .bashrc
echo "export OMDB_API_KEY=OMDBAPIKEY" >> .bashrc
echo "export OMDB_API_KEY=b8c4671d" >> .bashrc
source .bashrc

cd omdb-cli
omdbtool


SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# define hostname
NAME = "omdbtool01"

# unless Vagrant.has_plugin?("vagrant-reload")
#  puts 'Installing vagrant-reload Plugin...'
#  system('vagrant plugin install vagrant-reload')
# end

# unless Vagrant.has_plugin?("vagrant-proxyconf")
#  puts 'Installing vagrant-proxyconf Plugin...'
#  system('vagrant plugin install vagrant-proxyconf')
# end

unless Vagrant.has_plugin?("vagrant-vbguest")
  puts 'Installing vagrant-vbguest Plugin...'
  system('vagrant install vagrant-vbguest')
end

unless Vagrant.has_plugin?("vagrant-scp")
  puts 'Installing vagrant-scp Plugin...'
  system('vagrant install vagrant-scp')
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
#  config.vm.box_version = "1811.02"
  config.vm.hostname = NAME
#  config.vm.network "private_network", ip: "192.168.50.10"
  config.vm.synced_folder ".", "/vagrant"

# Port forwarding
# config.vm.network "forwarded_port", guest: 22, host: 2220

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = "2"
  end

  config.vm.provision "shell", inline: $samplescript
  # config.vm.provision "shell", path: "scripts/install.sh"
  config.vm.provision :reload
  config.vm.provision "shell", inline: "echo 'INSTALLER: Installation complete, CentOS 7 ready to use!'"
  

end
