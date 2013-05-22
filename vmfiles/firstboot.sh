mkdir /home/brain/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZ/+YqY+AhDiH25+DaXS7pb0lh16j9Ws/9gRMCn48Q44U+dBDAUfkRJNE7IJ1+3I47eFyCocI5OrQieNEj8LfhPhMUDTFn1R0mDffmZvp2K4EQ23ZMIHQnzDk2wOiyUSgFfxhPFXsjaby9Fq110XMIP1uuTCc5LRMkhVolAXfWWrtIxx3OqBbYtLEy1KWVdjWuDQ7jtwwBD+e7ufJkO67SznYu/daPa0cj9bUn2MIIxgXLUnl3/+1gLQoTxS9siK1/L2MDcl0A9mkbyVhM1zzbsYzojVN/I+Uz7TIzRkA4+TbOriDQmN1vJznkeDASo/JxnUwvsjRvsolCxkl5+t6l brain@d-s3" >> /home/brain/.ssh/authorized_keys

chmod -R 700 /home/brain/.ssh
chown -R brain:brain /home/brain/.ssh

echo "%admin         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers