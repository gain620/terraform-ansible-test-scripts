variable "vsphere_user" {
	default = "administrator@vsphere.local"
}

variable "vsphere_password" {
	default = "VMware1!"
}

variable "vsphere_server" {
	default = "172.27.0.121"
}

variable "num_cpus" {
	default = "1"
}

variable "memory" {
	default = "1024"
}

variable "disk_size" {
	default = "16"
}

variable "guest_id" {
	default = "ubuntu64Guest"
}

variable "vm_name" {
	default = "terraform-test-VM"
}

variable "template_name" {
	default = "ubuntu16.04Origin"
}

variable "vm_hostname" {
	default = "johnDoe"
}

variable "vm_time_zone" {
	default = "America/Los_Angeles"	
}

variable "vm_domain" {
	default = "test.internal"
}

variable "vm_ip" {
	default = "172.27.0.151"
}

variable "vm_netmask" {
	default = "24"
}

variable "vm_gateway" {
	default = "172.27.0.1"
}

variable "dns_server_list" {
	type = "list"
	default = ["8.8.8.8", "8.8.8.4"]
}

variable "ssh_password" {
	default = "287548"
}