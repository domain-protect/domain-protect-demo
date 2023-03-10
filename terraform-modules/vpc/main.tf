resource "aws_vpc" "vpc" {

  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = local.name
  }
}

resource "aws_subnet" "subnet_dmz_az1" {

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az1
  cidr_block              = var.subnet_dmz_cidr_az1
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-dmz-az1-${local.env}"
  }
}

resource "aws_subnet" "subnet_dmz_az2" {

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az2
  cidr_block              = var.subnet_dmz_cidr_az2
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-dmz-az2-${local.env}"
  }
}

resource "aws_internet_gateway" "gateway" {

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = local.name
  }
}

resource "aws_route_table" "rtb_dmz" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${var.project}-dmz-${local.env}"
  }
}

resource "aws_route_table_association" "rtb_dmz_to_dmz_az1" {

  route_table_id = aws_route_table.rtb_dmz.id
  subnet_id      = aws_subnet.subnet_dmz_az1.id
}

resource "aws_route_table_association" "rtb_dmz_to_dmz_az2" {

  route_table_id = aws_route_table.rtb_dmz.id
  subnet_id      = aws_subnet.subnet_dmz_az2.id
}

resource "aws_flow_log" "vpc" {
  log_destination = aws_cloudwatch_log_group.vpc-flowlog-group.arn
  iam_role_arn    = aws_iam_role.flowlog-role.arn
  vpc_id          = aws_vpc.vpc.id
  traffic_type    = "ALL"
}

resource "aws_cloudwatch_log_group" "vpc-flowlog-group" {
  name              = "/${local.name}/${aws_vpc.vpc.id}/flowlog"
  retention_in_days = var.flow_log_retention_in_days
}

resource "aws_iam_role" "flowlog-role" {
  name = "${var.project}-flowlog-role-${local.env}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "flowlogs-policy" {
  name = "training-${local.env}-flowlogs-policy"
  role = aws_iam_role.flowlog-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_default_security_group" "default" {

  vpc_id = aws_vpc.vpc.id

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-dmz-${local.env}"
  }
}

resource "aws_security_group" "web_ingress" {
  name        = "${local.name}-web-ingress"
  description = "Allow inbound web traffic"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-web-ingress-${local.env}"
  }
}
