# Setup iRedMail
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
based on [1]
## Preparations
###Set a fully qualified domain name (FQDN) hostname on your server

```bash
sudo apt update -y && sudo apt upgrade -y
```

>No matter your server is a testing machine or production server, it's strongly recommended to set a fully qualified domain name (FQDN) hostname.

Enter command hostname -f to view the current hostname:
```bash
$ hostname -f
mx.example.com
```

```Bash
sudo nano /etc/cloud/cloud.cfg
```

```bash

# This will cause the set+update hostname module to not operate (if true)
preserve_hostname: false
```
Change to: `preserve_hostname: true`

```bash
sudo hostnamectl set-hostname NEW-HOST-NAME
```
On Debian/Ubuntu Linux, hostname is set in two files: `/etc/hostname` and `/etc/hosts`.


* `/etc/hostname` short hostname, not FQDN.
```bash
sudo nano /etc/hostname
mx01
```

* `/etc/hosts`: static table lookup for hostnames. Warning: Please list the FQDN hostname as first item.

```bash
sudo nano /etc/hosts
127.0.0.1   mx01.example.com mx01 localhost localhost.localdomain

```
Verify the FQDN hostname. If it wasn't changed after updating above two files, please reboot server to make it work.
```bash
$ hostname -f
mx.example.com
```
### Enable default official Debian/Ubuntu apt repositories
* iRedMail needs official Debian/Ubuntu apt repositories, please enable them in /etc/apt/sources.list.
* Install package gzip so that you can uncompress downloaded iRedMail package.

```bash
sudo apt install gzip -y
# If needed NFS support
sudo apt install nfs-common -y
# If neeeded whois
sudo apt install whois -y
```
### Install: Download the latest release of iRedMail
> Recommended to reboot to verify setting

#### on AWS - Verify Netplan for multi IPs
```bash
sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.bak
sudo nano /etc/netplan/50-cloud-init.yaml
```

#### Download the latest release of iRedMail
* Visit [Download page](https://www.iredmail.org/download.html) to get the latest stable release of iRedMail.
* Upload iRedMail to your mail server via ftp or scp or whatever method you can use, login to the server to install iRedMail. We assume you uploaded it to /root/iRedMail-x.y.z.tar.gz (replace x.y.z by the real version number).
* Uncompress iRedMail tarball:

```bash
sudo su
cd /root/
wget https://github.com/iredmail/iRedMail/archive/refs/tags/1.6.0.tar.gz
tar zxf iRedMail-x.y.z.tar.gz
```

### Start iRedMail installer
It's now ready to start iRedMail installer, it will ask you several simple questions, that's all required to setup a full-featured mail server.

```bash
cd /root/iRedMail-x.y.z/
bash iRedMail.sh
```

## Important things you MUST know after installation
> Warning:
>> The weakest part of a mail server is user's weak password. Spammers don't want to hack your server, they just want to send spam from your server. Please ALWAYS ALWAYS ALWAYS force users to use a strong password.

* Read file /root/iRedMail-x.y.z/iRedMail.tips first, it contains:
  * URLs, usernames and passwords of web-based applications
  * Location of mail service related software configuration files. You can also check this tutorial instead: [Locations of configuration](https://docs.iredmail.org/file.locations.html) and log files of major components.
  * Some other important and sensitive information

## Install SSL



## What Next:
* Setup DNS records for your mail server
* How to configure your mail clients
* Locations of configuration and log files of major components
* It's highly recommended to get a SSL cert to avoid annonying warning message in web browser or mail clients when accessing mailbox via HTTPS/IMAPS/POP3/SMTPS. Let's Encrypt offers FREE SSL certificate. We have a document for you to use a SSL certificate.
* If you need to bulk create mail users, check our document for OpenLDAP and MySQL/MariaDB/PostgreSQL.
* If you're running a busy mail server, we have some suggestions for better performance.

## Access webmail and other web applications
After installation successfully completed, you can access web-based programs if you choose to install them. Replace `example.com` below by your real server hostname or IP address.

* Roundcube webmail: https://example.com/mail/
* SOGo Groupware: https://example.com/SOGo
* Web admin panel (iRedAdmin): httpS://example.com/iredadmin/


Links:
[1]: https://docs.iredmail.org/install.iredmail.on.debian.ubuntu.html
[2]: https://www.linuxbabe.com/mail-server/set-up-iredmail-multiple-domains-nginx
[3]:


