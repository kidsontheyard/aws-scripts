# Ubuntu iRedMail Setup Scripts
```
      ██╗  ██╗██╗██████╗ ███████╗     ██████╗ ███╗   ██╗
      ██║ ██╔╝██║██╔══██╗██╔════╝    ██╔═══██╗████╗  ██║
      █████╔╝ ██║██║  ██║███████╗    ██║   ██║██╔██╗ ██║
      ██╔═██╗ ██║██║  ██║╚════██║    ██║   ██║██║╚██╗██║
      ██║  ██╗██║██████╔╝███████║    ╚██████╔╝██║ ╚████║
      ╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝     ╚═════╝ ╚═╝  ╚═══╝ Kids on the Yard
      ████████╗██╗  ██╗███████╗    ██╗   ██╗ █████╗ ██████╗ ██████╗
      ╚══██╔══╝██║  ██║██╔════╝    ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
         ██║   ███████║█████╗       ╚████╔╝ ███████║██████╔╝██║  ██║
         ██║   ██╔══██║██╔══╝        ╚██╔╝  ██╔══██║██╔══██╗██║  ██║
         ██║   ██║  ██║███████╗       ██║   ██║  ██║██║  ██║██████╔╝
         ╚═╝   ╚═╝  ╚═╝╚══════╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝
                                                
     Kids on the Yard offer 21st-Century Whole Child Tutoring Approach 
     In-Person & Online for Pre-K through College years plus Adults! 
                     For Their Future, For Their Growth
           “Because life happens on the yard and in the classroom™
                        https://kidsontheyard.com/
```
Beforore starting 
* A FRESH, working Debian/Ubuntu Linux. Supported releases are listed on [Download](https://www.iredmail.org/download.html) page.

## Step 1: Verify Ubuntu Version
```
lsb_release -a
```
### Step 1.1: Update System

```
sudo apt update -y && sudo apt upgrade -y && sudo reboot
```


### Step 1.2: Change host name:

```
sudo nano /etc/cloud/cloud.cfg
```
Change preserve_hostname to: `preserve_hostname: true`

```
sudo hostnamectl set-hostname NEW-HOST-NAME
```


## Set a fully qualified domain name (FQDN) hostname on your server

No matter your server is a testing machine or production server, it's strongly recommended to set a fully qualified domain name (FQDN) hostname.
Enter command hostname -f to view the current hostname:
```
$ hostname -f
mx.example.com
```
On Debian/Ubuntu Linux, hostname is set in two files: /etc/hostname and /etc/hosts.
/etc/hostname: short hostname, not FQDN.
mx
/etc/hosts: static table lookup for hostnames. Warning: Please list the FQDN hostname as first item.
### Part of file: /etc/hosts
127.0.0.1   mx.example.com mx localhost localhost.localdomain
Verify the FQDN hostname. If it wasn't changed after updating above two files, please reboot server to make it work.
```
$ hostname -f
mx.example.com
```
###Enable default official Debian/Ubuntu apt repositories

iRedMail needs official Debian/Ubuntu apt repositories, please enable them in /etc/apt/sources.list.
Install package gzip so that you can uncompress downloaded iRedMail package.

#### Install Packages 

```
sudo apt-get install gzip -y
```

NFS package if needed
```
sudo apt install nfs-common -y
```

whois package if need
```
sudo apt install whois -y
```

Mosh Server
Required to update ports after install
```
sudo apt install mosh -y
```


## Nice to have
### Bash prompt on Ubuntu - FULL FQDN insted short host name (\h)

Change ```~/.bashrc``` or ```/etc/profile``` based on need

Replace: 
```
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
```

With:

```
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@$(hostname -f)\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@$(hostname -f):\w\$ '
fi
```
We are using an explicit call to ```$(hostname -f)``` to get the FQDN of the system insted ```\H``` or ```\h```
