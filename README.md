# vagrant-centos7-omdbtool

Creation d'une box vagrant CENTOS/7 et OMDBTOOL pour recuperer des jaquettes de films 


## Projets et références

* https://github.com/osmiyaki/omdbtool
* https://linuxacademy.com/blog/linux/vagrant-cheat-sheet-get-started-with-vagrant/

## Github

> Git clone du projet

``` shell
git clone https://github.com/Gigilamalice/vagrant-centos7-omdbtool.git''
cd vagrant-centos7-omdbtool
```

> Mise à jour du repo

```shell
git add .
git commit -m "version initiale du projet"
git push
```

## OMBTOOL
> Création de l'OMDB APIKEY via ce lien:
> http://www.omdbapi.com/apikey.aspx

> Add manually or via sed your OMDB_APIKEY in the vagrant file  

```shell
sed -i -e 's/OMDBAPIKEY/YOUR_OMDBAPIKEY/g' vagrant
```


## Vagrant

> Démarrage de la Vagrant box

```shell
vagrant up
vagrant ssh
```

> Arrêt de la vagrant box
```shell
vagrant halt
```


> Suppression de la vagrant box
```shell
vagrant destroy
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