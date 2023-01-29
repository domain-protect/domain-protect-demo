resource "aws_iam_instance_profile" "eb" {
  name = local.name
  role = aws_iam_role.eb.name
}

resource "aws_iam_role" "eb" {
  name = local.name
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "elasticbeanstalk.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "eb" {
  name        = local.name
  description = "Access to S3"
  policy      = templatefile("${path.module}/eb.json.tpl", { content_bucket = var.content_bucket_name })
}

resource "aws_iam_role_policy_attachment" "eb" {
  role       = aws_iam_role.eb.name
  policy_arn = aws_iam_policy.eb.arn
}
