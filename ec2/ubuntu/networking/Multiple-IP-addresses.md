# Setup Multiple IP addresses on EC2 instance / ubuntu

## Step 1: Add a secondary Private IP address to the network interface from AWS console. 
Refer the link [1] for more details. 

1) Open the Amazon EC2 console 
2) In the navigation pane, choose Network Interfaces, and then select the network interface attached to the instance (you can see the name starting with eni-). 
3)Choose Actions, Manage IP Addresses. 
4)Under IPv4 Addresses, choose Assign new IP. 
5)Enter a specific IPv4 address that's within the subnet range for the instance, or leave the field blank to let Amazon select an IP address for you. 
6)Choose Yes, Update.

[1] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html#assignIP-existing  

## Step 2: Assign secondary public IP address

If you are looking for adding a secondary public IP address to the instance then, you need to create an Elastic IP address (EIP) and assign it to the newly assigned Private IP address. Below are the steps for the same. If you need only private IP address, please proceed with step 3. 
Refer link [2] for more details. 

1) Open the Amazon EC2 console 
2) In the navigation pane, choose Elastic IPs. 
3) Choose Actions, and then select Associate address. 
4) For Network interface, select the network interface, and then select the secondary IP address from the Private IP list. 
5) Choose Associate.

??[2] Multiple IP addresses - Associate an Elastic IP address with the secondary private IPv4 address - 
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html#StepThreeEIP  ?

## Step 3: Enable the secondary private IP address at the operating system level

The next step is to enable the secondary private IP address at the operating system level. You can either configure the additional Private IPs to be temporary or permanent. I have given an example of both below.

I have configured an additional IP address via the console "172.31.92.91", you will notice that the secondary IP 172.31.92.91 has not appeared on my ens5 when running the "ip a". This is the same behavior that you are experiencing on you end.

### Step 3.1: Checking if the additional ip is added automatically
========================================
```
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 12:6c:c9:15:e0:8f brd ff:ff:ff:ff:ff:ff
    inet 172.31.84.239/20 metric 100 brd 172.31.95.255 scope global dynamic ens5
       valid_lft 3230sec preferred_lft 3230sec
    inet6 fe80::106c:c9ff:fe15:e08f/64 scope link 
       valid_lft forever preferred_lft forever
```
========================================

I configured the secondary IP address temporarily using the below command:

====================================================
$ ip addr add 172.31.92.91 dev ens5 label ens5:1
?====================================================

More information can be found in the documentation below:

--> https://www.2daygeek.com/add-additional-ip-secondary-ip-ubuntu-debian/ 
?--> https://linuxhint.com/how-to-assign-multiple-ip-addresses-to-single-nic-in-ubuntu-20-04-lts/ 

You will now notice that the IP "inet 172.31.92.91/32 scope global ens5:1" is present.
====================================================
```
root@ip-172-31-84-239:/etc# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 12:6c:c9:15:e0:8f brd ff:ff:ff:ff:ff:ff
    inet 172.31.84.239/20 metric 100 brd 172.31.95.255 scope global dynamic ens5
       valid_lft 3357sec preferred_lft 3357sec
    inet 172.31.92.91/32 scope global ens5:1
       valid_lft forever preferred_lft forever
    inet6 fe80::106c:c9ff:fe15:e08f/64 scope link 
       valid_lft forever preferred_lft forever
```
====================================================

I used the ping command to ensure that there is connectivity happening on the secondary address.
====================================================
```
# ping 172.31.92.91 -c 4
PING 172.31.92.91 (172.31.92.91) 56(84) bytes of data.
64 bytes from 172.31.92.91: icmp_seq=1 ttl=64 time=0.025 ms
64 bytes from 172.31.92.91: icmp_seq=2 ttl=64 time=0.044 ms
64 bytes from 172.31.92.91: icmp_seq=3 ttl=64 time=0.087 ms
64 bytes from 172.31.92.91: icmp_seq=4 ttl=64 time=0.037 ms
```
====================================================

* The above solution is setting a temporary configuration for a secondary IP on the same interface. Please continue reading to confirm how this can be applied to persist after a reboot.

### Step 3.2: Configuring the additional IP's to be persistent after a reboot (netplan)

Below is an example of configuring the additional IP's to be persistent after a reboot.
==================================================================================================

