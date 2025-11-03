# 🚀 SRE Reliability Lab — Built in One Weekend (with a Little Help from AI 🤖)

This project is a **hands-on Site Reliability Engineering (SRE) lab** that demonstrates how to design, provision, and observe a cloud-native system end-to-end.

It combines **Terraform**, **Docker**, **Prometheus**, and **Grafana** to showcase the key pillars of modern reliability engineering — **automation**, **observability**, and **resilience**.

> **Live project link:** [github.com/sa1if3/sre-reliability-lab](https://github.com/sa1if3/sre-reliability-lab)

---

## 🧩 Architecture Overview

A simple but powerful setup:
- **Terraform** provisions AWS EC2, Security Groups, and networking.
- **User data** bootstraps Docker and automatically starts containers.
- **Docker Compose** orchestrates:
  - Flask application (instrumented with Prometheus metrics)
  - Prometheus (metrics collection)
  - Grafana (visualization)
- **AI-assisted development** for architecture validation, troubleshooting, and documentation.

```text
Terraform → AWS EC2 → Docker Compose → Flask App → Prometheus → Grafana
```

---

## 🏗️ Stack Components

| Layer | Tool | Purpose |
|-------|------|----------|
| Infrastructure | Terraform | Infrastructure as Code for AWS |
| Application | Flask | Simulated web service with /metrics endpoint |
| Monitoring | Prometheus | Scrapes metrics from Flask |
| Visualization | Grafana | Dashboards for latency and throughput |
| Automation | GitHub Actions | CI/CD hooks for future deployment |
| AI Support | ChatGPT (OpenAI) | Design & troubleshooting co-pilot |

---

## ⚙️ Quick Setup Guide

### **1️⃣ Prerequisites**
- AWS account (Free Tier)
- Terraform installed locally
- AWS CLI configured (`aws configure`)
- Docker & Docker Compose installed
- SSH keypair for EC2

---

### **2️⃣ Deploy Infrastructure**
```bash
cd infra
terraform init
terraform plan -var="key_name=YOUR_KEYPAIR"
terraform apply -auto-approve -var="key_name=YOUR_KEYPAIR"
```

Terraform will output your EC2 instance’s **public IP**:
```bash
Outputs:
public_ip = "3.xx.xx.xx"
```

---

### **3️⃣ Verify Services**
After ~2 minutes, open in browser:

| Service | URL |
|----------|-----|
| Flask App | http://<public_ip>:5000/ |
| Health Check | http://<public_ip>:5000/health |
| Prometheus | http://<public_ip>:9090/ |
| Grafana | http://<public_ip>:3000/ (admin / admin) |

---

### **4️⃣ Generate Load**
To simulate traffic (PowerShell):
```powershell
1..200 | ForEach-Object { Invoke-WebRequest -Uri "http://<public_ip>:5000/" -UseBasicParsing | Out-Null }
```

or in Bash:
```bash
for i in {1..200}; do curl -s http://<public_ip>:5000/ >/dev/null; done
```

Then check metrics in Prometheus:
```
rate(app_requests_total[1m])
histogram_quantile(0.95, sum(rate(app_request_latency_seconds_bucket[5m])) by (le))
```

---

### **5️⃣ Cleanup**
When done, destroy resources:
```bash
cd infra
terraform destroy -auto-approve
```

---

## 📊 Example Grafana Metrics
- **Request Rate** → `rate(app_requests_total[1m])`
- **p95 Latency** → `histogram_quantile(0.95, sum(rate(app_request_latency_seconds_bucket[5m])) by (le))`
- **Uptime / Health** via `/health` endpoint

---

## 🤖 AI-Driven Development
This project was accelerated using AI for:
- Infrastructure design validation  
- Troubleshooting Terraform and Docker  
- Generating clean documentation and runbooks  
- Automating repetitive setup steps  

AI didn’t replace engineering — it **amplified** it.

---

## 🌱 Next Steps
- Add **Alertmanager + Slack integration**
- Extend to multi-node setup
- Automate build pipeline with GitHub Actions

---

## 🧠 Key Learnings
- End-to-end visibility across system layers
- Infrastructure as Code (Terraform)
- Metrics-based reliability engineering
- Combining AI + DevOps for real productivity

---

### 🏷️ Tags
`#SRE` `#DevOps` `#Terraform` `#AWS` `#Prometheus` `#Grafana` `#Observability` `#Automation` `#AI` `#ReliabilityEngineering`

---