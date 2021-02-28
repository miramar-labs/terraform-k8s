## Terraform HA Kubernetes

This project shows how I deploy HA Kubernetes onto my home-built VMWare ESXi lab, using a combination of Terraform and Ansible:

![Home Lab](./homelab.jpg)

- System hardware & build info
		
	Custom: ['The GPU Rig'](https://pcpartpicker.com/user/aaroncody/builds/#view=YbNNnQ)
	
	Custom: ['The Cheap ESXi Server'](https://pcpartpicker.com/user/aaroncody/builds/#view=V7dXsY)
	
	Apple Mac Pro: 'The not so Cheap ESXi Server'
	
- Water-Cooling 

	For extra nerd points I decided to water-cool the GPUs - why not! In practice though, you can see major performance 
	improvements during lengthy training cycles..
	After that I decided water cooling was the way to go and even water-cooled the CPU's in my cheap ESXi server.
	With all this hardware in my little office, consuming as much electricity as my hot tub, temps get high, especially 
	during the summer, so I think this was a wise decision.
	
- Running VMWare ESXi

	I use the 'Essentials' pack which allows vCenter to work with up to 3 hypervisors for only $500 ! I don't have any more room
	for servers in here so that worked out to be perfect.
	
- Using GPUs from Virtual Machines

	Here I plan to talk about the joys of PCI pass-through :)
	
- Kubernetes

	On top of ESXi I'm running high availability Kubernetes (a master node on each hypervisor)
	I use Ansible to roll out the entire cluster from scratch, provisioning the VMs, installing the software 
	and configuring it - so I can tear *everything* down and bring it all back up in a completely automated fashion. This is
	especially great when rogue experiments put the system into a weird state - I can just reset the whole system, come back 
	in a few hours and it's all brand new again. Also this makes trying out new versions of Kubernetes much easier.

- Storage

	I use a 12TB NAS server	as well as various SSD cards on the hypervisors for faster local storage. In K8s I implement a 
	high-availability NFS server (Pacemaker/Corosync) using two VM's (master/slave) to expose various NFS mount points and 
	kubernetes PV's. 
	Also Heketi/Gluster DFS.
	
- Networking

	Everything hangs off a Netgear ProSafe smart switch (which supports VLANs).
	For wifi I use an ASUS ROG wifi router, which I'm pretty sure is frying my brain it's so powerful
	Gigabit Ethernet coming in thanks to ATT Fiber (plus a tricky setup to make that work with my ASUS router)
	
- APC 

	Two APC units (we get frequent power outages here) which are tied into vCenter to gracefully shut down my VMs before
	lights out.
