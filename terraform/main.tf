terraform {
  required_providers {
    aws = {
      source  = ""hashicorp/aws""
      version = ""~> 5.0""
    }
  }
}

provider ""aws"" {
  region = var.aws_region
}

variable ""aws_region"" {
  default = ""us-east-1""
}

variable ""frontend_ami_id"" {}
variable ""backend_ami_id"" {}

resource ""aws_instance"" ""frontend"" {
  ami           = var.frontend_ami_id
  instance_type = ""t3.micro""
  tags = { Name = ""frontend"" }
}

resource ""aws_instance"" ""backend"" {
  ami           = var.backend_ami_id
  instance_type = ""t3.micro""
  tags = { Name = ""backend"" }
}
