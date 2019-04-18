$samplescript = <<SCRIPT

yum install -y wget
yum install -y git

# yum install -y httpd
# systemctl enable httpd
# systemctl start httpd

# fix locale warning

echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

su vagrant

git clone https://github.com/bgr/omdb-cli.git
cd omdb-cli.git

echo "alias omdbtool='python /home/vagrant/omdb-cli/omdbtool.py'" >> .bashrc
echo "export OMDB_API_KEY=b8c4671d" >> .bashrc


SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "omdbtool"
#  config.vm.network "private_network", ip: "192.168.50.10"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: $samplescript

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = "2"
  end
end
