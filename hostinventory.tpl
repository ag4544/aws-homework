
---
all:
  hosts:
  vars:
    ansible_user: debian
    ansible_ssh_private_key_file: ~/.ssh/ansible_tasks
    ansible_python_interpreter: /usr/bin/python3
    ansible_become: yes
  children:
    builder:
      hosts:
        ${server_public_ip_builder}:
    webserver:
     hosts:
        ${server_public_ip_webserver}: