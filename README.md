## Sample Java Service

####
Build the service and run it
* Build using maven
```
mvn clean install
```
* Run the jar
  - App will be launched on **8090** port you can change it as per your need.
  ```
  java -jar sample-java-service-0.0.1-SNAPSHOT.jar --server.port=8090
  ```

* Test the content using your favourite browser and call the below rest endpoint
```
http://localhost:8090/hello
```

#### Containerize the artifact and run it
* Run the below command to build the image
```
docker build -t app1 .
```
* Run container
 - App will be launched on **8090** port you can change it as per your need.
```
docker run -d -p 8090:8080 app1
```
* Test the content using your favourite browser and call the below rest endpoint
```
http://localhost:8090/hello
```

#### Deploy app on Kubernetes
```
Coming Soon
```
