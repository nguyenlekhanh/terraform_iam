data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["137112412989"]
    filter {
        name = "name"
        values = ["al2023-ami-2023.3.20240312.0-kernel-6.1-x86_64"]
    }
}

# resource "aws_key_pair" "my_aws_key" {
#     key_name = "my_aws_key"
#     public_key = file (var.PATH_TO_PUBLIC_KEY)
# }

resource "aws_instance" "myFirstInstance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    availability_zone = data.aws_availability_zones.available.names[0]
    key_name = var.keyname
    iam_instance_profile = aws_iam_instance_profile.s3-bucket-role-instance-profile.name
    tags = {
        Name = "custom_instance"
    }
}

output "public_ip" {
    value = aws_instance.myFirstInstance.public_ip
}
