#!/bin/bash
#---------------------------------------------------------------------------
#
# Script para coleta de dados de Comtech EF Data Modem
# Autores: Derik Adan
#          Rafael Augusto
# Data: 08 de novembro de 2018

# Localização do arquivo de configuração
CONFIG="megacatcher.conf"
source parser.sh

# Carregando a configuração de arquivo externo
#eval $(./parser.sh $CONFIG)

while IFS='' read -read line || [[ -n "$line" ]]; do

DESTACAMENTO=``
IP_CDM=``
`curl 'http://'$IP_CDM'/Forms/csat_status_1' -H 'Host: '$IP_CDM'' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-GB,en;q=0.5' --compressed -H 'Referer: http://'$IP_CDM'/odu/csat_status.htm' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Authorization: Basic Y29tdGVjaDpjb210ZWNo' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' --data 'oduselect=1&Submit=Select+ODU'`

`curl 'http://'$IP_CDM'/odu/csat_status.htm' -H 'Host: '$IP_CDM'' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-GB,en;q=0.5' --compressed -H 'Referer: http://'$IP_CDM'/odu/csat_status.htm' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1'`
done < $BASE_CADASTRO
#---------------------------------------------------------------------------------------------------

#--------------[ SELEÇÃO DE ODUs ]---------------
Menu_Principal=$(dialog --stdout \
        --menu "Mega Catcher" \
        0 0 0 \
        Selecionar "Selecionar ODUs a monitorar" \
        Adicionar "Adicionar novas ODUs" \
        Remover "Remover ODUs do sistema")

case "$Menu_Principal" in
        Selecionar)
                # Abre novo menu de seleção das ODUs a monitorar
                monitorar=$(dialog --stdout --radiolist "" 0 0 0 )

        ;;
        Adicionar)
                IP_ODU=$(dialog --stdout --imputbox "Digite o IP da ODU:" 0 0)
                [ "$IP_ODU" ] || exit 1

                # Confere se já existe o cadastro da ODU
                tem_chave "$IP_ODU" && {
                        msg="Já existe um cadastro de ODU com IP: '$IP_ODU'"
                        dialog --msgbox "$msg" 6 40
                        exit 1
                }

                # Novo cadastro
                Nome_ODU=$(dialog --stdout --inputbox "DTCEA-XX:" 0 0)
        ;;
esac
