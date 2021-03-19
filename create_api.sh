#!/bin/bash
rails new quero_api --api #cria o projeto em ruby o --api deixa o mais leve reduzindo a parte do html
cp -p Dockerfile quero_api/  #copia o docker file para uso futuro em ci/cd
cp -p entrypoint.sh quero_api/  #copia o script entrypoint.sh para uso do docker file
cd quero_api/
rails g scaffold Sample data:string #maneira rapida de gerar as maiores partes da aplicação
rails db:migrate #transforma a classe disponivel e transforma em um banco de dados
rails runner "Sample.create(data: 'hello world')"
bundle add active_model_serializers #gem que facilita modificar a resposta do json
rails generate serializer sample #cria o arquivo para otimizarmos nosso retorno json
cd app/serializers/
sed -i 's/id/data/g' sample_serializer.rb #substitui a variavel id por data para o retorno do GET
rails server #inicia a aplicação