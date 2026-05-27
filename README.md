# OWSERVER to read 1wire values

## What it is for?

Create a Docker-Image then use to run a Docker-Container.

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

So the Image/Container is ready to be used with an DS9490R.

**IMPORTANT**: The used physical device can easily be changed modifying the `owfs.conf`. I found no 'good' documentation, so I created one.
See the file `owfs.conf.md` in the GitHub-Repository.

## Hints > OWFS & OWFTPD

When you investigate the `dockerfile` & `start.sh` you will see the Image/Container is generally capable to provide these 2 Programs.
But is commented-out as I don't need it and use it in my project.

## Build for...

It is only build for Raspberry PI 5 >> `linux/arm64`.

If you need the Image/Container for other platforms you can just build it on your machine with docker installed. See the GitHub-Repository the `dockerfile` and other files to do so. See link to GitHub above.

## Use the Image

```
docker run -d \
--restart unless-stopped \
--device /dev/bus/usb \
-p 4304:4304 \
-p 2120:2120 \
-p 2121:2121 \
--name=owserver twischi/owserver:latest
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