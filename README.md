# CloudDevopsUdacityFinal
This is the final project implementation of Cloud Devops Nanodegree of Udacity. In this project , we are building a simple flask web app, making continuous integration and blue green deployments with jenkins, docker to build containers and use amazon ECR and EKS to register containers and deploy them on a cluster

## Getting Started

### Repo descriptions
aws/network-infra : It contains scripts to create a registry on Amazon ECR, deploy A VPC (network for kubernetes), deploy an EKS Cluster and NodesWorkers <br />
aws/deployments : It contains deployments descriptions and services to make a blue green deployments with jenkins <br />
dockerfile : instructions to build the container <br />
jenkinsfile : the pipeline used for continuous integration and deployment <br />
rundocker.sh : script to build and run a container locally  <br />
All other files are part of the flask web app i have made
 
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

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
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

