## Terraform DNS

### Configuring Bind9 DNS for RNDC

Grab your DNS server's HMAC key:

	cat /etc/bind/rndc.key     <--- use this HMAC key

Make your baind.zones folder writable:

	chown -R root:bind ./zones
	chmod -R u=rwx,g=rwx+s,o=rx ./zones
	systemctl restart bind9
	

also tweak apparmor settings: (allow writes to zones folder)

edit: /etc/apparmor.d/local/usr.sbin.named 

	/etc/bind/zones/** rw,
	
	systemctl restart apparmor
	
Edit your /etc/bind/named.conf.local file for RNDC access:

	aaron@ns1:/etc/bind$ cat named.conf.local 
	//
	// Do any local configuration here
	//
	
	// Consider adding the 1918 zones here, if they are not used in your
	// organization
	//include "/etc/bind/zones.rfc1918";
	key "rndc-key" {
		algorithm hmac-md5;
		secret "TYPE YOUR HMAC KEY HERE";
	};
	
	zone "lan.aaroncody.com" {
		type master;
		file "/etc/bind/zones/db.lan.aaroncody.com"; # zone file path
		allow-update { key rndc-key; };
	};
	
	zone "168.192.in-addr.arpa" {
		type master;
		file "/etc/bind/zones/db.192.168";  # 192.168.0.0/16 subnet
		allow-update { key rndc-key; };
	};
	
Restart DNS

	systemctl restart bind9
	
TIP: restoring permissions to fresh install

	chown -R root:bind ./zones
	chmod u=rwx,g=rx+s,o=rx zones

Fresh BIND9 Permissions:

	root@ns1:/home/aaron# cd /etc/bind
	
	root@ns1:/etc/bind# ls -al
	total 64
	drwxr-sr-x   3 root bind 4096 Sep 27 13:39 .
	drwxr-xr-x 102 root root 4096 Sep 27 12:16 ..
	-rw-r--r--   1 root root 3954 Jan 16  2018 bind.keys
	-rw-r--r--   1 root root  237 Jan 16  2018 db.0
	-rw-r--r--   1 root root  271 Jan 16  2018 db.127
	-rw-r--r--   1 root root  237 Jan 16  2018 db.255
	-rw-r--r--   1 root root  353 Jan 16  2018 db.empty
	-rw-r--r--   1 root root  270 Jan 16  2018 db.local
	-rw-r--r--   1 root root 3171 Jan 16  2018 db.root
	-rw-r--r--   1 root bind  463 Jan 16  2018 named.conf
	-rw-r--r--   1 root bind  490 Jan 16  2018 named.conf.default-zones
	-rw-r--r--   1 root bind  555 Sep 27 13:35 named.conf.local
	-rw-r--r--   1 root bind 1327 Sep 27 12:46 named.conf.options
	-rw-r-----   1 bind bind   77 May 20  2019 rndc.key
	drwxr-sr-x   2 root bind 4096 Sep 27 13:20 zones
	-rw-r--r--   1 root root 1317 Jan 16  2018 zones.rfc1918

	root@ns1:/etc/bind# ls -al zones
	total 16
	drwxr-sr-x 2 root bind 4096 Sep 27 13:20 .
	drwxr-sr-x 3 root bind 4096 Sep 27 13:39 ..
	-rw-r--r-- 1 root bind 1374 Sep 27 13:20 db.192.168
	-rw-r--r-- 1 root bind 1276 Sep 27 13:20 db.lan.aaroncody.com


Adding/Removing an A record:

	terraform apply -auto-approve
	terraform destroy -auto-approve
	
	systemctl restart bind9 (flushes jnl --> zone files)
	