# Tasks


## Question 1: Run a Pod Using Alpine Image
**Question:**
Run a pod called `alpine-sleeper-cka15-arch` using the alpine image in the default namespace that will sleep for 7200 seconds.

## Question 2: Make an ETCD Backup
**Question:**
Connect to the Kubeadm Lab 3 Cluster and make an ETCD backup. The backup should be stored in the `/opt/etcd-backup` directory on the control plane node.

## Question 3: Create a Kubernetes Deployment
**Question:**
Create a Kubernetes deployment named `nginx-deployment` in the `default` namespace. The deployment should run the `nginx` image and expose port 80. Ensure that the deployment has at least 3 replicas.

## Question 4: Expose a Deployment as a Service
**Question:**
Expose the `nginx-deployment` created in Question 3 as a service named `nginx-service` in the `default` namespace. The service should be of type `NodePort` and should expose port 80 on the node.

## Question 5: Create a ConfigMap
**Question:**
Create a ConfigMap named `app-config` in the `default` namespace. The ConfigMap should be create from a file named `config.properties` that contains the following key-value pairs:
```
app.name=myapp
app.version=1.0.0
```     
**Note:** Ensure that the `config.properties` file is present in the current directory before running the command to create the ConfigMap.

## Question 6: Create a Persistent Volume and Persistent Volume Claim
**Question:**
Create a Persistent Volume (PV) named `my-pv` with a capacity of 10Gi in the `default` namespace. The PV should use the `hostPath` volume type and should point to the directory `/mnt/data`. Then, create a Persistent Volume Claim (PVC) named `my-pvc` that requests 5Gi of storage from the `my-pv` Persistent Volume.

## Question 7: Create a Secret
**Question:**
Create a Secret named `db-secret` in the `default` namespace. The Secret should contain the following key-value pairs:
```
db.username=admin
db.password = secretpassword
```

## Question 8: Create a StatefulSet
**Question:**
Create a StatefulSet named `mysql-statefulset` in the `default` namespace. The statefulset should run the `postgres` image and should have 3 replicas. Each replica should have a persistent volume claim named `mysql-pvc` that requests 1Gi of storage.

## Question 9: Create a Pod with Resource Requests and Limits
**Question:**
Create a pod named `resource-limited-pod` in the `default` namespace that runs the `nginx` image. The pod should have resource requests of 100m CPU and 200Mi memory, and resource limits of 200m CPU and 400Mi memory.

## Question 10: Service Account and Role Binding
**Question:**
Create a Service Account named `my-service-account` in the `default` namespace. Then, create a Role named `pod-reader` that allows reading pods in the `default` namespace. Finally, create a RoleBinding named `pod-reader-binding` that binds the `pod-reader` role to the `my-service-account` service account in the `default` namespace.

## Question 11: Create a CronJob
**Question:**
Create a CronJob named `my-cronjob` in the `default` namespace. The CronJob should run a job every 5 minutes that prints the current date and time to the console. The job should use the `busybox` image and run the command `date`.

## Question 12: DNS
**Question:**
Create a deployment named `web-app` in the `default` namespace that runs the `nginx` image. Then, create a service named `web-service` that exposes the `web-app` deployment on port 80. Finally, verify that you can access the `web-service` using DNS within the cluster. The result of the DNS resolution should be stored in a file named `dns-resolution.txt` in your current directory.

## Question 13: Network Policies
**Question:**
Create a NetworkPolicy named `deny-all` in the `default` namespace that denies all ingress traffic to all pods in the namespace. Ensure that the policy is applied correctly by testing with a pod that tries to access another pod in the same namespace.

## Question 14: Service Account Token

**Question:**
Create a Service Account named `service-reader` in the `default` namespace. Then, create a Role named `service-reader-role` that allows reading services in the `default` namespace. Finally, create a RoleBinding named `service-reader-binding` that binds the `service-reader-role` role to the `service-reader` service account in the `default` namespace. Verify that the service account can read pods by running a command using the service account token inside a pod.

## Question 15: daemonSet
**Question:**
Create a DaemonSet named `log-collector` in the `default` namespace that runs the `fluentd` image. The DaemonSet should ensure that a pod is running on every node in the cluster. Verify that the DaemonSet is running correctly by checking the status of the pods.
