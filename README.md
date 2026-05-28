# OWSERVER to read 1wire values

## What it is for?

Create a Docker image, then use it to run a Docker container.

The running Container then will provide

1. A **One-Wire-Server (OWSERVER)** to be accessed by clients.
   Typically a Smarthome-App like Home Assistant. 
2. A **Website provided by OWHTTPD** to investigate found 1wire-devices

 ## Source of Image at GitHub (with Dockerfile):

[https://github.com/twischi/owserver](https://github.com/twischi/owserver)

## Ready to use Image at Docker-Hub:
[https://hub.docker.com/r/twischi/owserver](https://hub.docker.com/r/twischi/owserver)

## 1wire hardware used

The OWSERVER always needs a physical device acting as 1wire-Host to access the 1w-Devices connected to the bus (clients).

a) I personally use a **DS9490R USB to 1-Wire Adapter** to do so.
b) The essential Config-File `owfs.conf` is currently set up in the way to use a)

So the image/container is ready to be used with a DS9490R.

**IMPORTANT**: The used physical device can easily be changed modifying the `owfs.conf`. I found no 'good' documentation, so I created one.
See the file `owfs.conf.md` in the GitHub-Repository.

## Hints > OWFS & OWFTPD

When you investigate the `dockerfile` & `start.sh` you will see the Image/Container is generally capable to provide these 2 Programs.
But it is commented-out as I don't need it in my project.

## Build for...

It is only built for this architectures `linux/arm64` (e.g. Raspberry Pi 5) and for `linux/amd64`.

If you need the Image/Container for other platforms you can just build it on your machine with docker installed. See the GitHub-Repository the `dockerfile` and other files to do so. See link to GitHub above. 
>    ```
>    docker build -t owserver:latest .
>    ```

## Use the provided Image
Option 1: **Start with docker run**
```
docker run -d \
--restart unless-stopped \
--device /dev/bus/usb \
-p 4304:4304 \
-p 2120:2120 \
-p 2121:2121 \
--name=owserver twischi/owserver:latest
```
Option 2: **docker-compose.yml**
```
services:

# OWSERVER 
# * Enables reading values from 1wire device from 1wire bus
# * used DS9490R USB to 1-Wire Adapter as Device (=1wire host) to connect 1wire bus
 
  owserver:
    image: twischi/owserver:latest  # https://hub.docker.com/r/twischi/owserver
    container_name: owserver  
    restart: unless-stopped
    devices:
      - /dev/bus/usb  # Mount USB devices to allow access to the USB 1wire adapter
    ports:
      - "4304:4304"   # OWSERVER
      - "2121:2120"   # OWHTTPD > the Website with found devices
      - "2120:2121"   # OWFTPD > To access per FTP. NOT used yet = Can be deleted.
    healthcheck:
      test: ["CMD-SHELL", "bash -c 'echo >/dev/tcp/localhost/4304' 2>/dev/null || exit 1"]
      start_period: 20s  # Wait 20s before checking (1wire values need time to be ready)
      interval: 10s
      timeout: 5s
      retries: 3
```
Start with
```
docker compose up -d
```
What is `healthcheck:` for?
* It introduces a waiting time of 20s (with `start_period:`) before the container indicates that it is ready.
* Why?: This gives the OWSERVER time to grab the 1wire-device values before e.g. a Smarthome container starts up and fails only some seconds (temporarily) before valid values exist.
* Increase the waiting time if you have a lot of 1wire-sensors.

How to use?
* Make another container (that uses OWSERVER) to wait until it is healthy.
```
  <some other container eg. homeassistant>:
  ...
    depends_on:
      owserver:
        condition: service_healthy  # Wait to start the Container until OWSERVER indicates that it is healthy 
```

#### Explanation of the Ports
1. `4304` for the OWSERVER
2. `2120` for OWHTTPD  > the Website with found devices
3. `2121` for OWFTPD  > To access per FTP. **NOT used yet** = Can be deleted.

#### Explanation of Device 
`--device /dev/bus/usb` >  makes USB available in Container. 
This might be a different path, when running from a different host-system.

## Sources (official wiki):
1. https://github.com/owfs/owfs-doc/wiki

2. https://github.com/owfs/owfs-doc/wiki/owserver    

3. https://github.com/owfs/owfs-doc/wiki/owhttpd

4. https://github.com/owfs/owfs-doc/wiki/owftpd

5. https://github.com/owfs/owfs-doc/wiki/owfs
   Here you find info about the config-File. 