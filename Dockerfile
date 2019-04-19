From debian:stretch

ENV DB_TYPE=mysql

RUN apt-get update \
    && apt-get install -y python-pip autoconf g++ python-pbkdf2 \
    mariadb-client wget unzip

RUN wget https://github.com/binux/qiandao/archive/master.zip -O qiandao-master.zip \
    && unzip qiandao-master.zip \
    && rm qiandao-master.zip \
    && mv qiandao-master qiandao

RUN pip install --no-cache-dir -r qiandao/requirements.txt

RUN apt-get purge -y \
    mariadb-client autoconf g++ wget unzip \
    && apt-get clean

ADD run.sh /run.sh

EXPOSE 80

CMD ["/run.sh"]