FROM alpine:edge

MAINTAINER xujinkai <jack777@xujinkai.net>

RUN apk update && \
	apk add --no-cache --update supervisor bash && \
	mkdir -p /conf && \
	mkdir -p /conf-copy && \
	mkdir -p /data && \
	apk add --no-cache --update aria2 && \
	apk add git && \
	git clone https://github.com/ziahamza/webui-aria2 /aria2-webui && \
    rm /aria2-webui/.git* -rf && \
    apk del git && \
	apk add --update darkhttpd 

ADD files/start.sh /conf-copy/start.sh
ADD files/aria2.conf /conf-copy/aria2.conf
ADD files/on-complete.sh /conf-copy/on-complete.sh
ADD files/supervisord.conf /conf-copy/supervisord.conf
ADD files/supervisord.conf /conf-copy/supervisord.conf
ADD files/dht.dat /conf-copy/dht.dat

RUN chmod +x /conf-copy/start.sh


#configure supervisor
RUN mkdir -p /var/log/supervisor



WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
EXPOSE 6800
EXPOSE 80
EXPOSE 8080

#run!
entrypoint ["/usr/bin/supervisord","-c","/conf-copy/supervisord.conf"]

	
