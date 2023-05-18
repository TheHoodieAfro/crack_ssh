FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:dockerpassword' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i 's/22/12345/' /etc/ssh/sshd_config
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
RUN touch /root/.ssh/authorized_keys
RUN echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0LCwyNjgcRE6YlvyM0T1j0G7qEFIvj6VLoBR0BrEhbXhyPCeUf47R7hRfnWwUjzhkllR6aV+72xerWVUZfPI7sbTTOU0JbjBkumwAJKwGSy/D8c6OYETRdRabRqo1eabofq8onRGmUUPXDPjr9heCdTlH80AKLHDSBPu3QbVuwprfKEQEyWjc9AU8MjRW9G1iXkH3gX7qgYfanm40ILGYtvcuy+F0Q4GXX+nIs4D0RLnGN2KPG6huq4hxBb5CdIvKFO8vIuy1BzhBkStNpctSQ5Ab5Fjnpc0vUyl/wlRrB4mG9BIV8rFjhuek0VLTvPs22S3xq4tY7EQkNwMwa7h2LKapIntjDeQegMKI33m43HDbK2KSMmG5rQu4ug/aZAlfJA3kximuP7TEHsP8quTFsEUkGWgKtBzBcCMfcSxc+KhxqCYuqT8uBJv1X7JDK1pTfAwMZ8HtB7bMvEYO9fK0isOpvZn2+SF8L4SCoUGpzSO+eJ7zBaJ3cArXmiH+A9k= kali@kali > /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
EXPOSE 12345
CMD ["/usr/sbin/sshd", "-D"]
