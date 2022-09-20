provider "aws" {
  profile = "capatres"
  region  = "us-east-2"
}
resource "aws_instance" "example" {
  ami           = "ami-0568773882d492fc8"
  instance_type = "t2.micro"
}
