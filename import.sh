#!/bin/bash

echo "importing data from source"
wizzy set grafana envs local1 url http://localhost:8081

wizzy set grafana envs local1 username admin

wizzy set grafana envs local1 password password

echo "successfully connected to source"

wizzy set context grafana local1

wizzy import dashboards

echo "dashboard imported"

wizzy import datasources

echo "datasource imported"


#destination

echo "exporting data to destination"

wizzy set grafana envs local2 url http://localhost:8083

wizzy set grafana envs local2 username admin

wizzy set grafana envs local2 password password

echo "successfully connected to destination"

wizzy set context grafana local2

wizzy export dashboards

echo "dashboards exported"

wizzy export datasources

echo "datasources exported"

echo "job finished ----- check result at http://localhost:8083"