# Kubernetes – Core Concepts

This document provides a comprehensive overview of Kubernetes core concepts, architecture, installation, configuration, and operational best practices. It also includes scenario-based interview questions for deeper understanding and preparation.

---

## Table of Contents
1. [Kubernetes Architecture & Components](#kubernetes-architecture--components)
2. [Installing a Kubernetes Cluster](#installing-a-kubernetes-cluster)
3. [Accessing Cluster & Kubeconfig](#accessing-cluster--kubeconfig)
4. [Namespaces & RBAC](#namespaces--role-based-access-control)
5. [Pod Deployment Event Order](#order-of-events-while-deploying-a-pod)
6. [Liveness & Readiness Probes](#liveness--readiness-probes)
7. [Kubernetes Service Types](#kubernetes-service-types)
8. [Deployments, ReplicaSet, HPA, ConfigMap, Secrets](#deployments-replicaset-hpa-configmap-secrets)
9. [Cluster Upgrade Without Downtime](#steps-to-upgrade-a-kubernetes-cluster-without-downtime)
10. [Monitoring & Kube-Metrics](#kubernetes-monitoring--kube-metrics)
11. [Scenario-Based Interview Questions](#scenario-based-interview-questions)

---

## Kubernetes Architecture & Components

Kubernetes is a container orchestration platform that automates deployment, scaling, and management of containerized applications.

**Key Components:**
- **Master Node (Control Plane):**
  - API Server: Frontend for the Kubernetes control plane.
  - etcd: Consistent and highly-available key-value store for cluster data.
  - Controller Manager: Runs controllers (e.g., node, replication, endpoints).
  - Scheduler: Assigns pods to nodes.
- **Worker Node:**
  - Kubelet: Ensures containers are running in a pod.
  - Kube-proxy: Maintains network rules for pod communication.
  - Container Runtime: (Docker, containerd, CRI-O)

**Architecture Diagram:**
```
[User] → [kubectl] → [API Server] → [etcd]
                        ↓
                [Controller Manager]
                        ↓
                   [Scheduler]
                        ↓
                 [Worker Nodes]
                /      |      \
         [Kubelet] [Kube-proxy] [Container Runtime]
```

---

## Installing a Kubernetes Cluster

**Popular Methods:**
- Minikube (local dev)
- kubeadm (production)
- Managed services (EKS, AKS, GKE)

**Example: kubeadm Installation**
```bash
# On all nodes
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
 deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

# On master node
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
# Set up kubeconfig for user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install network plugin (e.g., Flannel)
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

---

## Accessing Cluster & Kubeconfig

- **kubectl:** Command-line tool to interact with the cluster.
- **kubeconfig file:** Stores cluster access info (server, user, context).

**Example kubeconfig snippet:**
```yaml
apiVersion: v1
clusters:
- cluster:
    server: https://1.2.3.4:6443
    certificate-authority-data: ...
  name: my-cluster
contexts:
- context:
    cluster: my-cluster
    user: admin
  name: my-context
current-context: my-context
users:
- name: admin
  user:
    client-certificate-data: ...
    client-key-data: ...
```

---

## Namespaces & Role Based Access Control (RBAC)

- **Namespaces:** Logical partitions for resources (e.g., dev, prod).
- **RBAC:** Controls who can access what in the cluster.

**Example:**
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: dev
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: dev
subjects:
- kind: User
  name: jane
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

---

## Order of Events While Deploying a Pod

1. User submits pod manifest via kubectl.
2. API Server validates and stores manifest in etcd.
3. Scheduler assigns pod to a node.
4. Kubelet on node receives pod spec.
5. Kubelet instructs container runtime to start containers.
6. Pod status updated and available via API Server.

---

## Liveness & Readiness Probes

- **Liveness Probe:** Checks if the container is running. If it fails, container is restarted.
- **Readiness Probe:** Checks if the container is ready to serve traffic. If it fails, pod is removed from service endpoints.

**Example:**
```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 15
  periodSeconds: 20
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
```

---

## Kubernetes Service Types

- **ClusterIP:** Default, internal-only access.
- **NodePort:** Exposes service on each node's IP at a static port.
- **LoadBalancer:** Provisions external load balancer (cloud only).
- **ExternalName:** Maps service to DNS name.

**Example:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: LoadBalancer
  selector:
    app: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

---

## Deployments, ReplicaSet, Probes, HPA, ConfigMap, Secrets

- **Deployment:** Manages ReplicaSets and pod updates.
- **ReplicaSet:** Ensures specified number of pod replicas.
- **HPA (Horizontal Pod Autoscaler):** Scales pods based on metrics.
- **ConfigMap:** Stores non-confidential config data.
- **Secret:** Stores sensitive data (passwords, tokens).

**Example Deployment with HPA, ConfigMap, Secret:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: web
        image: nginx
        env:
        - name: CONFIG_VALUE
          valueFrom:
            configMapKeyRef:
              name: web-config
              key: config-key
        - name: SECRET_VALUE
          valueFrom:
            secretKeyRef:
              name: web-secret
              key: secret-key
        livenessProbe:
          httpGet:
            path: /healthz
            port: 80
        readinessProbe:
          httpGet:
            path: /ready
            port: 80
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: web-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-deployment
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```

---

## Steps to Upgrade a Kubernetes Cluster Without Downtime

1. Upgrade master/control plane nodes one at a time.
2. Upgrade worker nodes in rolling fashion.
3. Use `kubectl cordon` and `kubectl drain` before upgrading each node.
4. Upgrade kubelet and kubectl on each node.
5. Uncordon nodes after upgrade.
6. Monitor workloads and cluster health throughout.

---

## Kubernetes Monitoring & Kube-Metrics

- **Tools:** Prometheus, Grafana, kube-state-metrics, Metrics Server
- **Metrics:** CPU, memory, pod status, custom app metrics
- **Best Practices:**
  - Set up alerting for resource limits
  - Visualize metrics with Grafana
  - Use logging solutions (ELK, EFK)

**Example:**
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: prometheus
---
apiVersion: v1
kind: Service
metadata:
  name: prometheus
spec:
  type: ClusterIP
  ports:
    - port: 9090
      targetPort: 9090
```

---


## Scenario-Based Interview Questions & Answers

1. **Explain the role of etcd in Kubernetes.**
  - etcd is a distributed, consistent key-value store used by Kubernetes to store all cluster data, including configuration, state, and metadata. It acts as the single source of truth for the cluster.

2. **How does the scheduler decide where to place a pod?**
  - The scheduler evaluates available nodes based on resource requirements, node selectors, affinity/anti-affinity rules, taints/tolerations, and constraints. It selects the best node that meets the pod's requirements and schedules the pod there.

3. **What is the difference between a Deployment and a StatefulSet?**
  - Deployment manages stateless applications, providing rolling updates and scaling. StatefulSet manages stateful applications, providing stable network identities, persistent storage, and ordered deployment/scaling.

4. **How do you restrict access to a namespace?**
  - Use RBAC roles and role bindings scoped to the namespace. Only users/groups/service accounts with the appropriate roles can access resources in that namespace.

5. **Describe the steps to upgrade a cluster with zero downtime.**
  - Upgrade control plane nodes one at a time, then worker nodes in a rolling fashion. Use `kubectl cordon` and `kubectl drain` to safely evict pods, upgrade kubelet/kubectl, and uncordon nodes. Monitor workloads and cluster health throughout.

6. **How do liveness and readiness probes differ?**
  - Liveness probes check if a container is running; if it fails, the container is restarted. Readiness probes check if a container is ready to serve traffic; if it fails, the pod is removed from service endpoints but not restarted.

7. **What are the different service types in Kubernetes?**
  - ClusterIP (internal access), NodePort (external access via node IP/port), LoadBalancer (external cloud load balancer), ExternalName (maps service to DNS name).

8. **How do you use ConfigMap and Secret in a pod?**
  - Mount as environment variables or volumes in the pod spec. ConfigMap is for non-sensitive config, Secret is for sensitive data (e.g., passwords, tokens).

9. **What is RBAC and how is it implemented?**
  - Role-Based Access Control (RBAC) restricts access to resources based on roles. Implemented via Role/ClusterRole and RoleBinding/ClusterRoleBinding objects, mapping users/groups/service accounts to permissions.

10. **How do you monitor pod resource usage?**
  - Use Metrics Server, Prometheus, and Grafana to collect and visualize CPU, memory, and custom metrics. Set up alerts for resource limits and anomalies.

11. **How would you troubleshoot a pod stuck in Pending state?**
  - Check pod events (`kubectl describe pod`), node resources, scheduling constraints, taints/tolerations, and image pull errors. Ensure enough resources and correct configuration.

12. **What is the order of events when a pod is deployed?**
  - Manifest submitted → API Server validates/stores → Scheduler assigns node → Kubelet receives spec → Container runtime starts containers → Pod status updated.

13. **How do you scale pods automatically?**
  - Use Horizontal Pod Autoscaler (HPA) to scale pods based on CPU, memory, or custom metrics. Configure min/max replicas and scaling thresholds.

14. **How do you expose an application externally?**
  - Use NodePort or LoadBalancer service types, or Ingress resources for HTTP/HTTPS routing. In cloud environments, LoadBalancer provisions an external IP.

15. **What steps would you take to secure a Kubernetes cluster?**
  - Enable RBAC, use namespaces, restrict API access, enable audit logging, use network policies, keep components updated, scan images for vulnerabilities, and use Secrets for sensitive data.

---

## References
- [Kubernetes Official Documentation](https://kubernetes.io/docs/)
- [kubeadm Install Guide](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
- [RBAC Concepts](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Kubernetes Monitoring](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/)
- [Kubernetes Upgrades](https://kubernetes.io/docs/tasks/administer-cluster/cluster-upgrade/)

---

This document serves as a foundational guide for Kubernetes core concepts and interview preparation.
