# The customer microservice (under haruum-customer-wrap folder) will be remotely stored at johaneschristiancc/cc_haruum_customer,
# The outlet microservice (under haruum-outlet-wrap folder) will be remotely stored at johaneschristiancc/cc_haruum_outlet.
# The order microservice (under haruum-order-wrap folder) will be remotely stored at johaneschristiancc/cc_haruum_order.
# The gateway microservice (under haruum-gateway-wrap folder) will be remotely stored at johaneschristiancc/cc_haruum_gateway.
# The front end microservice (under haruum-fe folder) will be remotely stored at johaneschristiancc/cc_haruum_fe.

# The following commands are used to build each application Dockerfiles and push 
# the built image to johaneschristiancc (my personal account) Docker Hub repositories.
# Each Docker image is assigned one repository.

# The following docker build command is executed in the level where this commands.sh is stored, i.e. the root folder of the project.
# The command build the dockerfile present at each build context, which are the microservices corresponding folder. 
# Each docker build commands follow the following pattern:
# docker build -t johaneschristiancc/<microservice-image-name> ./<microservice-folder>

# This is done to allow the dockerfile to refer to any files located in each corresponding microservice folder folder
# as we require to copy the project folder to the image for installing dependencies and running
# the application.

# With the context set to ./<microservice-folder>, the build instruction will seek for the dockerfile placed inside the folder and 
# any dockerfile instructions that refer to . in the host machine
# will refer to each microservice corresponding folder. 
# (for example, COPY ./haruum-customer . will copy the haruum-customer sub-folder in haruum-customer-wrap) 
# The -t options specify the name of the docker image to be built.
# For the convenience of not renaming the file when being pushed to the docker repository, the name is set 
# to directly match the name of each microservice corresponding repository. 

# The following command build the customer microservice image located in the haruum-customer-wrap folder.
docker build -t johaneschristiancc/cc_haruum_customer ./haruum-customer-wrap

# The following command build the outlet microservice image located in the haruum-customer-wrap folder.
docker build -t johaneschristiancc/cc_haruum_outlet ./haruum-outlet-wrap

# The following command build the outlet microservice image located in the haruum-order-wrap folder.
docker build -t johaneschristiancc/cc_haruum_outlet ./haruum-outlet-wrap

# The following command build the order microservice image located in the haruum-order-wrap folder.
docker build -t johaneschristiancc/cc_haruum_order ./haruum-order-wrap

# The following command build the gateway microservice image located in the haruum-gateway-wrap folder.
docker build -t johaneschristiancc/cc_haruum_gateway ./haruum-gateway-wrap

# The following command build the front-end microservice image located in the haruum-fe folder.
docker build -t johaneschristiancc/cc_haruum_fe ./haruum-fe

# The following command pushes the customer microservice to the johaneschristiancc/cc_haruum_customer repository on Docker Hub
docker push johaneschristiancc/cc_haruum_customer

# The following command pushes the outlet microservice image to the johaneschristiancc/cc_haruum_outlet repository on Docker Hub
docker push johaneschristiancc/cc_haruum_outlet

# The following command pushes the order microservice image to the johaneschristiancc/cc_haruum_order repository on Docker Hub
docker push johaneschristiancc/cc_haruum_order

# The following command pushes the gateway microservice image to the johanechristiancc/cc_haruum_fe repository on Docker Hub
docker push johaneschristiancc/cc_haruum_fe

# The following commands are used to start the Kubernetes deployment and services
# along with their respective Config and Secret Map. 
# They are executed on the root of the project directory (at the same level where commands.sh is located).
# The manifest file approach is used as a declarative way to define and configure the deployments and services.

# Start the MongoDB database deployment and service based on
# the mongo.yaml manifest file (as the initial desired state of the application).
kubectl apply -f ./kubernetes-config/mongo.yaml

# Start the MongoExpress database admin page deployment and service based on
# the mongo_express.yaml manifest file (as the initial desired state of the application).
kubectl apply -f ./kubernetes-config/mongo_express.yaml

# Start the customer microservice deployment and service based on
# the haruum_customer.yaml manifest file (as the initial desired state of the application).
kubectl apply -f ./kubernetes-config/haruum_customer.yaml

# Start the laundry outlet microservice deployment and service based on
# the haruum_outlet.yaml manifest file (as the initial desired state of the application).
kubectl apply -f ./kubernetes-config/haruum_outlet.yaml

# Start the laundry order microservice deployment and service based on
# the haruum_order.yaml manifest file (as the initial desired state of the application).
kubectl apply -f ./kubernetes-config/haruum_order.yaml

# Start the gateway application microservice deployment and service based on
# the haruum_gateway.yaml manifest file (as the initial desired state of the application).
kubectl apply -f ./kubernetes-config/haruum_gateway.yaml

# Start the front-end application microservice deployment and service (that depends on the gateway application)
# based on the haruum_fe.yaml manifest file (as the initial desired state of the application).
kubectl apply -f ./kubernetes-config/haruum_fe.yaml

