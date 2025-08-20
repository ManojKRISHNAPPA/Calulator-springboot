
# microk8s
```
sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER
mkdir -p ~/.kube
chmod 0700 ~/.kube
cd .kube
microk8s config > config

```

# kubectl 
```
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.3/2024-04-19/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin
kubectl version --client
```


# Setup Istio
```
 microk8s.enable istio
```


```
watch microk8s.kubectl get all --all-namespaces
```

## Install istio add-ons
```
mkdir -p istio-addons
curl -L https://raw.githubusercontent.com/istio/istio/release-1.25/samples/addons/prometheus.yaml -o istio-addons/prometheus.yaml
curl -L https://raw.githubusercontent.com/istio/istio/release-1.25/samples/addons/grafana.yaml -o istio-addons/grafana.yaml
curl -L https://raw.githubusercontent.com/istio/istio/release-1.25/samples/addons/kiali.yaml -o istio-addons/kiali.yaml
curl -L https://raw.githubusercontent.com/istio/istio/release-1.25/samples/addons/jaeger.yaml -o istio-addons/jaeger.yaml

kubectl apply -f istio-addons/prometheus.yaml
kubectl apply -f istio-addons/grafana.yaml
kubectl apply -f istio-addons/jaeger.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.27/samples/addons/kiali.yaml
```

## Create ecommerce namespace and enable istio-injection
```
kubectl create namespace ecommerce
kubectl label namespace ecommerce istio-injection=enabled
```

## Understanding Our Microservices Architecture
Our ecommerce application consists of several microservices, each responsible for a specific business function:

ecommerce-ui: The frontend React application that users interact with

product-catalog: Manages product listings and details

product-inventory: Tracks product availability

profile-management: Handles user profiles and authentication

order-management: Processes customer orders

shipping-and-handling: Manages shipping logistics

contact-support-team: Provides customer support functionality

## Deploy ecommerce application
```
kubectl apply -f microservices/
```

## Configuring Istio for Traffic Management
```
kubectl apply -f istio/
```


