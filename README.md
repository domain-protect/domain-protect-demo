# domain-protect-demo
Creates infrastructure to be used in demonstrations of Domain Protect

## deployment
* duplicate `backend.tf.example` and `terraform.tfvars.example`
* rename without the `example` suffix
* enter details for your environment
* the base_domain must correspond to a Route53 hosted zone in your AWS account
```
terraform init
terraform workspace new demo
terraform plan
terraform apply
```

## image acknowledgements
Corcovado: [The Luxury Travel Expert](https://theluxurytravelexpert.com/2022/05/23/top-10-most-beautiful-national-parks-world)
Fiordland: [The Luxury Travel Expert](https://theluxurytravelexpert.com/2022/05/23/top-10-most-beautiful-national-parks-world)
Yosemite: [US National Parks](https://www.nps.gov/yose/index.htm)