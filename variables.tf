variable "region" {
  default = "us-east-2"
}
variable "entity" {
  default = "aquinas"
}
variable "environment" {
  default = "prod"
}
variable "vpc_cidr" {
  description = "VPC cidr block"
}
variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 cidr block"
}
variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 cidr block"
}
variable "private_subnet_1_cidr" {
  description = "Private Subnet 1 cidr block"
}
variable "private_subnet_2_cidr" {
  description = "Private Subnet 2 cidr block"
}
variable "keycloak_master_instance_type" {
  #default = "t3.medium"
  default = "t2.xlarge" #4vpcu 16gb ram .01856/hr .110 1yrreserved compare to t2.large 2vpcu 8gb ram .0928/hr .055 1yrreserved
}
variable "keycloak_worker_instance_type" {
  default = "t2.xlarge"
  #default = "t2.xlarge" #4vpcu 16gb ram .01856/hr .110 1yrreserved
}

variable "instance_ami" {
  default = "ami-004b161a1cceb1ceb" #Rocky 8 asof 20230302 us-east-1
}

variable "static_fiber" {
  default = "73.0.0.0/8" #adams
}
variable "static_coax" {
  default = "50.0.0.0/8" #froth
}

variable "nat_gw_eip" {
  description = "cidr must match up"
}

# Required for front-end.tf
variable "site_certificate_arn" {
  description = "AWS GUI generated multi-tennant site certificate fqdn"
  default     = "arn:aws:acm:us-east-1:271192833499:certificate/10d54521-dbea-4fbe-8809-28b3e0d2ba8a" #aquinas.villasfoundation.com us-east-1
}
variable "site_zone_id" {
  description = "AWS auto created hosted ZONEID"
  default     = "Z0046415ZLSZB4PDIUHH" #villasfoundation.com hosted zone
}