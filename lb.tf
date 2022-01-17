resource "aws_lb" "test" {
  name                = "test"
  load_balancer_type  = "application"
  subnets             = [for subnet in aws_subnet.pub : subnet.id]
  ip_address_type     = "ipv4"
  security_groups     = [aws_security_group.demo.id]
}

resource "aws_lb_target_group" "test" {
  depends_on  = [aws_route_table_association.priv]
  name        = "test"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id

  health_check {
    healthy_threshold   = 3
    interval            = 30
    protocol            = "HTTP"
    matcher             = 200
    timeout             = 3
    path                = "/"
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.test.arn
  }
}
