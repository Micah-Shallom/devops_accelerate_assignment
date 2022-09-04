provider "aws" {
    access_key = "xxx"
    secret_key = "xxx"
    region = "us-east-1"
}

resource "aws_instance" "app-vpc" {
    count = 20
    ami = "ami-08d4ac5b634553e16"
    instance_type = "t2.micro"
}