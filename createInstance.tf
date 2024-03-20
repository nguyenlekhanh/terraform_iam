data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }
}

# resource "aws_key_pair" "my_aws_key" {
#     key_name = "my_aws_key"
#     public_key = file (var.PATH_TO_PUBLIC_KEY)
# }

resource "aws_instance" "myFirstInstance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    availability_zone = data.aws_availability_zones.available.names[0] key_name = var.keyname
    tags = {
        Name = "custom_instance"
    }
}

output "public_ip" {
    value = aws_instance.myFirstInstance.public_ip
}
