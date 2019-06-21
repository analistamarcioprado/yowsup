1 - Criar o contêiner
docker run -d -it --name whatsapp --hostname whatsapp marcioprado/yowsup:latest

2 - Requisitar um código SMS
Depois do contêiner criado, há necessidade de requisitar um código SMS. Com o chip SIM no celular faça login no contêiner e solicite um código de registro:

yowsup-cli registration --requestcode sms --config-phone CodPaisDDDNumCel --config-cc CodPais --config-mcc 724 --config-mnc 06

Códigos: CC (Country Code), MCC (Mobile Country Code) e MNC (Mobile Network Code).
Maiores detalhes: https://en.wikipedia.org/wiki/Mobile_country_code
Exemplo: Brasil CC = 55, Vivo MCC = 724, Vivo MNC = 06

3 - Registar o contêiner
Com o código recebido no celular registre o contêiner:

yowsup-cli registration --register CODIGO-RECEBIDO --config-phone CodPaisDDDNumCel

4 - Editar o arquivo de configurações
nano /root/configuracao.conf

cc=55
phone=CodPaisDDDNumCel
id=ID_RETORNADO_REGISTRO
client_static_keypair=CHAVE_RETORNADA_REGISTRO

5 - Configurar status e imagem do perfil
yowsup-cli demos -c /root/configuracao.conf -y
/L
/profile setPicture 'caminho_imagem/imagem.jpg'
/profile setStatus 'Escreva seu status aqui'
/disconnect

6 - Enviar mensagem
Logado no contêiner:
yowsup-cli demos -s CodPaisDDDNumCelDestino 'Mensagem' -c /root/configuracao.conf

Logado no hospedeiro:
docker exec whatsapp sh -c "yowsup-cli demos -s CodPaisDDDNumCelDestino 'Mensagem.' -c /root/configuracao.conf"

Observações:

Mensagens para WhatsApp registrado em celulares brasileiros, não se deve colocar o primeiro 9.
7 - Site oficial do projeto
http://www.openwhatsapp.org
