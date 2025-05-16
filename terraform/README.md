# 🛠️ Terraform ile GKE Altyapı Kurulumu

Bu klasör, **Google Kubernetes Engine (GKE)** altyapısını **Infrastructure as Code (IaC)** prensibiyle kurmak amacıyla hazırlanmış **Terraform** konfigürasyonlarını içerir. GKE üzerinde bir Kubernetes cluster ve 2 farklı node pool bu yapı ile oluşturulmaktadır.

---

## 📄 Dosya Açıklamaları

| Dosya              | Açıklama                                                                 |
|--------------------|--------------------------------------------------------------------------|
| `main.tf`          | GKE cluster ve node pool’ların kaynak tanımlarını içerir.               |
| `provider.tf`      | GCP sağlayıcısını ve kimlik doğrulama ayarlarını tanımlar.              |
| `variables.tf`     | Tüm değişkenlerin isimlerini, tiplerini ve açıklamalarını içerir.       |
| `terraform.tfvars` | Değişkenlerin gerçek değerlerini tanımlar. (region, project_id, vs.)     |

---

## ⚙️ Kurulum Adımları

### 1. GCP Kimlik Doğrulaması

GCP hesabınızla kimlik doğrulaması yaptığınızdan emin olun:

```bash
gcloud auth application-default login
```

### 2. Terraform Komutları

```bash
cd terraform/

# Terraform bileşenlerini başlat
terraform init

# Değişiklikleri gözden geçir
terraform plan

# Altyapıyı oluştur
terraform apply
```

> Not: `terraform.tfvars` dosyasında aşağıdaki temel değişkenleri sağlamalısınız:
> - `project_id`
> - `region`
> - `cluster_name`

---

## ☁️ Oluşturulan Kaynaklar

- **GKE Cluster**
  - Monitoring: ❌
  - Logging: ❌
  - Lokasyon: `europe-west1`
- **Node Pool: main-pool**
  - Makine tipi: `n2d-standard`
  - Autoscaling: ❌
- **Node Pool: application-pool**
  - Makine tipi: `n2d-standard`
  - Autoscaling: ✅ (min: 1, max: 3)
  - Etiket: `role=app`

---

## 🔐 Güvenlik & Notlar

- IAM yetkilerinizin GKE oluşturmak için yeterli olduğundan emin olun.
- Cluster, `default` VPC ve subnet kullanacak şekilde tanımlanmıştır.
- Gerekirse özel ağ yapısı veya ek IAM tanımlamalarıyla genişletilebilir.
