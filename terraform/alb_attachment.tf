resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.app.id
  port             = 5000
}