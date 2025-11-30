# Cloud Architecture [AWS]

This README provides a comprehensive overview of key AWS Cloud Architecture concepts, including VPC, subnet tiers, NAT, Transit Gateway (TGW), IAM models, Security Groups (SG) vs Network ACLs (NACL), and more. It also includes scenario-based interview questions and a detailed example of designing a secure multi-AZ architecture.

---


## Table of Contents
1. [VPC (Virtual Private Cloud)](#vpc)
2. [Subnet Tiers](#subnet-tiers)
3. [NAT (Network Address Translation)](#nat)
4. [Transit Gateway (TGW)](#transit-gateway-tgw)
5. [IAM Models](#iam-models)
6. [Security Groups vs Network ACLs](#security-groups-vs-network-acls)
7. [EC2 (Elastic Compute Cloud)](#ec2-elastic-compute-cloud)
8. [API Gateway](#api-gateway)
9. [Lambda](#lambda)
10. [Load Balancers](#load-balancers)
11. [EKS Clusters](#eks-clusters)
12. [Scenario-Based Interview Questions](#scenario-based-interview-questions)
13. [Example: Designing Secure Multi-AZ Architecture](#example-designing-secure-multi-az-architecture)
14. [Multi-Service Scenario: Serverless Web App](#multi-service-scenario-serverless-web-app)

---

## VPC (Virtual Private Cloud)

A VPC is a logically isolated section of the AWS Cloud where you can launch AWS resources in a virtual network that you define.

- **Features:**
  - Custom IP address range
  - Subnets
  - Route tables
  - Internet gateways
  - Security controls

**Example:**
```text
Create a VPC with CIDR block 10.0.0.0/16
```

---

## Subnet Tiers

Subnets divide a VPC's IP address range into smaller segments. Subnets are typically categorized as:

- **Public Subnet:**
  - Directly accessible from the internet (via Internet Gateway)
  - Hosts resources like load balancers, bastion hosts

- **Private Subnet:**
  - No direct internet access
  - Hosts application servers, databases

- **DMZ Subnet:**
  - Sits between public and private subnets
  - Used for additional security layers

**Example:**
```text
VPC: 10.0.0.0/16
  Public Subnet: 10.0.1.0/24
  Private Subnet: 10.0.2.0/24
```

---

## NAT (Network Address Translation)

NAT enables instances in a private subnet to connect to the internet or other AWS services, but prevents the internet from initiating connections with those instances.

- **NAT Gateway:** Managed, scalable, recommended for production
- **NAT Instance:** EC2-based, legacy, less scalable

**Example:**
```text
Private subnet → NAT Gateway (in public subnet) → Internet
```

---

## Transit Gateway (TGW)

TGW is a network transit hub that enables you to connect VPCs and on-premises networks via a central hub.

- **Benefits:**
  - Simplifies network architecture
  - Scalable and highly available
  - Centralized management

**Example:**
```text
Multiple VPCs ↔ TGW ↔ On-premises network
```

---

## IAM Models

IAM (Identity and Access Management) controls access to AWS resources.

- **Users:** Individual identities
- **Groups:** Collections of users
- **Roles:** Temporary credentials for AWS services or users
- **Policies:** JSON documents defining permissions

**Best Practices:**
- Use least privilege principle
- Use roles for EC2 and cross-account access
- Enable MFA for users

---

## Security Groups vs Network ACLs

| Feature            | Security Group (SG)         | Network ACL (NACL)         |
|--------------------|----------------------------|----------------------------|
| Level              | Instance-level              | Subnet-level               |
| Statefulness       | Stateful                    | Stateless                  |
| Rules              | Allow only                  | Allow & Deny               |
| Evaluation Order   | All rules                   | Numbered, evaluated in order|
| Use Case           | EC2, ELB, RDS               | Subnet-wide control        |

**Example:**
- SG: Allow inbound TCP 22 from 203.0.113.0/24
- NACL: Deny inbound TCP 22 from 0.0.0.0/0

---


---

## EC2 (Elastic Compute Cloud)

EC2 provides scalable compute capacity in the cloud. You can launch virtual servers, configure networking, and scale as needed.

- **Use Cases:** Web servers, application servers, batch processing, custom workloads
- **Features:**
  - Multiple instance types (general, compute, memory, GPU)
  - Auto Scaling
  - Placement Groups
  - Elastic IPs

**Example Scenario:**
Deploy a web application on EC2 instances in private subnets, accessed via an Application Load Balancer in public subnets.

**Interview Questions:**
1. How do you secure EC2 instances in a public subnet?
2. What is the difference between spot, reserved, and on-demand instances?
3. How would you automate EC2 deployment and scaling?

---

## API Gateway

API Gateway enables you to create, publish, maintain, monitor, and secure APIs at scale.

- **Use Cases:** Serverless REST APIs, WebSocket APIs, integration with Lambda and backend services
- **Features:**
  - Request/response transformation
  - Throttling and quotas
  - Authorization (IAM, Cognito, Lambda authorizers)

**Example Scenario:**
Expose RESTful endpoints for a serverless application, routing requests to Lambda functions and EC2 microservices.

**Interview Questions:**
1. How do you secure APIs in API Gateway?
2. What are the integration types supported by API Gateway?
3. How would you implement rate limiting and caching?

---

## Lambda

AWS Lambda lets you run code without provisioning or managing servers. You pay only for compute time consumed.

- **Use Cases:** Event-driven processing, serverless APIs, scheduled tasks, real-time file processing
- **Features:**
  - Automatic scaling
  - Integrates with API Gateway, S3, DynamoDB, EventBridge, etc.
  - Environment variables

**Example Scenario:**
Process S3 file uploads with Lambda, trigger notifications, and update DynamoDB.

**Interview Questions:**
1. How do you manage dependencies in Lambda functions?
2. What are cold starts and how can you mitigate them?
3. How would you secure Lambda execution?

---

## Load Balancers

AWS offers several load balancer types:
- **Application Load Balancer (ALB):** Layer 7, HTTP/HTTPS, path-based routing
- **Network Load Balancer (NLB):** Layer 4, TCP/UDP, high performance
- **Gateway Load Balancer (GLB):** Integrates with third-party appliances

**Use Cases:**
  - Distribute traffic across EC2, containers, Lambda
  - SSL termination
  - Health checks and auto scaling

**Example Scenario:**
Deploy ALB in public subnets, target EC2 instances in private subnets, enable HTTPS and path-based routing.

**Interview Questions:**
1. How do you configure health checks for ALB?
2. What is the difference between ALB and NLB?
3. How would you implement blue/green deployments with load balancers?

---

## EKS Clusters

Amazon EKS is a managed Kubernetes service for running containerized applications.

- **Use Cases:** Microservices, batch jobs, CI/CD pipelines, hybrid workloads
- **Features:**
  - Managed control plane
  - Integration with IAM, VPC, ALB/NLB
  - Cluster Autoscaler

**Example Scenario:**
Deploy a multi-tenant SaaS platform using EKS, with ALB ingress, private networking, and IAM roles for service accounts.

**Interview Questions:**
1. How do you secure communication between pods in EKS?
2. How would you scale EKS clusters automatically?
3. How do you integrate EKS with other AWS services?

---

## Scenario-Based Interview Questions

1. Design a VPC for a multi-tier web application. What subnets and routing would you use?
2. How would you enable secure communication between multiple VPCs?
3. Explain the difference between SG and NACL. When would you use each?
4. How do you restrict access to an S3 bucket for EC2 instances in a private subnet?
5. Describe a scenario where you would use a Transit Gateway.
6. How would you design IAM policies for a team with different access needs?
7. What steps would you take to secure a VPC hosting sensitive data?
8. How would you design a scalable API using API Gateway and Lambda?
9. What are best practices for deploying EC2 behind a Load Balancer?
10. How do you architect a secure EKS cluster with private networking?

---

## Multi-Service Scenario: Serverless Web App

**Scenario:**
Design a secure, scalable serverless web application using API Gateway, Lambda, VPC, EC2, Load Balancer, and EKS.

### Step-by-Step Solution

1. **VPC Design**
   - Create VPC with public and private subnets across multiple AZs

2. **API Gateway**
   - Expose RESTful endpoints
   - Integrate with Lambda for serverless compute

3. **Lambda Functions**
   - Process API requests, interact with DynamoDB, S3, or other services
   - Use VPC integration for private resources

4. **EC2 Instances**
   - Host legacy services or workloads not suited for Lambda
   - Place in private subnets, accessed via ALB

5. **Application Load Balancer**
   - Distribute traffic to EC2 and EKS services
   - Enable HTTPS, path-based routing

6. **EKS Cluster**
   - Deploy containerized microservices
   - Use ALB ingress controller for traffic management

7. **Security**
   - Use IAM roles for Lambda, EC2, EKS
   - Restrict access with SGs and NACLs
   - Enable logging and monitoring (CloudWatch, VPC Flow Logs)

**Diagram:**
```
[Internet] ↔ [API Gateway] ↔ [Lambda] ↔ [VPC Private Subnet]
           ↔ [ALB] ↔ [EC2] / [EKS]
           ↔ [S3, DynamoDB, RDS]
```

**Security Considerations:**
- Use least privilege IAM roles
- Encrypt data at rest and in transit
- Monitor and audit access

---

---

## Example: Designing Secure Multi-AZ Architecture

**Scenario:**
Design a secure, highly available web application architecture across multiple Availability Zones (AZs) in AWS.

### Step-by-Step Solution

1. **Create a VPC**
   - CIDR: 10.0.0.0/16

2. **Create Subnets in Multiple AZs**
   - Public Subnets: 10.0.1.0/24 (AZ1), 10.0.2.0/24 (AZ2)
   - Private Subnets: 10.0.3.0/24 (AZ1), 10.0.4.0/24 (AZ2)

3. **Attach Internet Gateway to VPC**
   - Enables internet access for public subnets

4. **Configure Route Tables**
   - Public subnets: Route to Internet Gateway
   - Private subnets: Route to NAT Gateway

5. **Deploy NAT Gateway in Public Subnet**
   - Allows private subnet instances to access the internet securely

6. **Launch EC2 Instances**
   - Web servers in public subnets
   - App/database servers in private subnets

7. **Configure Security Groups**
   - Web SG: Allow inbound HTTP/HTTPS from 0.0.0.0/0
   - App SG: Allow inbound from Web SG only
   - DB SG: Allow inbound from App SG only

8. **Configure NACLs for Subnets**
   - Public subnet NACL: Allow HTTP/HTTPS, restrict other traffic
   - Private subnet NACL: Allow only necessary ports

9. **Enable Multi-AZ for RDS (if using a database)**
   - Ensures high availability

10. **IAM Roles and Policies**
    - Assign least privilege roles to EC2, RDS, etc.
    - Enable logging and monitoring (CloudWatch, VPC Flow Logs)

**Diagram:**
```
[Internet] ↔ [IGW] ↔ [Public Subnet (Web)] ↔ [NAT GW] ↔ [Private Subnet (App/DB)]
           |                                 |
         [AZ1]                            [AZ2]
```

**Security Considerations:**
- Use SGs and NACLs to restrict traffic
- Use IAM roles for resource access
- Enable encryption for data at rest and in transit
- Monitor with CloudWatch and VPC Flow Logs

---

## References
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
- [AWS Subnet Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)
- [AWS NAT Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
- [AWS Transit Gateway](https://docs.aws.amazon.com/vpc/latest/tgw/what-is-transit-gateway.html)
- [AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
- [Security Groups vs NACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html)

---

This README serves as a foundational guide for AWS Cloud Architecture concepts and interview preparation.