resource "aws_security_group" "web_sg" {
    name = "frontend-sg"
    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["var.admin_ip"]
}

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_security_group" "api_sg" {
  name = "backend-sg"
  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["aws_instace.FrontEnd.private_ip"]
}
ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["var.admin_ip"]
}
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_security_group" "db_sg" {
    name = "db-sg"
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["aws_security_group.api_sg._id"]
    }
  
}