#!/bin/sh
if [ ! -f /conf/aria2.conf ]; then
	cp /conf-copy/aria2.conf /conf/aria2.conf
	if [ $SECRET ]; then
		echo "rpc-secret=${SECRET}" >> /conf/aria2.conf
	fi
fi
if [ ! -f /conf/on-complete.sh ]; then
	cp /conf-copy/on-complete.sh /conf/on-complete.sh
fi
if [ ! -f /conf/supervisord.conf  ]; then
	cp /conf-copy/supervisord.conf /conf/supervisord.conf 
fi
if [ ! -f /conf/on-complete.sh ]; then
	cp /conf-copy/dht.dat /conf/dht.dat
fi
chmod +x /conf/on-complete.sh
touch /conf/aria2.session

darkhttpd /aria2-webui --port 6893 &
darkhttpd /data --port 6894
