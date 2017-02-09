#!/bin/bash

project_name="lazypay"
service_name="aerospike"
i=1

list=`dig @10.0.101.4 -p 8600 $service_name.$project_name.service.consul. SRV +short | awk '{print $4}'| sort`

#lazypay-db1.citruspay.com.node.dc1.consul.
#lazypay-db2.citruspay.com.node.dc1.consul.

toset=""
while IFS='.' read -r name remaining ; do
        j=$((${#name}-1))
        cmp=`echo "${name:$j:1}"`
        if [ "$cmp" != "$i" ] ; then
                break;
        fi

        i=`expr $i + 1`
        toset=$name
done <<< "$list"

toset=`echo "${toset::-1}$i"`

echo $toset
