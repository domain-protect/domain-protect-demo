resource "aws_iam_instance_profile" "ssm" {
  name = local.name
  role = aws_iam_role.ssm.name
}

resource "aws_iam_role" "ssm" {
  name = local.name
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "ssm" {
  name        = local.name
  description = "Access to Session Manager"
  policy      = templatefile("${path.module}/ssm.json.tpl", {})
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = aws_iam_policy.ssm.arn
}

# Amazon Linux2 network interface
resource "aws_network_interface" "interface_linux" {
  subnet_id       = var.linux_subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = "${var.project}-linux-${local.env}"
  }
}

# Amazon Linux2 instance
resource "aws_instance" "linux" {
  ami                  = var.amazon_linux_ami
  instance_type        = var.instance_type_linux
  iam_instance_profile = aws_iam_instance_profile.ssm.id

  network_interface {
    network_interface_id = aws_network_interface.interface_linux.id
    device_index         = 0
  }

  # require IMDSv2
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  # install Apache
  user_data = file("${path.module}/user-data-apache")

  tags = {
    Name = "${var.project}-linux-${local.env}"
  }
}
