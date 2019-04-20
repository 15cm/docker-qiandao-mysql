From debian:stretch

RUN apt-get update \
    && apt-get install -y python-pip autoconf g++ python-pbkdf2 \
    mariadb-client

ADD https://github.com/binux/qiandao/archive/master.tar.gz /qiandao-master.tar.gz
RUN tar xf qiandao-master.tar.gz \
    && rm qiandao-master.tar.gz \
    && mv qiandao-master qiandao

RUN pip install --no-cache-dir -r qiandao/requirements.txt

RUN apt-get purge -y \
    mariadb-client autoconf g++ \
    && apt-get clean

ADD run.sh /run.sh
ADD chrole.sh /chrole.sh
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /wait-for-it.sh

RUN chmod +x /wait-for-it.sh /run.sh /chrole.sh

ENV DB_TYPE=mysql
ENV MYSQL_HOST=localhost
ENV MYSQL_PORT=3306
ENV MYSQL_DATABASE=qiandao
ENV MYSQL_USER=qiandao
ENV MYSQL_PASSWORD=qiandao

EXPOSE 80

CMD ["/run.sh"]
