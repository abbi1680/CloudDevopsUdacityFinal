# CloudDevopsUdacityFinal
This is the final project implementation of Cloud Devops Nanodegree of Udacity. In this project , we are building a simple flask web app, making continuous integration and blue green deployments with jenkins, docker to build containers and use amazon ECR and EKS to register containers and deploy them on a cluster

## Getting Started

### Project's files
`aws/network-infra` : It contains scripts to create a registry on Amazon ECR, deploy A VPC (network for kubernetes), deploy an EKS Cluster and NodesWorkers <br />
`aws/AppsDeploymentsStrategy` : It contains deployments descriptions and services to make a blue green deployments with jenkins <br />
`dockerfile` : instructions to build the container <br />
`Makefile` : a makefile to run commands easily  <br />
`jenkinsfile` : the pipeline used for continuous integration and deployment <br />
`rundocker.sh` : script to build and run a container locally  <br />
`requirements.txt` : libraries required to be able to run the app  <br />
`All other files` are part of the flask web app i have made
 
What things you need to install the software and how to install them

### Prerequisites

You will need :

```
An Amazon AWS account in order to use ECR et EKS and cloudformation to build the network
```
```
A Jenkins up and running in order to build the pipeline ( we use here an ec2 instance on AWS)
```
```
A local machine for the developpers or in the cloud to push modifications to git
```

### Installing Environment

To have an environnement fully working, you will have to walk through different steps :

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

Building the network with CloudFormation : VPC, private an public subnets routing table , nate gateways .....
```
cd aws/network-infra/
./create.sh infraFinalProject network.yml network-parameters.json

```
Building the EKS cluster with aws informations given in the network stack Output 
```
cd aws/network-infra/
./createEKSCluster.sh

```
Creating the node workers with cloudFormation scripts

```
cd aws/network-infra/
./creates-noparam.sh finalProjectNodeWorkers.yml

```

### Testing the pipeline

Make sure you have a working jenkins with a token on your github repo in order to take changes done by developpers. <br/>
The pipeline is described in the the `Jenkinsfile` <br/>
Activate the repo scanning by jenkins in order to run automatically the pipeline or run the pipeline manually after changes.

All you need to do is modify the code and push it on your repo and de pipeline will run automatically if you set it.


## Blue Green Deployment
i will describe what i have done in the jenkins pipeline <br/>
The blue green is done here with kubernetes pods. <br/>
the first time the pipeline is launched, if there is no deployments already , it will assign to the new deployment an initial color.
### Step 1
 2 pods and a service endpoint as the production env (it is the blue pods) exist<br/>
 the pipeline checks for the inactive color
 ### Step 2
 When a new version is pushed, the pipeline build a new version , push it to ECR and deploy it as new pods (green pods) on the cluster <br/>
 Notice : for the moment only blue pods are exposed by the service ELB .<br/>
 ### Step 3
 I build a second service with the purpose to only test the newly created pods before exposing it <br/>
 Tests are done here before exposing it to the world
 ### Step 4 
 When all tests are done, the pipeline switch the service ELB selector to green to switch the pods exposed.
 ### Step 5
 If there is no need to rollback, old deployment is deleted
 

