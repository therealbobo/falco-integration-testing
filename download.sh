#!/bin/bash

PREFIX=$(aws s3api list-objects-v2 --bucket falco-distribution --region eu-west-1 --prefix 'packages/deb-dev/stable/' --no-sign-request | \
	jq -r '[.[][] | select(.Key|endswith("x86_64.deb")) ] | max_by(.LastModified)|.Key')

echo $PREFIX

echo aws s3api get-object --bucket falco-distribution --no-sign-request --key $PREFIX falco.deb
aws s3api get-object --bucket falco-distribution --no-sign-request --region eu-west-1 --key "$PREFIX" falco.deb
