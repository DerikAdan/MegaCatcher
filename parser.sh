#!/bin/bash
#-------------------------------------------------------------------------------
# parser.sh
# Lê arquivos de configuração e converte os dados para variáveis do
# shell na saída padrão
#
# 2018.11.08 - Derik Adan
#-------------------------------------------------------------------------------

# Carregamento do arquivo de configuração como entrada na chamada do parser.sh
CONFIG=$1

# O arquivo deve existir e ser legível
if [ -z "$CONFIG" ]; then
  echo Uso: parser.sh arquivo.conf
  exit 1
elif [ ! -r "$CONFIG" ]; then
  echo Erro: Não consigo ler o arquivo $CONFIG
  exit 1
fi

# Leitura do arquivo de configuração
while read LINHA; do
  # Ignorando as linhas de comentário
  [ "$(echo $LINHA | cut -c1)" = '#' ] && continue

  # Ignorando as linhas em branco
  [ "$LINHA" ] || continue

  # Guardando cada palavra da linha em $1, $2, $3, ...
  set - $LINHA

  # Extração dos dados
  chave=$(echo $1 | tr a-z A-Z)
  shift
  valor=$*

  # Mostrando chave="valor" na saída padrão
  echo "CONF_$chave=\"$valor\""
done < "$CONFIG"
