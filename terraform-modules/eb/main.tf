resource "aws_elastic_beanstalk_environment" "web" {
  name          = local.name
  description   = local.name
  cname_prefix  = var.cname_prefix
  application   = aws_elastic_beanstalk_application.web.name
  template_name = aws_elastic_beanstalk_configuration_template.web.name
  version_label = aws_elastic_beanstalk_application_version.web.name
  tags          = var.tags
}

resource "aws_elastic_beanstalk_application" "web" {
  name        = local.name
  description = local.name

  appversion_lifecycle {
    service_role          = aws_iam_role.eb.arn
    delete_source_from_s3 = true
  }

  tags = var.tags
}

resource "aws_elastic_beanstalk_application_version" "web" {
  name        = local.name
  application = local.name
  description = local.name
  bucket      = var.content_bucket_name
  key         = var.content_object_name
  tags        = var.tags
}

resource "aws_elastic_beanstalk_configuration_template" "web" {
  name                = local.name
  application         = aws_elastic_beanstalk_application.web.name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.php.name

  setting {
    name      = "MinSize"
    namespace = "aws:autoscaling:asg"
    value     = "1"
  }

  setting {
    name      = "MaxSize"
    namespace = "aws:autoscaling:asg"
    value     = "1"
  }

  setting {
    name      = "EnvironmentType"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "LoadBalanced"
  }

  setting {
    name      = "IamInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = aws_iam_instance_profile.eb.name
  }

  setting {
    name      = "SecurityGroups"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = var.security_group_id
  }

  setting {
    name      = "VPCId"
    namespace = "aws:ec2:vpc"
    value     = var.vpc_id
  }

  setting {
    name      = "Subnets"
    namespace = "aws:ec2:vpc"
    value     = var.public_subnet_id
  }

  setting {
    name      = "ELBSubnets"
    namespace = "aws:ec2:vpc"
    value     = var.public_subnet_id
  }
}
