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
./create-noparam.sh finalProjectNodeWorkers.yml

```
