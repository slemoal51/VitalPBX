#!/bin/bash
###########################################################
# Création :      Sébastien Le Moal <contact@slemoal.fr> #
# Modifications :                                       #
########################################################

# Tous droits réservés

######################
#      CHANGELOG    #
#########################################################
# 2021/11 - Script initial - slemoal                   #
#######################################################

#######################################
# Définition des Variables           #
#####################################

host_zabbix=`uname -n`
path_zabbix_proxy=/etc/zabbix/zabbix_proxy.conf
path_zabbix_agent2=/etc/zabbix/zabbix_agent2.conf

#######################################
# Début du script                    #
#####################################
# Proxy zabbix
if  ! grep -q $host_zabbix $path_zabbix_proxy;
	then
		sed -i "s/\(Hostname=\).*/\Hostname=${host_zabbix}/" ${path_zabbix_proxy}
		/bin/systemctl restart zabbix-proxy.service
		echo "zabbix proxy: Hostname="$host_zabbix $path_zabbix_proxy "modifié"
	else
		echo "zabbix proxy: Hostname="$host_zabbix" est à jour"
fi

# Agent2 Zabbix
if  ! grep -q $host_zabbix $path_zabbix_agent2;
	then
		sed -i "s/\(Hostname=\).*/\Hostname=${host_zabbix}/" ${path_zabbix_agent2}
		/bin/systemctl restart zabbix-agent2.service
		echo "zabbix agent2: Hostname="$host_zabbix $path_zabbix_proxy "modifié"
	else
		echo "zabbix agent2: Hostname="$host_zabbix" est à jour"
fi
