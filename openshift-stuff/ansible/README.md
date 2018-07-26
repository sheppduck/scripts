Some additional Docker configurarations I've come across

(Maybe?) fix 'ignore docker storage'?

Update the docker config to use a LV for the docker storage
systemctl stop docker
rm -rf /var/lib/docker
vi /etc/sysconfig/docker-storage-setup
# File contents below
/bin/docker-storage-setup
systemctl start docker
systemctl enbale docker
docker info
lvs
