# Vagrant
vagrant images for different handling.

# mean
See http://mean.io/#!/ - this is an example to create a CentOS-7 image with men.io installed.

## Steps

Clone the repository:

```bash
git clone git@github.com:Scrier/Vagrant.git
```

Start the vagrant file:

```bash
cd Vagrant/mean
vagrant up
vagrant ssh
``` 

Inside vagrant run the install script.

```bash
cd /vagrant
sudo ./install.sh
```

Follow instructions on mean.io to work with your project.

