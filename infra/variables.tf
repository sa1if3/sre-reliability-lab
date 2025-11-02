variable "region" {
  type    = string
  default = "us-east-2"
}

variable "project" {
  type    = string
  default = "sre-lab"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
}