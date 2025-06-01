variable "tag_name" {
  type    = string
  default = "DaLaw_"
}
variable "public_subnet_1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_region_1" {
  type    = string
  default = "us-east-2a"
}
variable "public_subnet_2" {
  type    = string
  default = "10.0.2.0/24"
}

variable "public_region_2" {
  type    = string
  default = "us-east-2b"
}

variable "private_subnet" {
  type    = string
  default = "10.0.10.0/24"
}

variable "private_region" {
  type    = string
  default = "us-east-2b"
}
variable "ami_id" {
  type    = string
  default = "ami-04f167a56786e4b09"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "server_count" {
  default = 4
}
