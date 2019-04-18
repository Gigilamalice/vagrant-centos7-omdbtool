# vagrant-centos7-omdbtool

Creation d'une box vagrant CENTOS/7 et OMDBTOOL pour recuperer des jaquettes de films 


## Projets et références utilisés:

* https://github.com/osmiyaki/omdbtool
* https://linuxacademy.com/blog/linux/vagrant-cheat-sheet-get-started-with-vagrant/

## Github

Git clone du projet

``` bash
git clone https://github.com/Gigilamalice/vagrant-centos7-omdbtool.git''
cd vagrant-centos7-omdbtool
```

Mise à jour du repo

```bash
git commit -m "version initiale du projet"
git add .
git push
```

## Vagrant

Démarrage de la Vagrant box

```bash
vagrant up
vagrant ssh
```

Arrêt de la vagrant box
```bash
vagrant halt
```


Suppression de la vagrant box
```bash
vagrant destroy
```


## Creation du fichier vagrant file


## fix locale warning

echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

sudo yum update -y

sudo yum install wget -y
sudo yum install git -y
sudo yum install pip
sudo yum -y install python-pip -y


git clone https://github.com/bgr/omdb-cli.git

cd omdb-cli.git

echo "alias omdbtool='python /home/vagrant/omdb-cli/omdbtool.py'" >> .bashrc
echo "export OMDB_API_KEY=b8c4671d" >> .bashrc