?I found a document which assists with using multiple addresses on a single interface (This is an example and requires you to make adjustments)

--> https://netplan.io/examples/ 

The below steps requires some manual intervention from your end to ensure it suits your solution.

1) Created a new file /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg and added below entry as 'network: {config: disabled}'
```
$ sudo vi /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg 

$ sudo cat /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg network: {config: disabled}
```

2) I have then taken the backup of my existing network configuration file using below command: 

```
$ sudo cp -p /etc/netplan/50-cloud-init.yaml /home/ubuntu/
```

Below is the original network configuration file:

"The following example uses the Netplan configuration. Note that Netplan uses YAML format, meaning indentation is crucial."?
```
$ sudo cat /etc/netplan/50-cloud-init.yaml 
```
====================================================
```
# network: {config: disabled}
network:
    ethernets:
        ens5:
          dhcp4: true
          dhcp6: false
          match:
            macaddress: 12:xx;x;xx;xx;x
          set-name: ens5?
```
3) I then modified my network configuration file and added my secondary IP address 172.31.92.180  in it, currently my network configuration file looks like below:?
```
$ cat /etc/netplan/50-cloud-init.yaml
```
====================================================?
```
# network: {config: disabled}
network:
    ethernets:
        ens5:
          addresses: 
            - 172.31.92.180/20 (This is my secondary IP address )
            "- 172.x.x.x"(This can be a tertiary IP address)
          dhcp4: true
          dhcp6: false
          match:
            macaddress: 12:xx;x;xx;xx;x
          set-name: ens5
    version: 2
```
====================================================

4) I used the below command  to try to apply a new netplan config to running system, with automatic rollback
```
$ sudo netplan try?
```
5) I have then used below command to apply the changes to the network configuration: ?
```
$ sudo netplan --debug apply
```
6) Now when I check the IP address using 'sudo ip a s ens5' command, I was able to see both IP addresses (172.31.87.32 and 172.31.92.180) are assigned to my network interface ens5, see the below output

Secondary IP on the same interface
====================================================
```
$ ip a

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 12:cb:ca:15:04:f7 brd ff:ff:ff:ff:ff:ff
    altname enp0s5
    inet 172.31.92.180/20 brd 172.31.95.255 scope global ens5
       valid_lft forever preferred_lft forever
    inet 172.31.87.32/20 metric 100 brd 172.31.95.255 scope global secondary dynamic ens5
       valid_lft 3444sec preferred_lft 3444sec
    inet6 fe80::10cb:caff:fe15:4f7/64 scope link 
       valid_lft forever preferred_lft forever
```
====================================================

I have confirmed by using Ping, If either of these commands returns ICMP echo reply messages, network connectivity exists between the two devices. ?

"Syntax: ping -I source iP destination IP"

--> Primary Private IP address
```
$ ping -I 172.31.87.32 8.8.8.8 -c 4
```
??====================================================
```
PING 8.8.8.8 (8.8.8.8) from 172.31.87.32 : 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=108 time=0.852 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=108 time=0.926 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=108 time=0.921 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=108 time=0.905 ms
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3071ms
rtt min/avg/max/mdev = 0.852/0.901/0.926/0.029 ms
```
====================================================??

--> Secondary Private IP address:
```
$ ping -I  172.31.92.180 8.8.8.8 -c 4
```
====================================================
```
PING 8.8.8.8 (8.8.8.8) from 172.31.92.180 : 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=108 time=0.918 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=108 time=0.913 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=108 time=0.924 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=108 time=0.948 ms

--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3077ms
rtt min/avg/max/mdev = 0.913/0.925/0.948/0.013 ms
```
====================================================

7) I was able to login to the instance with the newly assigned Elastic IP address successfully as well.?


You can also try the above steps to add the secondary IP address. I would strongly recommend you to test the mentioned steps in a non production system before moving to the production server, Also consider taking backup your EC2 instance either by taking a snapshots[3] of the EBS volumes or creating an AMI[4] of your instance to avoid any unpredictable events.

[3] Snapshot - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-creating-snapshot.html  
[4] AMI - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs  ??

If you are looking to add a secondary Network interface and assign IP address to it, then please refer the link [5] which explains the steps for that in detail.

?[5] https://aws.amazon.com/premiumsupport/knowledge-center/ec2-ubuntu-secondary-network-interface/ 
