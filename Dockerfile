FROM kmallea/steamcmd
MAINTAINER Christoph Giesel <mail@cgiesel.de>

# Run commands as the steam user
USER steam

# Install CS:GO
RUN mkdir /home/steam/csgo &&\
    cd /home/steam/steamcmd &&\
    ./steamcmd.sh \
        +login anonymous \
        +force_install_dir ../csgo \
        +app_update 740 validate \
        +quit

RUN mkdir -p /home/steam/.steam/sdk32
RUN cd /home/steam/steamcmd &&\
	ln -s linux32/steamclient.so /home/steam/.steam/sdk32/steamclient.so

COPY entrypoint.sh /

EXPOSE 27015
VOLUME ["/home/steam/csgo", "/home/steam/steamcmd"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["gotv"]