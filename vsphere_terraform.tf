provider "vsphere" {
	user = "${var.vsphere_user}"
	password = "${var.vsphere_password}"
	vsphere_server = "${var.vsphere_server}"

	allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
	name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
	name = "datastore1"
	datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
	name = "Resources"
	datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
	name = "VM Network"
	datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
	name = "${var.template_name}"
	datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm2" {
	#count = 2
	#name = "${var.vm_name}-${count.index}"
	name = "${var.vm_name}23"

	resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
	datastore_id = "${data.vsphere_datastore.datastore.id}"

	num_cpus = "${var.num_cpus}"
	memory = "${var.memory}"
	guest_id = "${var.guest_id}"

	network_interface {
		network_id = "${data.vsphere_network.network.id}"
	}

	disk {
		label = "disk0"
		size = "${var.disk_size}"
		thin_provisioned = false
	}

	clone {
		template_uuid = "${data.vsphere_virtual_machine.template.id}"

		customize {
			linux_options {
				host_name = "${var.vm_hostname}"
				time_zone = "${var.vm_time_zone}"
				domain = "${var.vm_domain}"
			}

			network_interface {
			
				ipv4_address = "172.27.0.36"
			
			/*
			ipv4_address = "172.27.0.10${count.index}"
			*/
			
				ipv4_netmask = "${var.vm_netmask}"
			}
			dns_server_list = "${var.dns_server_list}"
			ipv4_gateway = "${var.vm_gateway}"
		}
	}
}

resource "vsphere_virtual_machine" "vm" {
	#count = 2
	#name = "${var.vm_name}-${count.index}"
	name = "${var.vm_name}-ansible"

	resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
	datastore_id = "${data.vsphere_datastore.datastore.id}"

	num_cpus = "${var.num_cpus}"
	memory = "${var.memory}"
	guest_id = "${var.guest_id}"

	network_interface {
		network_id = "${data.vsphere_network.network.id}"
	}

	disk {
		label = "disk0"
		size = "${var.disk_size}"
		thin_provisioned = false
	}

	connection {
		type = "ssh"
		user = "john"
		password = "${var.ssh_password}"
		host = "${var.vm_ip}"
		timeout = "1m"
	}

	provisioner "remote-exec" {
		inline = [
			"echo ${var.ssh_password} | sudo -S apt-get update",
			"sudo apt-get install -y python3",
			"sudo apt-get install -y nodejs",
			"sudo apt-get install -y npm",
			"sudo apt-get install -y nginx"
		]
	}

	clone {
		template_uuid = "${data.vsphere_virtual_machine.template.id}"

		customize {
			linux_options {
				host_name = "${var.vm_hostname}"
				time_zone = "${var.vm_time_zone}"
				domain = "${var.vm_domain}"
			}

			network_interface {
			
				ipv4_address = "${var.vm_ip}"
			
			/*
			ipv4_address = "172.27.0.10${count.index}"
			*/
			
				ipv4_netmask = "${var.vm_netmask}"
			}
			dns_server_list = "${var.dns_server_list}"
			ipv4_gateway = "${var.vm_gateway}"
		}
	}
}
