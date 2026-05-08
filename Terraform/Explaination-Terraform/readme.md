Terraform Google compute engine configuration 

This section explains the primary required and optional arguments use when when provisioning a Google compute engine virtual machine in terraform. The following configuration blocks define how the virtual machine is created and connected to the network with multiple compute resources. 

Configuring the boot disk image (requirement)

Terraform references Google Cloud images by using image families or specific image versions. 
The following is an example of a Terraform block containing a boot disk image:

boot_disk {
  initialize_params {
    image = "PROJECT/IMAGE_FAMILY"
  }
}

https://docs.cloud.google.com/compute/docs/images/os-details


Name ( Required)

A unique identifier for the VM instance in the GCP cloud. This must be unique within the zone and follow the Google Cloud naming conventions. If you change it, you will create a new resource in terraform.

Machine type (required)

The machine type specifies the type of compute profile that is connected to the VM. There are different types of machine types. But we will be using “ n2-standard-2” this machine type provisions 2 vCPUs and 8 GB of RAM. 

Network interface (required) 

The network interface defines the configuration of the network that you have your VM located. This is a requirement for the BM to be connected to the VPC Network. 

Labels (optional) 

A label is an argument that applies to metadata to the VM as key/value pairs.

labels = {
  environment = "dev"
  team        = "backend"
}

boot.disk.initialize.params size (optional) 

This is the size of the boot disk in gigabytes example 

Size= 100


Name vs ID vs self-link 

Name = a user-defined VM name that is unique within its zone

Id = Terraform managed identifier used for estate tracking 

Self Link = full rest API URL pointing to the resource. 

IP address outputs 

External IP address provided by the “access_config”. Only instances with external IPS. If the “access_config” doesn't exist, The VM will remain private only.

output "vm_external_ip" {
  value = google_compute_instance.chewbacca_vm.network_interface[0].access_config[0].nat_ip
}


Internal IP address: This is used for communication within the VPC. It is always present when the network interface is defined.

output "vm_internal_ip" {
  value = google_compute_instance.chewbacca_vm.network_interface[0].network_ip
}

https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#network_interface-1












