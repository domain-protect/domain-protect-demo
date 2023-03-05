# domain-protect-demo
Creates infrastructure used in demonstrations of Domain Protect

[![Global AppSec Dublin 2023](images/global-appsec-dublin.png)](https://youtu.be/fLrRLmKZTvE)

## infrastructure deployed
* S3 website with route53 CNAME record
* Hosted zone with route53 NS subdomain delegation
* EC2 instance hosting website with public IP and route53 A record
* Elastic Beanstalk OR S3 website with Cloudflare CNAME record

## demonstration
* demonstrate access to websites
* create similar new S3 CNAME using console
* manually destroy EC2 instance, Elastic Beanstalk Environment and hosted zone
* [Domain Protect](https://github.com/domain-protect/domain-protect) should detect vulnerabilities and send alerts

## requirements
* AWS Org with [Domain Protect](https://github.com/domain-protect/domain-protect) installed
* AWS Account with Route53 hosted zone, e.g. `example.com`
* AWS user with deployment permissions and keys
* Cloudflare account being scanned by [Domain Protect](https://github.com/domain-protect/domain-protect) installed
* Cloudflare DNS zone, e.g. `example.net`
* Cloudflare API key or API token for deployment

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
* by default the Cloudflare DNS entry will point to an Elastic Beanstalk application
* to deploy a S3 bucket instead of Elastic Beanstalk, in your `tfvars` file add:
```
cloudflare_demo = "s3"
```

## destroy
* destroy immediately after the demo to avoid excessive costs
```
terraform destroy (yes to confirm)
```

## image acknowledgements
Corcovado: [The Luxury Travel Expert](https://theluxurytravelexpert.com/2022/05/23/top-10-most-beautiful-national-parks-world)  
Fiordland: [The Luxury Travel Expert](https://theluxurytravelexpert.com/2022/05/23/top-10-most-beautiful-national-parks-world)  
Yosemite: [US National Parks](https://www.nps.gov/yose/index.htm)  