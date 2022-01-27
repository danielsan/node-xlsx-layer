#!/bin/bash
set -e
set -x
THISFILE=$0
WD=$(dirname $THISFILE)
cd $WD
SERVICE=$1
shift 1
echo "\$@ npm i $@"
# exit

echo "# $SERVICE" > README.md
git add README.md

if [ "$SERVICE" = "" ]; then
  echo "please set your layer name starting with node- and ending with -layer"
  echo
  echo "$0 node-NAME-layer"
  exit 1
fi

node -e "var r=/^node-[-\w]+-layer\$/;require('assert')(r.test('$SERVICE'), \`[$SERVICE] does not match \${r}\`)"

node -e "var yml='./serverless.yml',data=fs.readFileSync(yml).toString().replace('node-yourServiceName-layer','$SERVICE'.replace('-layer',''));fs.writeFileSync(yml, data)"

mkdir nodejs || echo
cd nodejs
npm init -y
node -e "var pj='./package.json',data=JSON.stringify({...require(pj),name:'@everymundo/$SERVICE'}, null, 2);fs.writeFileSync(pj, data)"
npm i $@
git add package*.json

cd ..
git rm "$THISFILE"

git commit -am 'initialized'