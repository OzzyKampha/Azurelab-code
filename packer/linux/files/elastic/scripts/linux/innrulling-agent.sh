#!/bin/bash
if [ `id -u` -eq 0 ]
then
        echo "Ah, welcome O' Mighty One."
else
        echo "Må kjøres med sudo."
        exit 1
fi

api_key=$( curl --insecure -u elastic:elastic https://10.0.2.10:5601/api/fleet/enrollment-api-keys  |  jq -r  '.list[-1].api_key' ) 

sudo ./elastic-agent install -f --insecure -v --url=https://10.0.2.10:8220 --enrollment-token=$(api-key)