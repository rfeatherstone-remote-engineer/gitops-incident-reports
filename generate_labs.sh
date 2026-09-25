#!/usr/bin/env bash
# ==============================================================================
# Script Name:  generate_labs.sh
# Description:  Automated scaffold generator for 30 high-impact Cloud & Network
#               Engineering troubleshooting simulation lab environments.
# ==============================================================================

set -euo pipefail

# 1. Define the 6 main Domain directories
declare -A DOMAIN_MAP
DOMAIN_MAP[1]="domain-1-gitops-k8s-control-plane"
DOMAIN_MAP[2]="domain-2-aws-cloud-hybrid-networking"
DOMAIN_MAP[3]="domain-3-iac-terraform-state-conflicts"
DOMAIN_MAP[4]="domain-4-linux-systems-kernel-tuning"
DOMAIN_MAP[5]="domain-5-distributed-databases-storage"
DOMAIN_MAP[6]="domain-6-enterprise-edge-border-routing"

# 2. Map scenario IDs to metadata
# Format: [id]="domain_id|kebab-case-title|Human Readable Title"
declare -A SCENARIOS
SCENARIOS[1]="1|infinite-reconciliation-loop|The Infinite Reconciliation Loop"
SCENARIOS[2]="1|automated-drift-correction-deletes-state|Automated Drift Correction Deletes Production State"
SCENARIOS[3]="1|kube-api-oom-killed-via-rogue-controller|Kube-API Server OOM-Killed via Rogue Controller"
SCENARIOS[4]="1|webhook-cert-expiration-blunts-deployments|Webhook Certificate Expiration Blunts All Deployments"
SCENARIOS[5]="1|crd-limit-reached-blocking-hydration|CRD Limit Reached Blocking Cluster Hydration"
SCENARIOS[6]="2|asymmetric-routing-aws-site-to-site-vpn|Asymmetric Routing Across AWS Site-to-Site VPN"
SCENARIOS[7]="2|tgw-route-table-quota-exhaustion|Transit Gateway Route Table Quota Exhaustion"
SCENARIOS[8]="2|vpc-endpoint-policy-silent-denials|VPC Endpoint Policy Silent Denials"
SCENARIOS[9]="2|coredns-throttling-route53-resolver-limits|CoreDNS Throttling via Route 53 Resolver Limits"
SCENARIOS[10]="2|nat-gateway-port-exhaustion-traffic-spikes|NAT Gateway Port Exhaustion under Sudden Traffic Spikes"
SCENARIOS[11]="3|phantom-terraform-state-lock|The Phantom Terraform State Lock"
SCENARIOS[12]="3|destruction-of-state-shared-provider-upgrade|Destruction of State on Shared Provider Upgrade"
SCENARIOS[13]="3|local-state-cloud-disconnect-drift|Local State and Cloud Disconnect (Drift Out of Band)"
SCENARIOS[14]="3|data-source-evaluation-failure-disaster-recovery|Data Source Evaluation Failure During Disaster Recovery"
SCENARIOS[15]="3|cyclic-dependencies-cross-module-loops|Cyclic Dependencies via Cross-Module Reference Loops"
SCENARIOS[16]="4|ephemeral-port-exhaustion-high-concurrence-proxies|Ephemeral Port Exhaustion on High-Concurrence Proxies"
SCENARIOS[17]="4|zombie-processes-exhausting-pid-max|Zombie Processes Exhausting the Process Table (PID Max)"
SCENARIOS[18]="4|storage-write-failures-inode-exhaustion|Storage Write Failures on an Ample-Space Volume (Inode Exhaustion)"
SCENARIOS[19]="5|split-brain-isolation-clustering-database|Split-Brain Isolation in a Clustering Database"
SCENARIOS[20]="5|cascade-failure-etcd-distributed-lock-contention|Cascade Failure via Etcd Distributed Lock Contention"
SCENARIOS[21]="5|persistent-volume-mount-failures-stuck-attaching|Persistent Volume Mount Failures (Stuck in Attaching State)"
SCENARIOS[22]="5|iops-starvation-storage-credits-depletion|Read/Write IOPS Starvation due to Storage Credits Depletion"
SCENARIOS[23]="5|replication-lag-headroom-exhaustion-high-write-replica|Replication Lag Headroom Exhaustion on High-Write Replica"
SCENARIOS[24]="5|distributed-object-store-bucket-policy-lockout|Distributed Object Store Bucket Policy Cascade Lockout"
SCENARIOS[25]="6|bgp-route-leaking-public-traffic-blackholing|BGP Route Leaking and Public Traffic Blackholing"
SCENARIOS[26]="6|mtu-mss-black-hole-encrypted-interconnects|MTU / MSS Black Hole Over Encrypted Cloud Interconnects"
SCENARIOS[27]="6|ddos-proxy-false-positives-dropping-legit-api|DDoS Protection Proxy False Positives Dropping Legit API Traffic"
SCENARIOS[28]="6|anycast-routing-imbalance-overwhelming-datacenter|Anycast Routing Imbalance Overwhelming a Single Data Center"
SCENARIOS[29]="6|cors-preflight-failures-post-migration|Cross-Origin Resource Sharing (CORS) Preflight Failures Post-Migration"
SCENARIOS[30]="6|tls-session-resumption-resets-breaking-websockets|TLS Session Resumption Resets Breaking State-Bound WebSockets"

echo "🚀 Starting automated lab environment generation across 6 infrastructure domains..."

for id in {1..30}; do
    metadata="\({SCENARIOS[\)id]}"
    
    IFS="|" read -r domain_id kebab_title human_title <<< "\$metadata"
    
    domain_dir="\({DOMAIN_MAP[\)domain_id]}"
    target_dir="\${domain_dir}/scenario-id-{kebab_title}"
    
    echo "Creating directory layout for Scenario \({id}: [\){human_title}]"
    
    # Create target directories safely
    mkdir -p "\${target_dir}/automated-fix"
    
    # 1. Generate chaos-break.sh
    cat << 'EOF' > "\${target_dir}/chaos-break.sh"
#!/usr/bin/env bash
set -euo pipefail
echo "Injecting chaos for simulated incident scenario..."
EOF
    chmod +x "\${target_dir}/chaos-break.sh"
    
    # 2. Generate remediate.sh
    cat << 'EOF' > "\${target_dir}/automated-fix/remediate.sh"
#!/usr/bin/env bash
set -euo pipefail
echo "Executing emergency infrastructure reconciliation and state recovery..."
EOF
    chmod +x "\${target_dir}/automated-fix/remediate.sh"
    
    # 3. Generate watchdog-monitor.sh
    cat << 'EOF' > "\${target_dir}/watchdog-monitor.sh"
#!/usr/bin/env bash
set -euo pipefail
echo "Running platform metrics probe and diagnostic loops..."
exit 1
EOF
    chmod +x "\${target_dir}/watchdog-monitor.sh"
    
    # 4. Generate remediation-runbook.md
    cat << EOF > "\${target_dir}/remediation-runbook.md"
# On-Call Incident Runbook: Scenario id — {human_title}

## 🚨 Incident Metadata
* **Domain:** \${domain_dir}
* **Severity:** P1 - Critical Outage

## 🔍 Diagnostic Checklist
1. Run monitoring evaluation script to isolate active error status:
   \`./watchdog-monitor.sh\`
2. Check internal process state structures or active platform configurations.

## 🛠️ Mitigation Steps
Execute the corresponding remediation playbook:
   \`./automated-fix/remediate.sh\`
EOF

done

echo "🎉 Successfully initialized all 30 clean scenario frameworks!"
