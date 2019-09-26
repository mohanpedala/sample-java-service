## Sample Java Service

####
Build the service and run it
* Build using maven
    ```
    mvn clean install
    ```
* Run the jar
  - App will be launched on **8080** port you can change it as per your need.
    ```
    java -jar sample-java-service-0.0.1-SNAPSHOT.jar --server.port=8080
    ```

* Test the content using your favourite browser and call the below rest endpoint
    ```
    http://localhost:8080/hello
    ```

#### Containerize the artifact and run it
* Run the below command to build the image
    ```
    docker build -t sample-java-app:v1 .
    ```
* Run container
 - App will be launched on **8080** port you can change it as per your need.
    ```
    docker run -d -p 8080:8080 --name sample-java-app sample-java-app:v1
    ```
* Test the content using your favourite browser and call the below rest endpoint
    ```
    http://localhost:8080/hello
    ```

#### Pre req for kuberntes:
* Created this scenario on Macbook pro:
    - Install Docker for mac: version Engine: 18.xx.x
    - Enable Kubernetes: Click on Docker icon on the taskbar --> Preferences --> Kubernetes

#### Deploy app on Kubernetes
* Deploy pods using deployment manifest.
    ```
    kubectl create -f app-deployment.yml
    ```
* Deploy service through a NodePort. Click here to know about [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/)
    ```
    kubectl create 0f app-svc.yml
    ```
* Check the resorce using'
    ```
    kubectl get all
    ```
    #### Expected Output:
    ```
    NAME                                         READY   STATUS    RESTARTS   AGE
    pod/app-one-metadata-name-54465f9444-d58wc   1/1     Running   0          3m31s
    pod/app-one-metadata-name-54465f9444-j8snn   1/1     Running   0          3m34s
    pod/app-one-metadata-name-54465f9444-zbkrl   1/1     Running   0          3m36s

    NAME                            TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
    service/app-one-metadata-name   NodePort    10.100.9.0   <none>        8080:30000/TCP   21m
    service/kubernetes              ClusterIP   10.96.0.1    <none>        443/TCP          5d1h

    NAME                                    READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/app-one-metadata-name   3/3     3            3           21m

    NAME                                               DESIRED   CURRENT   READY   AGE
    replicaset.apps/app-one-metadata-name-54465f9444   3         3         3       3m36s
    replicaset.apps/app-one-metadata-name-674bdfd76    0         0         0       21m
    replicaset.apps/app-one-metadata-name-7b48596fb7   0         0         0       5m6s
    ```
* To see the console output of the service, open your browser and type the below url
    ```
    http://localhost:30000/hello
    ```
    #### Expected output with json viewer chrome plugin
    ```
    // 20190914100042
    // http://localhost:30000/hello

    {
        "status": "hello"
    }
    ```

#### Clean up Environment
* Docker:
    ```
    docker stop sample-java-app
    docker rm $(docker ps -a -q)
    docker rmi sample-java-app:v1
    ```
* Kubernetes:
    ```
    kubectl delete -f app-deployment.yml
    kubectl delete -f app-svc.yml
    ```

#### K8s secret creation to access dockerhub.
* First Create access token in Dockerhub. Click [here](https://blog.docker.com/2019/09/docker-hub-new-personal-access-tokens/) for documentation.
* On you cluster run the below command

    ```
    kubectl create secret docker-registry --dry-run=true $secret_name \
    --docker-server=<DOCKER_REGISTRY_SERVER> \
    --docker-username=<DOCKER_USER> \
    --docker-password=<DOCKER_PASSWORD> \
    --docker-email=<DOCKER_EMAIL> -o yaml
    ```
    - Explanation:
        ```
        <your-registry-server> is your Private Docker Registry FQDN. (https://index.docker.io/v1/ for DockerHub)
        <your-name> is your Docker username.
        <your-pword> is your Docker password.
        <your-email> is your Docker email.
        ```
* Add the below spec under the `containers spec` in the app-deployment.yml
    ```
    ---
    spec:
      containers:
        - name: app-one-container
          image: phaneindra/sample-java-app:latest
          ports:
          - containerPort: 8080
          resources:
            requests:
              memory: "64Mi"
              cpu: "250m"
            limits:
              memory: "128Mi"
              cpu: "500m"
      
      imagePullSecrets:
      - name: docker-hub

    ---
    ```