FROM debian:stable
LABEL maintainer="marcioprado@marcioprado.eti.br"

WORKDIR /root/

RUN apt-get update && apt-get upgrade && \
apt-get -y install gcc build-essential python python-argparse python-dateutil \
python-setuptools python-dev python-imaging git scons swig libssl-dev libffi-dev unzip wget nano

RUN mkdir /root/whatsapp && cd /root/whatsapp && \
wget https://github.com/tgalal/yowsup/archive/master.zip && \
unzip master.zip && cd yowsup-master && ./setup.py install

RUN echo "cc=55\nphone=CodPaisDDDNumeroCelular\n\
id=ID_RetornadoNoRegistro\n\
client_static_keypair=ChaveRetornadaNoRegistro" > /root/configuracao.conf

RUN echo "Para requisitar um codigo:\nyowsup-cli registration --requestcode sms --config-phone CodPaisDDDNumeroCelular --config-cc 55 --config-mcc 724 --config-mnc 06\n\n\
Para registar:\nyowsup-cli registration --register CODIGO-RECEBIDO --config-phone CodPaísDDDNumeroCelular\n\n\
Para enviar mensagem:\nyowsup-cli demos -s CodPaisDDDNumeroCelularDestino 'Mensagem' -c /root/whatsapp/configuracao.conf" > /root/LEIAME.txt
