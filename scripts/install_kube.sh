#!/usr/bin/env bash


# -------------------------------------Pre-requisite-------------------------------------------------
# chmod +x install-kubectl.sh

# -------------------------------------Install kubectl-----------------------------------------------
apt update
apt upgrade
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl\
    -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

# Test if kubectl is working
# kubectl version --short --client


# --------------------------------Install aws-iam-authenticator--------------------------------------
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
# mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
# echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
 
# Test if aws-iam-authenticator is working
# aws-iam-authenticator help