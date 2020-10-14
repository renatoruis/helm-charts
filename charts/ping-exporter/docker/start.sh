kubectl --kubeconfig /kubeconfig-file/kubelet.conf get nodes -o json | \
jq -r '{cluster_targets: [.items[] | { ipAddress: .status.addresses[0].address, name:.metadata.name }], external_targets: "" }' > /app/targets.json


cat <<EOF >> /usr/local/bin/cron-ping
#!/bin/sh
kubectl --kubeconfig /kubeconfig-file/kubelet.conf get nodes -o json | \
jq -r '{cluster_targets: [.items[] | { ipAddress: .status.addresses[0].address, name:.metadata.name }], external_targets: "" }' > /app/targets.json
EOF

chmod +x /usr/local/bin/cron-ping

echo '*  *  *  *  *  /usr/local/bin/cron-ping' > /etc/crontabs/root
crond

python3 /app/ping-exporter.py