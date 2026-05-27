# Start with current Stable debian version
FROM debian:stable-slim AS temp_base

# Install One-Wire stuff to base
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install fuse -y && \    
    apt-get install owserver owfs owhttpd -y && \    
    apt-get autoremove -y && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*
# Not used 'programs' but possible add to 
#apt-get install ow-shell owftpd -y && \    
# Tools for investigation during development
#apt-get install net-tools iproute2 -y && \    

# Start-Script to Image
COPY ./to_container/start.sh /start.sh
# How Service Status
COPY ./to_container/show-status.sh /show-status.sh
# The configuration (for: USB > DS9490R)
COPY ./to_container/owfs.conf /etc/owfs.conf
# Fuse confif
COPY ./to_container/fuse.conf /etc/fuse.conf

# Make executable with: RUN chmod +x /[fname].sh
RUN ["chmod", "+x", "/start.sh"]
RUN ["chmod", "+x", "/show-status.sh"]

# Create folder for the 1wire structure (using FUSE)
RUN mkdir -p /mnt/1wire

# Make one image > Collapse
FROM scratch
COPY --from=temp_base / /

EXPOSE 4304
# 4304 — owserver: 
#      The main 1-Wire server daemon.
#      - Primary port clients use to communicate with owserver using the OWFS protocol.
#      - Other tools and libraries connect here to read/write 1-Wire device data.
EXPOSE 2120
# 2120 — owhttpd
#        The 1-Wire HTTP daemon.
#        Serves a simple web interface to browse the 1-Wire device tree and read sensor values through browser. 
#        Analogous to 2121 but over HTTP instead of FTP.
EXPOSE 2121
# 2121 — owftpd
#        The 1-Wire FTP daemon.
#        It exposes the 1-Wire device tree as an FTP filesystem, so you can browse sensors and read values using any FTP client.
#        Port 2121 is used instead of the standard 21 to avoid needing root privileges.

ENTRYPOINT ["/start.sh"]