
# Infos for creating or edit of `owfs.conf` file.
**This file describes systematic & content of owfs.conf-file**

## Sources (offical wiki):
1. https://github.com/owfs/owfs-doc/wiki

2. https://github.com/owfs/owfs-doc/wiki/owserver    
```owserver [ -c config ] -d serialport | -u | -s [host:]port -p tcp-port```

3. https://github.com/owfs/owfs-doc/wiki/owhttpd
```owhttpd [ -c config ] -d serialport | -u | -s [host:]port -p tcp-port```

4. https://github.com/owfs/owfs-doc/wiki/owftpd
```owftpd [ -c config ] -d serialport | -u | -s [host:]port [ -p host:tcp-port ]```

5. https://github.com/owfs/owfs-doc/wiki/owfs
    ```!!! >> CONFIG-FILE !!!``` 

## Comments in `owfs.conf`
    # Any # marks the start of a comment
    # blank lines are ignored

## Limits `owfs.conf`
    # maximum line length of 250 characters
    # no limit on number of lines

## Setting Options/Values in `owfs.conf`
    option          # >> some options (like 'foreground') take no values
    option = value  # >> other options need a value
    option value    # >> '=' can be omitted if whitespace separates
    Option          # >> Case is ignored (for options, not values)
    opt             # >> non-ambiguous abbreviation allowed
    -opt --opt      # >> hyphens ignored

## Settings 'only for' or 'excluding' 

### owserver: 
    server: opt = value    # only owserver effected by this line
    ! server: opt = value  # owserver NOT effected by this line
### owhttpd:
    http: opt = value # only owhttpd effected by this line
    ! http: opt = value # owhttpd NOT effected by this line
### owftpd:
    ftp: opt = value # only owftpd effected by this line
    ! ftp: opt = value # owftpd NOT effected by this line
## owfs:
    owfs: opt = value # only owfs effected by this line
    ! owfs: opt = value # owfs NOT effected by this line

# Device Help (cmd-line) `owserver --help=device`
(there are **more**, it is shorted!)
### USB
    -u    --USB     DS9490R or PuceBaboon bus master
    -uall --USB=all Find and use all DS9490-type bus masters
    -u3:4 --USB=3:4 Specific USB location (bus 3, device 4)
    -uscan --USB=scan[:n] Keep looking for new USB adapters (every n seconds; default 10)
    -d /dev/ttyUSB0 ECLO USB bus master

###  1-wire device selection
    --one-device     Only single device on bus, use ROM SKIP command

## Network (address is form [ip:]port, ip DNS name or n.n.n.n, port is port number)
    --server address      owserver
    --etherweather=address EtherWeather

# Program `owserver --help=program`
Program-Specific Help (owfs, owhttpd, owserver, owftpd)

## owfs (FUSE-based filesystem)
    -m --mountpoint path  Where to mount virtual 1-wire file system
    --fuse_open_opt args  Special arguments to pass to FUSE (Quoted and escaped)
    --allow_other         Allow other users to see owfs file system needs /etc/fuse.conf setting
## owhttpd (web server)
    -p --port [ip:]port   TCP address and port number for access
    --zero                Announce service via zeroconf
    --announce name       Name for service given in zeroconf broadcast
    --nozero              Don't announce service via zeroconf
## owserver (OWFS server)
    -p --port [ip:]port   TCP address and port number for access

## owftpd (ftp server)
    -p --port [ip:]port   TCP address and port number for access has default port 22 (root only)
    --zero                Announce service via zeroconf
    --announce name       Name for service given in zeroconf broadcast
    --nozero              Don't announce service via zeroconf

# Job Control & Information Help `owserver --help=job`

## Information
    --error_level n  Choose verbosity of error/debugging reports 0=low 9=high
    --error_print n  Where debug info is placed 0-mixed 1-syslog 2-console
    --debug          Shortcut for --error_level=9 --foreground
    --detail=10.1231234566,12 Detail debugging for particular slaves
    --traffic --notraffic show/no_show bus traffic
    --locks --nolocks show/no_show mutex locking
## Control
    --foreground
    --background
    --pid_file name  file to store pid number (for control scripts)

## Configuration

## Permission
    -r --readonly     Don't allow writing to 1-wire devices
    -w --write        Allow writing to 1-wire
    --safemode        Even more restrictive: readonly, no uncached, ...

## Temperature and Display Help `owserver --help=temperature`

    Temperature scale
    -C --Celsius        Celsius(default) temperature scale
    -F --Fahrenheit     Fahrenheit temperature scale
    -K --Kelvin         Kelvin temperature scale
    -R --Rankine        Rankine temperature scale

    Pressure scale
    --atm --mbar --inHg --mmHg --Pa --psi (mbar is the default)

    --trim              remove extra spaces from numerical values
