# Terraform Google Compute Engine VM Configuration

This section outlines the primary required and optional arguments used when provisioning a Google Compute Engine VM with Terraform using the `google_compute_instance` resource.

---

# Required Arguments

## `boot_disk`

Defines the VM’s root disk and operating system image.

This block is mandatory because the instance requires a bootable disk in order to start. Configuration for disk size, image, and disk type is defined within nested parameters.

---

## `machine_type`

Specifies the compute resources assigned to the VM.

Examples include:

* `e2-micro`
* `n2-standard-2`

The selected machine type determines:

* CPU allocation
* Memory allocation
* Pricing tier
* Performance characteristics

---

## `name`

Defines the VM instance name within the specified zone.

Requirements:

* Must be unique inside the zone
* Must follow GCP naming conventions

Changing the name after deployment causes Terraform to destroy and recreate the VM resource because the name is treated as an immutable infrastructure identifier.

---

## `network_interface`

Attaches the VM to a VPC network.

This block is required because every Compute Engine instance must connect to a network. It can include:

* VPC assignment
* Subnetwork configuration
* External IP configuration

Multiple network interfaces may be attached if needed.

---

# Optional Arguments

## `boot_disk.initialize_params.size`

Defines the boot disk size in gigabytes.

Example:

```hcl id="duq30m"
size = 100
```

If omitted, GCP automatically uses the default size associated with the selected OS image. Explicitly setting the size is recommended for predictable deployments and storage planning.

---

## `labels`

Applies metadata tags to the VM as key/value pairs.

Example:

```hcl id="sh29x9"
labels = {
  environment = "dev"
  application = "web"
}
```

Labels are commonly used for:

* Cost tracking
* Resource organization
* Filtering
* Automation workflows

Unlike network tags, labels are primarily administrative metadata.

---

# Name vs ID vs Self-Link

| Attribute   | Purpose                                                             |
| ----------- | ------------------------------------------------------------------- |
| `name`      | Human-readable VM name defined by the engineer                      |
| `id`        | Terraform-generated identifier used internally for state management |
| `self_link` | Full Google Cloud API URL pointing to the VM resource               |

---

## `name`

The logical instance name configured directly in Terraform.

Example:

```hcl id="nv1py9"
name = "web-server-01"
```

Used primarily by engineers and administrators when identifying resources.

---

## `id`

A computed value maintained by Terraform after resource creation.

Terraform uses this internally to track infrastructure state and map resources between configuration and deployed infrastructure.

---

## `self_link`

A fully qualified API path for the resource.

Example format:

```id="g02gfe"
https://www.googleapis.com/compute/v1/projects/PROJECT/zones/ZONE/instances/INSTANCE
```

This value is commonly used when one GCP resource references another through the API.

---

# Configuring the Boot Disk Image

Terraform references Google Cloud images using either:

* Image families
* Specific image versions

Typical format:

```hcl id="0s5q0v"
boot_disk {
  initialize_params {
    image = "projects/centos-cloud/global/images/family/centos-stream-10"
  }
}
```

Using image families is generally preferred because Terraform automatically resolves the latest supported image in that family.

---

# VM IP Address Outputs

## External IP Address

```hcl id="q67v0g"
output "vm_external_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
```

The external/public IP is assigned through the `access_config` block.

Without an `access_config`, the VM receives only an internal/private IP address.

---

## Internal IP Address

```hcl id="gawpnl"
output "vm_internal_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].network_ip
}
```

The internal IP is automatically allocated from the attached subnet and is used for communication inside the VPC.

---

# Notes on IP Assignment

* Internal IP addresses are automatically assigned when a network interface is attached
* External IP addresses require an `access_config` block
* Public connectivity depends on:

  * Firewall rules
  * VPC routing
  * External IP assignment
* VMs without external IPs can still communicate internally within the VPC network
