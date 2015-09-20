FROM kmallea/csgo
MAINTAINER Christoph Giesel <mail@cgiesel.de>

# Run commands as the steam user
USER steam

RUN mkdir -p /home/steam/.steam/sdk32
RUN cd /home/steam/steamcmd &&\
	ln -s linux32/steamclient.so /home/steam/.steam/sdk32/steamclient.so

# Update CS:GO
RUN cd /home/steam/steamcmd &&\
    ./steamcmd.sh \
        +login anonymous \
        +force_install_dir ../csgo \
        +app_update 740 \
        +quit

COPY entrypoint.sh /

EXPOSE 27015
VOLUME ["/home/steam/csgo", "/home/steam/steamcmd"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["gotv"]