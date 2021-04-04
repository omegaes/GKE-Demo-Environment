#!/bin/bash

gcloudConfig(){
  gcloud auth login
  gcloud config set project $PROJECT_ID
  gcloud config set region $REGION
}

gcloudCreateCluster(){
    gcloud container clusters create $CLUSTER_NAME \
    --num-nodes=1 \
    --enable-autoscaling \
    --cluster-version=1.17 \
    --num-nodes=1 \
    --max-nodes=1 \
    --machine-type=e2-medium
}


gcloudGetClusterCredentials(){  
    gcloud container clusters get-credentials $CLUSTER_NAME
}

deployKubeManifests(){
    kubectl apply -k ./production/
}



gcloudConfig
gcloudCreateCluster
gcloudGetClusterCredentials
deployKubeManifests

