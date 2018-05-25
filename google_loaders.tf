
variable "CLUSTER_NAME"{
}
variable "NUM_LOADERS"{
}
variable "IMAGE"{
}
variable "ZONE"{
  default = "us-central1-a"
}
variable "PROJECT"{
  default = "elastifile-sa"
}

provider "google" {
//  credentials = "${file("andrew-sa-elastifile-sa.json")}"
  project     = "${var.PROJECT}"
  region      = "${var.ZONE}"
}

resource "google_compute_instance" "erun" {
  count         = "${var.NUM_LOADERS}"
  name         = "${var.CLUSTER_NAME}-${count.index}"
  machine_type = "n1-standard-4"
  zone         = "${var.ZONE}"

//  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7-v20171129"
      type = "pd-ssd"
    }
  }

//    Local SSD disk
//  scratch_disk {
//  }

  network_interface {
    subnetwork = "default"

    access_config {
      // Ephemeral IP
    }
  }

   scheduling {
     preemptible = true
     automatic_restart = false
   }

  metadata {
    reference_name = "${var.CLUSTER_NAME}"
    num_loaders = "${var.NUM_LOADERS}"
    zone = "${var.ZONE}"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["cloud-platform"]
  }

  provisioner "file" {
      source = "erun.sh"
      destination = "erun.sh"
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
  }

  provisioner "file" {
      source = "DNS.txt"
      destination = "DNS.txt"
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
  }

  provisioner "file" {
      source = "configure.sh"
      destination = "configure.sh"
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
  }

  provisioner "file" {
      source = "configure_dns.sh"
      destination = "configure_dns.sh"
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
  }

  provisioner "remote-exec" {
      inline = [
        "chmod a+x configure*.sh" , "./configure.sh" , "./configure_dns.sh" , "chmod a+x erun.sh"
      ]
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
    }


}
