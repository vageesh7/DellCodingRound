data "vsphere_datacenter" "dc" {
  name = "dc1"
}

data "vsphere_datastore" "datastore" {
  name          = "dc1_datastore"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "cluster1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "ubuntu-16.04"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "public"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_folder" "folder" {
  path = "dc1/testvm/myguestvm1"
}

provider "vsphere" {
  user           = "admin"
  password       = "Iwiiap@13ns"
  vsphere_server = "10.241.110.12" 
  allow_unverified_ssl = true
}

resource "vsphere_virtual_disk" "myDisk" {
  size       = 120
  vmdk_path  = "myDisk.vmdk"
  datacenter = "dc1"
  datastore  = "dc1_datastore"
  type       = "thin"
}

resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 4
  memory   = 8192
  guest_id = "other3xLinux64Guest"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    size  = 20
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
	customize {
	  network_interface {
            ipv4_address = "10.241.110.12"
      }
	}
  }
}

provider "postgresql" {
  host     = "10.241.110.12"
  port     = 23456
  username = "user1"
  password = "Slkcpal@35"
}

resource "postgresql_database" "db1" {
  provider = "postgresql.pg1"
  name     = "test_db"
}
