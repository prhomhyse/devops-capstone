# devops-capstone
Capstone project for Udacity Cloud DevOps Nanodegree

This project borrows ideas from courses in the Nanodegree program.

A notable resource is [this question](https://stackoverflow.com/questions/48015106/pip-installed-pylint-cannot-be-found) from StackOverflow regarding `pylint`.

## STEPS
- Create an EC2 instance
- Clone this repo because the scripts install needed packages.
- Create CloudFormation stack
- Alternatively you can install and use `eksctl`, you can use the `cluster.yaml`
- When the EKS Cluster is complete
- Add the rolearn from CloudFormation output  to `templates/aws-auth.yml` 
- And `kubectl` all the way.
