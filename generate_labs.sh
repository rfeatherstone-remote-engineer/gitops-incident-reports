import os

domains = {
    '1': 'domain-1-gitops-k8s-control-plane',
    '2': 'domain-2-aws-cloud-hybrid-networking',
    '3': 'domain-3-iac-terraform-state-conflicts',
    '4': 'domain-4-linux-systems-kernel-tuning',
    '5': 'domain-5-distributed-databases-storage',
    '6': 'domain-6-enterprise-edge-border-routing'
}

scenarios = [
    ('1', 'infinite-reconciliation-loop', 'The Infinite Reconciliation Loop'),
    ('1', 'automated-drift-correction-deletes-state', 'Automated Drift Correction Deletes Production State'),
    ('1', 'kube-api-oom-killed-via-rogue-controller', 'Kube-API Server OOM-Killed via Rogue Controller'),
    ('1', 'webhook-cert-expiration-blunts-deployments', 'Webhook Certificate Expiration Blunts All Deployments'),
    ('1', 'crd-limit-reached-blocking-hydration', 'CRD Limit Reached Blocking Cluster Hydration'),
    ('2', 'asymmetric-routing-aws-site-to-site-vpn', 'Asymmetric Routing Across AWS Site-to-Site VPN'),
    ('2', 'tgw-route-table-quota-exhaustion', 'Transit Gateway Route Table Quota Exhaustion'),
    ('2', 'vpc-endpoint-policy-silent-denials', 'VPC Endpoint Policy Silent Denials'),
    ('2', 'coredns-throttling-route53-resolver-limits', 'CoreDNS Throttling via Route 53 Resolver Limits'),
    ('2', 'nat-gateway-port-exhaustion-traffic-spikes', 'NAT Gateway Port Exhaustion under Sudden Traffic Spikes'),
    ('3', 'phantom-terraform-state-lock', 'The Phantom Terraform State Lock'),
    ('3', 'destruction-of-state-shared-provider-upgrade', 'Destruction of State on Shared Provider Upgrade'),
    ('3', 'local-state-cloud-disconnect-drift', 'Local State and Cloud Disconnect (Drift Out of Band)'),
    ('3', 'data-source-evaluation-failure-disaster-recovery', 'Data Source Evaluation Failure During Disaster Recovery'),
    ('3', 'cyclic-dependencies-cross-module-loops', 'Cyclic Dependencies via Cross-Module Reference Loops'),
    ('4', 'ephemeral-port-exhaustion-high-concurrence-proxies', 'Ephemeral Port Exhaustion on High-Concurrence Proxies'),
    ('4', 'zombie-processes-exhausting-pid-max', 'Zombie Processes Exhausting the Process Table (PID Max)'),
    ('4', 'storage-write-failures-inode-exhaustion', 'Storage Write Failures on an Ample-Space Volume (Inode Exhaustion)'),
    ('5', 'split-brain-isolation-clustering-database', 'Split-Brain Isolation in a Clustering Database'),
    ('5', 'cascade-failure-etcd-distributed-lock-contention', 'Cascade Failure via Etcd Distributed Lock Contention'),
    ('5', 'persistent-volume-mount-failures-stuck-attaching', 'Persistent Volume Mount Failures (Stuck in Attaching State)'),
    ('5', 'iops-starvation-storage-credits-depletion', 'Read/Write IOPS Starvation due to Storage Credits Depletion'),
    ('5', 'replication-lag-headroom-exhaustion-high-write-replica', 'Replication Lag Headroom Exhaustion on High-Write Replica'),
    ('5', 'distributed-object-store-bucket-policy-lockout', 'Distributed Object Store Bucket Policy Cascade Lockout'),
    ('6', 'bgp-route-leaking-public-traffic-blackholing', 'BGP Route Leaking and Public Traffic Blackholing'),
    ('6', 'mtu-mss-black-hole-encrypted-interconnects', 'MTU / MSS Black Hole Over Encrypted Cloud Interconnects'),
    ('6', 'ddos-proxy-false-positives-dropping-legit-api', 'DDoS Protection Proxy False Positives Dropping Legit API Traffic'),
    ('6', 'anycast-routing-imbalance-overwhelming-datacenter', 'Anycast Routing Imbalance Overwhelming a Single Data Center'),
    ('6', 'cors-preflight-failures-post-migration', 'Cross-Origin Resource Sharing (CORS) Preflight Failures Post-Migration'),
    ('6', 'tls-session-resumption-resets-breaking-websockets', 'TLS Session Resumption Resets Breaking State-Bound WebSockets')
]

for idx, (dom_id, kebab, name) in enumerate(scenarios, 1):
    target = os.path.join(domains[dom_id], f'scenario-{idx}-{kebab}')
    fix_dir = os.path.join(target, 'automated-fix')
    os.makedirs(fix_dir, exist_ok=True)
    
    with open(os.path.join(target, 'chaos-break.sh'), 'w') as f:
        f.write('#!/usr/bin/env bash\nset -euo pipefail\necho "Injecting chaos simulation..."\n')
    os.chmod(os.path.join(target, 'chaos-break.sh'), 0o755)
        
    with open(os.path.join(fix_dir, 'remediate.sh'), 'w') as f:
        f.write('#!/usr/bin/env bash\nset -euo pipefail\necho "Running platform remediation..."\n')
    os.chmod(os.path.join(fix_dir, 'remediate.sh'), 0o755)
        
    with open(os.path.join(target, 'watchdog-monitor.sh'), 'w') as f:
        f.write('#!/usr/bin/env bash\nset -euo pipefail\nexit 1\n')
    os.chmod(os.path.join(target, 'watchdog-monitor.sh'), 0o755)
        
    with open(os.path.join(target, 'remediation-runbook.md'), 'w') as f:
        f.write(f'# Runbook: {name}\n\n## Metadata\n* Domain: {domains[dom_id]}\n* Severity: P1\n')

print('🎉 Flawless initialization complete!')
