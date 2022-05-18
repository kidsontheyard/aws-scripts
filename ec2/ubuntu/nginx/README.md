# Ubuntu Web Pre Setup Scripts

```
wget -O - https://raw.githubusercontent.com/kidsontheyard/aws-scripts/main/ec2/ubuntu/nginx/pre-setup.sh | bash
```

## After Pre Setup:
* Connect AWS EFS (elastic file system)
* Add scripts path
* Update host name
* Update /etc/update-motd.d/01-custom

### Adding scripts path:

```
/efs/setup/scripts/adding-scripts-path.sh
```

### Change host name:

```
sudo nano /etc/cloud/cloud.cfg
```
Change preserve_hostname to: `preserve_hostname: true`

```
sudo hostnamectl set-hostname NEW-HOST-NAME
```

 
## Setup Nginx with PHP 8.1x
