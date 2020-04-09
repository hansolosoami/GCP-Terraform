variable "server_name" {
  type    = "string"
  default = "server"
}

variable "project" {
  type        = "string"
  description = "GCP project where resources will be created"
 #default     = "" //Add name of the GCP project here
}

variable "region" {
  type        = "string"
  description = "location for your resources to be created inside"
  default     = "asia-south1" // Name of the Region
}

variable "zones" {
  type        = "string"
  description = "Availability zone"
  default     = "asia-south1-a" // Name of availability zone
}

variable "image" {
  type        = "string"
  description = "Image to be used"
  default     = "debian-9-stretch-v20190618" // OS Image that will be used on the machine
} 

variable "instance_type" {
  type        = "string"
  description = "Machine type"
  default     = "n1-standard-8" // Instance\Machine Type used according to requirement and pricing
}

variable "ssh_key" {
  type        = "string"
  description = "SSH Public key path"
  default     = "ssh_keys" // Optional --- path to the ssh key file
}

