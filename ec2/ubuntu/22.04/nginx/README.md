# Ubuntu NGINX Servers Pre Setup Scripts
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
## Step 1: Verify Ubuntu Version
```
lsb_release -a
```
## Step 2: Install common packages

```
wget -O - https://raw.githubusercontent.com/kidsontheyard/aws-scripts/main/ec2/ubuntu/22.04/nginx/pre-setup.sh | bash
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
