#!/bin/bash

echo "Digite 'sim' para confirmar a instalação "
read ACTION

if [ $ACTION == "sim" ];then
  
    echo "Criando o projeto da API"
	rails new quero_api --api 

    echo "Copiando Dockerfile"
	cp -p Dockerfile quero_api/ 
	cp -p entrypoint.sh quero_api/  

	echo "Gerando a aplicação"
	cd quero_api/
	rails g scaffold Sample data:string 
	
	echo "Criando Banco"
	rails db:migrate 
	rails runner "Sample.create(data: 'hello world')"
	
	echo "Baixando GEM para otimizar json"
	bundle add active_model_serializers 
	
	echo "Gerando arquivo de retorno json"
	rails generate serializer sample 
	cd app/serializers/
	sed -i 's/id/data/g' sample_serializer.rb 
	
	echo "Iniciando API na url http://localhost:3000/samples"
	rails server 

else

    echo "$ACTION - Encerrando script"
    exit 1   

fi