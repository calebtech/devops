variable "aws_region" {
  description = "AWS Resource Region"
  type = string
}

variable "assume_role_arn" {
  description = "AWS Assume Role ARN"
  type = string
}

variable "name" {
    description = "VPC name"
    type = string
}

variable "cidr" {
  description = "VPC CIDR block"
  type = string
}
variable "public_subnet" {
    description = "Public subnet CIDRs"
    type = list(string)
}

variable "azs" {
  description = "Availability zones"
  type = list(string)
}

variable "private_subnet" {
  description = "Private subnet CIDRs"
  type = list(string)
}

variable "enable_ng" {
  description = "Enable Nat Gateway"
  type = bool
  default = true
}

variable "tags" {
  description = "Common tags"
  type = map(string)
  default = {}
}