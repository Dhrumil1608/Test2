data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.app.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  associate_public_ip_address = true

  monitoring = true

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    aws_region        = var.aws_region
    app_server_js_b64 = base64encode(file("${path.module}/../app/server.js"))
    app_package_b64   = base64encode(file("${path.module}/../app/package.json"))
    agent_config_b64  = base64encode(file("${path.module}/cloudwatch-agent-config.json"))
  })

  user_data_replace_on_change = true

  depends_on = [
    aws_iam_role_policy_attachment.cloudwatch,
    aws_iam_role_policy_attachment.ssm,
    aws_cloudwatch_log_group.app
  ]

  tags = {
    Name = "${var.project_name}-ec2"
  }
}