provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  zone    = "${var.zones}"
}

provider "google-beta" {
  project = "${var.project}"
  region  = "${var.region}"
  zone    = "${var.zones}"
}
