#!/usr/bin/env sh
#########################################################
# Création :      Sebastien Lemoal <slemoal@tiscom.fr> #
# Modifications :                                     #
######################################################

# Tous droits réservés

######################
#      CHANGELOG     #
#########################################################
# 2021/07 - Script initial - slemoal                   #
#######################################################

#######################################
# Définition des Variables           #
#####################################
HOST=$(uname -n) # Se change depuis l'interface web "Admin -> Network -> Nom d'hote"
LOGIN=domaine-id
PASSWORD=LenSuperMotDePasseAutogénéréDuCompteOvh

PATH_LOG=/var/log/dynhostovh.log

HOST_IP=$(dig +short $HOST A) # Récupérer l'IP du domaine OVH

# Récupérer l'IP PUBLIC
CURRENT_IP=$(curl ifconfig.me)
echo curl "ifconfig.me="$CURRENT_IP
if [ -z $CURRENT_IP ]
then
  CURRENT_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
  echo curl "dig + short myip.opendns.com="$CURRENT_IP
fi
CURRENT_DATETIME=$(date -R)

#######################################
# Mise à jour du dynhost si besoin   #
#####################################

if [ -z $CURRENT_IP ] || [ -z $HOST_IP ]
then
  echo "[$CURRENT_DATETIME]: No IP retrieved" >> $PATH_LOG
  echo "[$CURRENT_DATETIME]: No IP retrieved"
else
  if [ "$HOST_IP" != "$CURRENT_IP" ]
  then
    RES=$(curl -m 5 -L --location-trusted --user "$LOGIN:$PASSWORD" "https://www.ovh.com/nic/update?system=dyndns&hostname=$HOST&myip=$CURRENT_IP")
    echo "[$CURRENT_DATETIME]: IPv4 has changed - request to OVH DynHost: $RES" >> $PATH_LOG
    echo "[$CURRENT_DATETIME]: IPv4 has changed - request to OVH DynHost: $RES"
  else
    echo "L'IP n'a pas changé, pas de mise à jour necessaire"
  fi
    echo "HOST_IP="$HOST_IP
    echo "CURRENT_IP="$CURRENT_IP
fi
