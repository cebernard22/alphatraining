
output "server1_ip" {
  value       = aws_instance.myapp-server1.public_ip
}



output "server2_ip" {
  value       = aws_instance.myapp-server2.public_ip
}
