# Blue/Green Deployment Using Jenkins
Capstone project for Udacity Cloud DevOps Nanodegree

This project borrows ideas (and some bash scripts 😉)from courses in the Nanodegree program

## STEPS
- Create an EC2 instance
- Clone this repo because the scripts install needed packages.
- In `templates` directory, create CloudFormation stack using:
    ```
    aws cloudformation create-stack --stack-name eks-cluster --region us-west-2 --template-body file://aws-eks-.yml --parameters file://params.json --capabilities CAPABILITY_IAM
    ```
- Alternatively you can install and use `eksctl`, you can use the `cluster.yaml` by running:
    ```
    eksctl create cluster -f cluster.yaml
    ```
- When the EKS Cluster is complete, in AWS EKS Dashboard add a Managed Node Group, wait for it to provision.
- Configure EKS cluster with EC2 instance using this command:
    ```
    aws eks update-kubeconfig --name zetacluster
    ```
  Remember the `ClusterName` variable in our CloudFormation stack?, its value is what we add there not the `--stack-name`.
- Copy **role arn** from cloudformation stack outputs into `templates/aws-auth.yml` file.
- Configure `aws-auth.yml` file in order to attach worker nodes to EKS cluster by running:
    ```
    kubectl apply -f aws-auth.yml
    ```
- Deploy initial code to Kubernetes cluster and pods using blue deployment in the `deploy` directory 
    ```
    kubectl apply -f blue.yml
    ```
- With `blue` deployment done, you can create the continuous pipeline.
- Configure AWS and Docker globally on Jenkins using the `pipeline-aws` plugin. If AWS is not configured properly, the pipeline will fail.

## TEST

- Go to Load balancer in EC2 and select specific load balancer. Copy provided DNS and open it in chrome.
- Alternatively, DNS can also be obtained by typing `kubectl get svc` in command line.
- `kubectl get pods` let's you see the pods
- `kubectl get nodes` show you the nodes

## Known issues
- A notable resource is [this question](https://stackoverflow.com/questions/48015106/pip-installed-pylint-cannot-be-found) from StackOverflow regarding `pylint`.
