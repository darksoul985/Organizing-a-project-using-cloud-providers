#cloud-config
users:
  - name: ${ssh_user}
    groups: sudo
    shel: /bin/sh
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh_authorized_keys:
      - ${ssh_public_key}
