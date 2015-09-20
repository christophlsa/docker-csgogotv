FROM kmallea/steamcmd
MAINTAINER Christoph Giesel <mail@cgiesel.de>

# Install CS:GO
RUN mkdir /opt/csgo &&\
    cd /opt/steamcmd &&\
    ./steamcmd.sh \
        +login anonymous \
        +force_install_dir ../csgo \
        +app_update 740 validate \
        +quit

RUN mkdir -p /root/.steam/sdk32
RUN cd /opt/steamcmd &&\
	ln -s linux32/steamclient.so /root/.steam/sdk32/steamclient.so

COPY entrypoint.sh /

EXPOSE 27015
VOLUME ["/opt/csgo", "/opt/steamcmd"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["gotv"]