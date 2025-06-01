resource "aws_instance" "apache_instance" {
  count         = var.server_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(concat([aws_subnet.public_subnet_1.id], [aws_subnet.public_subnet_2.id]), count.index % 2)

  security_groups      = [aws_security_group.allow_http.id]
  user_data            = file("userdata.tpl")
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  associate_public_ip_address = true
  tags = {
    Name = "${var.tag_name}apache-server-${count.index}"
  }
}

# Registers the Instances to the Target Group

resource "aws_lb_target_group_attachment" "tg_attachment" {
  count            = var.server_count
  target_group_arn = aws_lb_target_group.apache_tg.arn
  target_id        = aws_instance.apache_instance[count.index].id
  port             = 80
}
