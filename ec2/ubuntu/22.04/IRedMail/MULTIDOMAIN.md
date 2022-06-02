# How to Host Multiple Mail Domains in iRedMail with Nginx

Prerequisites:
* installed and tested iRedMail server with one domain.
* iRedMail 0.9.8 or above, which uses Nginx to serve webmail. 

Steps:
* Add a new mail domain and user in iRedMail admin panel.
* Create MX, A and SPF record for the new mail domain.
* Set up DKIM signing for additional domains
* Set up DMARC Record for the new domain.
* Set up RoundCube Webmail, Postfix and Dovecot for multiple domains
> Reverse DNS check is used to check if the sender’s IP address matches the HELO hostname. No need to add another PTR record when adding a new mail domain.

## Step 1: Adding Additional Domains in iRedMail Admin Panel
* Log into iRedMail admin panel with the ```postmaster``` account. ```(https://mail.your-domain.com/iredadmin)``` Then add domains in the Add tab.
* Next, add a user under the new domain.

##Step 2: Creating MX, A and SPF record for the new mail domain



