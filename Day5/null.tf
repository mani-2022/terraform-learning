resource "null_resource" "text" {
  count      = var.environment == "Prod" ? 3 : 1
  depends_on = [aws_instance.Demo_Public_Instance, aws_instance.Demo_Private_Instance]
  provisioner "file" {
    source      = "userdata.sh"
    destination = "/tmp/userdata.sh"

  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/Sample-keys.pem")
    host        = aws_instance.Demo_Public_Instance[count.index].public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/userdata.sh",
      "sudo /tmp/userdata.sh",
      "sudo apt install jq unzip -y",
      "sudo apt-get update",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/Sample-keys.pem")
      host        = aws_instance.Demo_Public_Instance[count.index].public_ip
    }
  }
  provisioner "local-exec" {
    command = "echo 'Resource created with ID: ${aws_instance.Demo_Public_Instance[count.index].id}' > local_output.txt"
  }
  provisioner "local-exec" {
    command = "echo 'public Instance Ip: ${aws_instance.Demo_Public_Instance[count.index].public_ip}' > local_output.txt"

  }
}
