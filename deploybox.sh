#!/bin/bash
# My first script

echo "Hello World!"

YOUR_OMDBAPIKEY=b8c4671d

sed -i -e 's/OMDBAPIKEY/YOUR_OMDBAPIKEY/g' vagrant
sed -i -e 's/OMDBAPIKEY/YOUR_OMDBAPIKEY/g' vagrant