# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# define hostname
NAME = "omdbtool"

# define OMDB API KEY
OMDB_API_KEY = "b8c4671d"

puts 'OMDB API KEY: [OMDB_API_KEY]'
puts  [NAME]



$deployuserrootscript = <<-SCRIPT
echo ================================================================================
echo I am provisioning linux package and configuration ...
echo
echo as user: $(whoami), at current path: $(pwd), on hostname: $(hostname)
echo with args passed: $1
echo
echo ================================================================================

# yum update -y
# yum -y install python-pip -y
yum install -y wget
yum install -y git

# fix locale warning
echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

SCRIPT

$deployuservagrantscript = <<-SCRIPT
echo ================================================================================
echo I am provisioning omdbtool ...
echo
echo as user: $(whoami), at current path: $(pwd), on hostname: $(hostname)
echo with args passed: $1
echo  
echo ================================================================================

git clone https://github.com/bgr/omdb-cli.git
echo 'alias omdbtool="python ~/omdb-cli/omdbtool.py"' >> ~/.bashrc
echo export OMDB_API_KEY=$1 >> ~/.bashrc
export OMDB_API_KEY=$1
mkdir /vagrant/output
cd /vagrant/output

~/omdb-cli/omdbtool.py -t Cars | wget `sed -n '/^poster/{n;p;}'`

SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  # config.vm.box_version = "1811.02"
  config.vm.hostname = NAME
  config.vm.define NAME

  # config.vm.network "private_network", ip: "192.168.50.10"
  config.vm.synced_folder ".", "/vagrant"
  
  # Port forwarding
  #config.vm.network "forwarded_port", guest: 22, host: 2220

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = "2"
  end

  config.vm.provision "shell", privileged: true,  keep_color: true, inline: $deployuserrootscript, args:[NAME]
  config.vm.provision "shell", privileged: false, keep_color: true, inline: $deployuservagrantscript, args:[OMDB_API_KEY]
  config.vm.provision "shell", inline: "echo 'INSTALLER: Installation complete, CentOS 7 ready to use!'"
  
  #config.vm.provision "shell", path: "scripts/install.sh"
  # To reload reboot guest 
  #config.vm.provision :reload

end
