# vagrant-centos7-omdbtool

Creation d'une box vagrant CENTOS/7 et OMDBTOOL pour recuperer des jaquettes de films 
Projets et références utilisés:
- https://github.com/osmiyaki/omdbtool
- https://linuxacademy.com/blog/linux/vagrant-cheat-sheet-get-started-with-vagrant/

* Git clone the projet

''git clone https://github.com/Gigilamalice/vagrant-centos7-omdbtool.git''

''
git commit -m "version initiale du projet"
git add .
git push
''

* Start Vagrant box

''
vagrant up
vagrant ssh
''


# Creation du fichier vagrant file
#
# https://github.com/osmiyaki/omdbtool
#

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