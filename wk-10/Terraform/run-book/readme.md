## Runbook

### Runbook Goals
- Investigate the Issue from the Drunk Engineer

### Prerequistes
- Run the script provided in the homework

### Runbook Steps - Cloud infrasture
Custom VPC 
1 subnet for iowa
3 firewall rules = deny all (filter=homework-vm), allow ssh, allow http.
VM instance = stop status, e2-machine type, firewalls flags off, tags (ssh-access)


### Runbook Steps - 
- give the VM a external IP address.
- restarted the instance.
- update the firewall rules: change the priority of the 'deny all' firewall rule higher then the other ones . Allow-http to 100 and Allow-ssh to 200. (http rule " target tab ; all instances in the network" VMs need "http-server" tag to have specific instances) 
- add the tag (http-server) to the 
- change the ip range from the firewall rule "allow-ssh" to open. SSH to the VM. and use the "curl local host" command.
- go to routes, route management and create a route, select VPC and make the ip range anywhere.

got to turn on the http traffic firewall.
deny all ( edit the firewall rules) higher priolity but it needs to be lowered. no public ip address. change the 
- 