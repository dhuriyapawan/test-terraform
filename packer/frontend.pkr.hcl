packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.2"
    }
  }
}

source "amazon-ebs" "frontend" {
  region        = "us-east-1"
  instance_type = "t3.micro"
  source_ami    = "ami-0c02fb55956c7d316"
  ssh_username  = "ec2-user"
  ami_name      = "frontend-{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.frontend"]

  provisioner "shell" {
    inline = [
      "sudo mkdir -p /opt/app",
      "sudo yum update -y"
    ]
  }

  provisioner "file" {
    source      = "../frontend/app/"
    destination = "/opt/app/"
  }

  provisioner "shell" {
    inline = [
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo cp -r /opt/app/* /usr/share/nginx/html/",
      "sudo chown -R nginx:nginx /usr/share/nginx/html"
    ]
  }
}
