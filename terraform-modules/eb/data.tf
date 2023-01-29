data "aws_elastic_beanstalk_solution_stack" "php" {
  most_recent = true

  name_regex = "^64bit Amazon Linux 2 (.*) PHP 8(.*)$"
}