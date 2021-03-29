#!/bin/bash

terraform init -backend-config="conn_str=postgres://tf_user:jandrew28@192.168.2.213/terraform_backend?sslmode=disable"
