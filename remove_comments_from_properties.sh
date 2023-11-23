#!/bin/bash

# Diretório dos arquivos
diretorio="/guia_instances"

# Padrões de linhas a serem descomentadas
padroes=("^#db.i18n." "^#db.ajuda." "^#db.correios.")

# Lista para armazenar os nomes dos arquivos modificados
arquivos_modificados=()

# Loop através dos subdiretórios i29 e i30
for subdiretorio in "$diretorio"/i*/config; do
  # Verifica se há arquivos *.properties no diretório
  if [ -n "$(find "$subdiretorio" -maxdepth 1 -type f -name '*.properties')" ]; then
    # Descomenta as linhas correspondentes aos padrões em cada arquivo *.properties no diretório
    arquivos_modificados+=($(find "$subdiretorio" -maxdepth 1 -type f -name '*.properties' -exec sed -i -E '/^'"$(IFS=\|; echo "${padroes[*]}")"'/ s/^#(.*)/\1/' {} \; -print))
    
    echo "Linhas correspondentes aos padrões descomentadas nos arquivos em $subdiretorio."
  else
    echo "Nenhum arquivo *.properties encontrado em $subdiretorio."
  fi
done

# Exibe os nomes dos arquivos modificados
echo "Arquivos modificados:"
for arquivo_modificado in "${arquivos_modificados[@]}"; do
  echo "$arquivo_modificado"
done
