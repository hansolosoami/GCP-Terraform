
// Accessing static IP created on GCP

data "google_compute_address" "server" {
  name = "test-ip" #Name of Public IP address created.
}

resource "google_compute_instance" "rserver" {
  name                      = "${var.server_name}"
  project                   = "${var.project}"
  machine_type              = "${var.instance_type}"
  zone                      = "${var.zones}"
  allow_stopping_for_update = false
  can_ip_forward            = false

  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
  }

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  // Use an existing disk resource
  #attached_disk {
   # source      = "${data.google_compute_disk.server.name}"
    #auto_delete = false
    #boot        = false
  #}

  # disk {
  #  disk = "${data.google_compute_disk.server.name}"
  # }

  network_interface {
    network = "default"
    access_config {
      nat_ip = "${data.google_compute_address.server.address}" // Static IP Address
    }
  }

  metadata = {
    enable-oslogin = "FALSE"
    sshKeys        = "${file("${var.ssh_key}")}" //Passing Multiple SSH keys in a file --- Optional 
  }
 
  provisioner "file" {
    source      = "ssh_script.sh"
    destination = "./ssh_script.sh"                                                                                                         
   }

  provisioner "remote-exec" {
    inline = [ 
      "sudo apt-get update -y",
    ]
   }

  connection {
    user = "ubuntu"
    host = "${data.google_compute_address.server.address}"
    private_key = "${file("${var.main_key_private}")}"
   } 
  tags = ["nat"]
}
