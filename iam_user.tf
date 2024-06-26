# adding users and groups
resource "aws_iam_user" "user01" {
    name = "user01"
}

resource "aws_iam_user" "user02" {
    name = "user02"
}

resource "aws_iam_group" "ec2-container-registry-power-user-group" {
    name = "ec2-container-registry-power-user-group"
}

# assign users to groups
resource "aws_iam_group_membership" "assignment" {
    name = "assignment"
    users = [
        aws_iam_user.user01.name,
        aws_iam_user.user02.name,
    ]
    group = aws_iam_group.ec2-container-registry-power-user-group.name
}

#attach policy to the group
resource "aws_iam_policy_attachment" "attachment" {
    name = "attachment"
    groups = [aws_iam_group.ec2-container-registry-power-user-group.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}