#source

1) wizzy set grafana envs local1 url http://localhost:8081

2) wizzy set grafana envs local1 username admin

3) wizzy set grafana envs local1 password password

4) wizzy set context grafana local1

5) wizzy import dashboards

6) wizzy import datasources


#destination

1) wizzy set grafana envs local2 url http://localhost:8083

2) wizzy set grafana envs local2 username admin

3) wizzy set grafana envs local2 password password

4) wizzy set context grafana local2

5) wizzy export dashboards

6) wizzy export datasources