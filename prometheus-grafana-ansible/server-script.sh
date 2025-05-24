#!/bin/bash

# Step 1: Change the hostname of the node
sudo hostnamectl set-hostname node01
# Step 2: Create user ansible with password ansible and give sudo permission
sudo useradd -m -s /bin/bash -c "ansible" ansible
sudo echo "ansible:ansible" | sudo chpasswd
sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
# Step 3: Create SSH keys for user ansible 
sudo -u ansible ssh-keygen -t rsa -N "" -f /home/ansible/.ssh/id_rsa
# Step 4: Edit sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
# Step 5: Restart sshd service
sudo systemctl restart sshd

