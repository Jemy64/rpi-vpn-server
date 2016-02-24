#!/bin/ash
# Manage VPN secrets

case "$1" in
  export)
    echo "Exporting existing set of secrets to container volume '/mnt' ..."
    cd /etc/ipsec.d
    cp --force cacerts/* /mnt/
    cp --force certs/* /mnt/
    cp --force private/* /mnt/
    echo "Done!"
    ;;
  import)
    echo "Importing existing set of secrets from container volume '/mnt' ..."
    cd /mnt
    cp --force caCert.pem /etc/ipsec.d/cacerts/
    cp --force serverCert.pem clientCert.pem /etc/ipsec.d/certs/
    cp --force caKey.pem serverKey.pem clientKey.pem /etc/ipsec.d/private/
    echo "Done!"
    # some how '$ ipsec rereadall' does not do the job, let's go aggressive
    ipsec restart
    ;;
esac
