#!/bin/bash

# Verifique se a pasta flutter existe
if cd flutter; then
  # Se a pasta existir, atualize o repositório
  git pull
  cd ..
else
  # Se a pasta não existir, clone o repositório do Flutter
  git clone https://github.com/flutter/flutter.git
fi

# Liste os arquivos no diretório atual
ls

# Verifique o estado do Flutter
flutter/bin/flutter doctor

# Limpe os builds antigos do Flutter
flutter/bin/flutter clean

# Habilite o suporte para web no Flutter
flutter/bin/flutter config --enable-web

# Obtenha as dependências do projeto Flutter
flutter/bin/flutter pub get

# Baixe e instale a Firebase CLI
curl -sL https://firebase.tools | bash

# Faça login no Firebase (necessita interação manual via navegador)
firebase login:ci --no-localhost

# Ative o flutterfire CLI globalmente usando dart pub
flutter/bin/dart pub global activate flutterfire_cli

# Configure o flutterfire para o projeto específico
flutter/bin/dart pub global run flutterfire_cli configure --project=authfirebase-63b69
