variable "rg" {
    type = string
    description = "set rg name"  
}

variable "location" {
  type = string
  default = "West Europe"
}


variable "appservice" {
  type = string
  default = "prdappsrvdemo"
}


variable "appservicewebapp" {
  type = string
  default = "prdappsrvdemowebapp"
}


variable "stoname" {
  type = string
  default = "stolukasdemo1"
}

variable "name2" {
  type = string
  default = "stolukasdemo1"
}