provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "myapp-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name: "vpc"
    }
}
  
resource "aws_subnet" "myapp-subnet" {
    vpc_id = aws_vpc.myapp-vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name: "subnet"
    }
}

resource "aws_route_table" "myapp-route-table" {
    vpc_id = aws_vpc.myapp-vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id
    }
    tags = {
        Name: "rtb"
    }
}

resource "aws_internet_gateway" "myapp-igw" {
    vpc_id = aws_vpc.myapp-vpc.id
    tags = {
        Name: "igw"
    }
}

resource "aws_route_table_association" "a-rtb-subnet" {
    subnet_id = aws_subnet.myapp-subnet.id
    route_table_id = aws_route_table.myapp-route-table.id 
}

resource "aws_security_group" "myapp-sg" {
    name="myapp-sg"
    vpc_id = aws_vpc.myapp-vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "sg"
    }
} 


# resource "aws_key_pair" "ssh-key" {
#     key_name = "server-key"
#     public_key = file(var.public_key_location)
# }


resource "aws_instance" "myapp-server" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = var.instance_type

    subnet_id = aws_subnet.myapp-subnet-1.id
    vpc_security_group_ids = [aws_security_group.myapp-sg.id]
    availability_zone = var.avail_zone

    associate_public_ip_address = true
    key_name = aws_key_pair.ssh-key.key_name

    user_data = file("command.sh")

    tags  = {
        Name = "server"
    }

}

# ====================================================
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "instance-"
  image_id      = data.aws_ami.ubuntu.id
  security_groups = [aws_security_group.myapp-sg.id]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                 = "terraform-asg-example"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 20
  max_size             = 20

  lifecycle {
    create_before_destroy = true
  }
}
