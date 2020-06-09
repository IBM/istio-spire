FROM docker.io/istio/proxyv2:1.5.4

COPY envoy_bootstrap_v2.json /var/lib/istio/envoy/envoy_bootstrap_tmpl.json

ENTRYPOINT ["/usr/local/bin/pilot-agent"]
