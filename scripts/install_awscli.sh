#!/usr/bin/env bash

# -------------------------------------Pre-requiste -----------------------------------------------
# Change back to ubuntu user
# Install manually

# -------------------------------------Install aws-cli----------------------------------------------

# First check python / python3 and pip3 version 
# python --version
# python3 --version 
# pip3 --version 
# If not installed, to install it. 

sudo apt -y install python3-pip
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
# export PATH=~/.local/bin:$PATH
# source ~/.bashrc
# Now install aws-cli
pip3 install awscli --upgrade --user
##If you face any issues, you have to force a reinstall of pip [https://askubuntu.com/questions/1025189/pip-is-not-working-importerror-no-module-named-pip-internal]
# check pip3 version
# pip3 --version

# Move to local bin to get accessed through jenkins user
sudo cp -r ~/.local/bin/* /usr/local/bin/
sudo su jenkins
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
pip3 install awscli --upgrade --user

# Install pylint and flask
pip3 install pylint --user
pip3 install flask --user

# Check aws version from jenkins user
# sudo su jenkins 
# aws --version

# Update aws credentials - IAM user programmetic acces - Amazon-admin access) 
# aws configure


# ---------------------------------Update kube-config file------------------------------------------------------------------
# Update kubernetes cluster configuration
# aws eks update-kubeconfig --name zetacluster


# ---------------------------------Update Worker Nodes Configuration---------------------------
# Before running this command, update aws-auth-cm.yml file. File is in cfn folder of the project. 
# After you copy role from AWS cloudformation stack output, update rolearn in line 8. 
# Update ConfigMap credentials(role) for kubernetes worker nodes by running this command:
# kubectl apply -f cfn/aws-auth-cm.yml 


# ----------------------------------------Commands to Remember (Optional)---------------------------------------------------
#  # Pull image from docker hub
#  kubectl run capstone-clouddevops --image=prhomhyse/devops-capstone:latest --port=80
#  kubectl expose deployment capstone-clouddevops --type=LoadBalancer --port=80
#  sudo kubectl get services