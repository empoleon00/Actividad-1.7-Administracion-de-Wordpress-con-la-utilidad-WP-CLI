#!/bin/bash
set -ex

# Importamos el .env
source .env

# Copiamos plantilla del archivo virtual host en el server importante
cp ../conf/000-default.conf /etc/apache2/sites-available

# Conf del server name en virtualHost importante
sed -i "s/snavgon3112.serveminecraft.net/$CERTBOT_DOMAIN/" /etc/apache2/sites-available/000-default.conf

# Realizamos la instalación y actualización de snapd.
sudo snap install core
sudo snap refresh core

# Eliminamos si existiese alguna instalación previa de certbot con apt.
sudo apt remove certbot -y

# Instalamos el cliente de Certbot con snapd.
sudo snap install --classic certbot

# Creamos una alias para el comando certbot.
sudo ln -fs /snap/bin/certbot /usr/bin/certbot

# Obtenemos el certificado y configuramos el servidor web Apache.
#sudo certbot --apache

# Variable $certbot_email automatica con script
certbot --apache -m $CERTBOT_EMAIL --agree-tos --no-eff-email -d $CERTBOT_DOMAIN --non-interactive