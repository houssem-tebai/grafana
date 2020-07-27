FROM grafana/grafana:master-ubuntu

COPY dashboards/*.json /var/lib/grafana/dashboards/
COPY dashboards/*.yaml /etc/grafana/provisioning/dashboards/
COPY datasources/*.yaml  /etc/grafana/provisioning/datasources/

ENTRYPOINT [ "/run.sh" ]