source ""amazon-ebs"" ""backend"" {
  region        = ""us-east-1""
  instance_type = ""t3.micro""
  source_ami    = ""ami-0c02fb55956c7d316""
  ssh_username  = ""ec2-user""
  ami_name      = ""backend-{{timestamp}}""
}

build {
  sources = [""source.amazon-ebs.backend""]
  provisioner ""file"" {
    source      = ""../backend/app""
    destination = ""/opt/app""
  }
  provisioner ""shell"" {
    inline = [
      ""sudo yum install -y python3"",
      ""python3 -m pip install --upgrade pip"",
      ""pip3 install flask flask-cors"",
      ""nohup python3 /opt/app/app.py &""
    ]
  }
}
