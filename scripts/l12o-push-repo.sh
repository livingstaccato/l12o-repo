#!/bin/bash

# Make sure the endpoint_url is set in your AWS CLI config file.

aws s3 sync --delete repo/ s3://repo-l12o-com/
