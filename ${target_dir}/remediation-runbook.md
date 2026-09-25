# On-Call Incident Runbook: Scenario id — {human_title}

## 🚨 Incident Metadata
* **Domain:** ${domain_dir}
* **Severity:** P1 - Critical Outage

## 🔍 Diagnostic Checklist
1. Run monitoring evaluation script to isolate active error status:
   `./watchdog-monitor.sh`
2. Check internal process state structures or active platform configurations.

## 🛠️ Mitigation Steps
Execute the corresponding remediation playbook:
   `./automated-fix/remediate.sh`
