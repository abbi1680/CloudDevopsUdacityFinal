# CloudDevopsUdacityFinal
This is the final project implementation of Cloud Devops Nanodegree of Udacity. In this project , we are building a simple flask web app, making continuous integration and blue green deployments with jenkins, docker to build containers and use amazon ECR and EKS to register containers and deploy them on a cluster

## Getting Started

### Project's files
`aws/network-infra` : It contains scripts to create a registry on Amazon ECR, deploy A VPC (network for kubernetes), deploy an EKS Cluster and NodesWorkers <br />
`aws/deployments` : It contains deployments descriptions and services to make a blue green deployments with jenkins <br />
`dockerfile` : instructions to build the container <br />
`jenkinsfile` : the pipeline used for continuous integration and deployment <br />
`rundocker.sh` : script to build and run a container locally  <br />
`All other files` are part of the flask web app i have made
 
What things you need to install the software and how to install them

### Prerequisites

What things you need to install the software and how to install them

```
Amazon AWS account in order to use ECR et EKS and cloudformation to build the network
```
```
Jenkins up and running in order to build the pipeline ( we use here an ec2 instance on AWS)
```
```
A local machine for the developpers or in the cloud to push modifications to git
```

### Installing

To have an environnement fully working, you will have to walk through different steps

#### Dev environment

First you have to clone this repository

```
git clone  https://github.com/magmax007/CloudDevopsUdacityFinal.git
```

make an virtual environment to be able run the app : it will setup the venv and install dependencies for the app
```
make setup
```
test the app

```
python3 app.py
```
Build a container if you want from your local (need the installation of Docker)
```
./runDocker.sh
```
Notice : there is no need to build the container from your own : it will be done automatically in the pipeline with jenkins

#### Amazon ECR 

To be able to push a container to a registry - we use here amazon ecr - We have to create it on amazon AWS

```
./aws/createECR.sh
```
#### Amazon EKS
to build the EKS cluster with an complete environment we will do it in 3 steps 

Building the network : VPC, private an public subnets routing table , nate gateways .....
```
cd aws/network-infra/
./create.sh infraFinalProject network.yml network-parameters.json

```


And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

