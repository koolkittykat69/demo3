output "lb_ip" {
  value = aws_lb.test.dns_name
}
