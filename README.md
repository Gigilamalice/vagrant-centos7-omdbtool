# vagrant-centos7-omdbtool

Create a vagrant box CENTOS/7 to run OMDBTOOL to retreive by example movies thumbdnail

## Projects and references

* OMDBTOOL <https://github.com/osmiyaki/omdbtool>
* VAGRANT <https://linuxacademy.com/blog/linux/vagrant-cheat-sheet-get-started-with-vagrant/>
* Stackoverflow : How to add Machine Name 
* Stackoverflow : How to add option variable
  * <https://stackoverflow.com/questions/17845637/how-to-change-vagrant-default-machine-name>

## Github

Git project Clone, you can choose target folde

``` shell
git clone https://github.com/Gigilamalice/vagrant-centos7-omdbtool.git vagrant-centos7-omdbtool
cd vagrant-centos7-omdbtool
```

Update your origin/master (remote repo from your clone / upstream)

```shell
git add .
git commit -m "version initiale du projet"
git push
```

Refresh your head (local repo)

```shell
git pull
```

## OmDB Tool

Create an OMDB API KEY: <http://www.omdbapi.com/apikey.aspx>

Add via sed or manually your OMDB_APIKEY in the vagrant file  

```shell
sed -i -e 's/OMDBAPIKEY/YOUR_OMDBAPIKEY/g' vagrant
```

## Vagrant tool

add box

```shell
vagrant box add centos/7
```

Install vagrant plugin tool

Scp between guest and host

```shell
# 1 - Install pluginvagrant plugin
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-scp
# 2 - Retreive ID vm
vagrant global-status
# 3a - Copy file or directory from Vagrant host machine to guest VM:
vagrant scp <some_local_file_or_dir> <vm_name>:<some_path_on_vm>
# 3b Copy file or directory from guest VM to Vagrant host machine:
vagrant scp <vm_name>:<some_file_or_dir_on_vm> <some_local_path>
```

Start Vagrant box

```shell
vagrant up
vagrant ssh
```

Stop vagrant box

```shell
vagrant halt
```

To a rsync from host to vagrant box (guest)

```shell
vagrant rsyn
vagrant rsyn-auto
```

Delete vagrant box

```shell
vagrant destroy -f
```

vagrant ssh config for putty by example

```shell
vagrant ssh-config
```

## Vagrant file

```shell
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# define hostname
NAME = "omdbtool"

# define OMDB API KEY
OMDB_API_KEY = "b8c4671d"

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

```
