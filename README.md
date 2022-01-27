# aws-serverless-node-lambda-layer-template
Template Project to help you creating your node lambda Layer using serverless framework

# Create your repo
1. Create your own repo by clicking on the [[use this template](https://github.com/EveryMundo/aws-serverless-node-lambda-layer-template/generate)] button on the home of this repo 
2. Name your repo as node-NAME-layer
3. clone your repo to your local environment

# Initialize the project
```sh
./initialize-layer.sh node-NAME-layer [npm-module1 npm-module2 ... npm-moduleN]
```
or if your repo has the name of the layer
```sh
./initialize-layer.sh $(basename $PWD) [npm-module1 npm-module2 ... npm-moduleN]
```
example:
```sh
./initialize-layer.sh node-testing-layer mocha chai sinon nyc
```

Once initialized, because the serverless.yml file comes with no account information, you can deploy it right away by passing the account as an environment variable
```sh
AWS_ACCOUNT=012345678900 sls deploy
```
But you can also edit the file and set your account number to it

The default region in the file is **us-west-2** but if you want to deploy it to another region you can pass it as a parameter as well
```sh
AWS_ACCOUNT=012345678900 sls deploy --region us-east-1
```

That means you can deploy to multiple regions very easily with a simple shell *for loop* as you can see below:
```sh
for REGION in us-east-1 us-east-2 us-west-2; do AWS_ACCOUNT=012345678900 sls deploy --region "$REGION"; done
```

# How to use the published layers within your serverless project
On your serverless.yml file you just add the layers to the ```/functions?/``` using the cloud formation reference like this:

```yml
functions:
  yourFunc:
    layers:
      - ${cf:node-YOUR-LAYER-NAME-layer.LibLambdaLayerQualifiedArn}
```
