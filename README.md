# vagrant-centos7-omdbtool

Create a vagrant box CENTOS/7 to run OMDBTOOL to retreive by example movies thumbdnail

## Projects and references

* <https://github.com/osmiyaki/omdbtool>
* <https://linuxacademy.com/blog/linux/vagrant-cheat-sheet-get-started-with-vagrant/>

## Github

Git project Clone, you can choose target folde

``` shell
git clone https://github.com/Gigilamalice/vagrant-centos7-omdbtool.git vagrant-centos7-omdbtool
cd vagrant-centos7-omdbtool
```

Mise à jour du repo

```shell
git add .
git commit -m "version initiale du projet"
git push
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
vagrant install vagrant-vbguest
vagrant install vagrant-scp
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
vagrant destroy
```

vagrant ssh config for putty by example

```shell
vagrant ssh-config
```

## Vagrant file

```shell
$samplescript = <<SCRIPT

## fix locale warning

echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

#sudo yum update -y

sudo yum install wget -y
sudo yum install git -y
sudo yum install pip
sudo yum -y install python-pip -y

su vagrant

git clone https://github.com/bgr/omdb-cli.git
cd omdb-cli.git

echo "alias omdbtool='python /home/vagrant/omdb-cli/omdbtool.py'" >> .bashrc
echo "export OMDB_API_KEY=OMDBAPIKEY" >> .bashrc

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
```