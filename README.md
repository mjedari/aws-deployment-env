## Golang deployment environment by Terraform

### Guide

create a `secrets.tf` file like by copying `secrets.tf.example` and put your AWS `access_key` and `secret_key`:

```terraform
variable "secrets" {
  access_key = "your-access-key-from-aws"
  secret_key = "your-secret-key-from-aws"
}
```

