# 🚀 Enuygun Case Study – GKE Üzerinde Uygulama ve DevOps Otomasyonu

Bu proje, GCP (Google Cloud Platform) üzerinde **Infrastructure as Code (IaC)** yaklaşımıyla bir Kubernetes ortamı kurmayı, uygulama deploy etmeyi ve DevOps bileşenlerini (HPA, Monitoring, KEDA, Istio vs.) entegre etmeyi amaçlamaktadır.

---

## 📌 Hedefler ve Kapsam

✅ GCP üzerinde `europe-west1` bölgesinde GKE (Google Kubernetes Engine) cluster kurulumu  
✅ 2 farklı node pool (main-pool & application-pool) yapılandırması  
✅ Uygulama deployment ve sadece belirli node pool üzerinde çalıştırma  
✅ HPA (Horizontal Pod Autoscaler) kurulumu  
✅ Prometheus & Grafana kurulumu, Kubernetes metriklerinin toplanması  
✅ Pod restart alarmının Grafana üzerinden tanımlanması  
✅ KEDA kurulumu ve CPU-based autoscaling örneği  
✅ Istio kurulumu (istiod, ingress, egress) ve servis yönlendirmeleri  

---

## 📁 Klasör Yapısı

```
.
├── terraform/              # GKE altyapısını oluşturan Terraform dosyaları
│   └── README.md           
├── manifests/              # Kubernetes manifest dosyaları
│   ├── nginx-deployment.yaml
│   ├── nginx-hpa.yaml
│   ├── keda-scaledobject.yaml
│   ├── monitoring/         # Prometheus & Grafana kurulum yamlları
│   └── istio_yamls/        # Istio manifest dosyaları
└── README.md               
```

---

## 🔧 Kullanılan Araçlar ve Teknolojiler

- Google Cloud Platform (GCP)
- Google Kubernetes Engine (GKE)
- Terraform
- Kubernetes YAML Manifestleri
- Prometheus & Grafana
- KEDA (Kubernetes-based Event Driven Autoscaler)
- Istio (Service Mesh)

## 🔐 Uzaktan Erişim

´terraform apply´ komutu başarılı olup cluster ve kaynaklar oluşturulduktan sonra 

gcloud container clusters get-credentials <cluster-adı> --region <bölge> --project <proje-id>

komutu ile kubectl yüklü ortamınızdan bu ortama uzaktan erişim sağlayabilirsiniz.

