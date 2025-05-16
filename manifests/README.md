# 📂 manifests

Bu klasör, Kubernetes cluster'ınız üzerinde çalışacak olan uygulama bileşenlerinin YAML manifest dosyalarını içerir. Uygulama dağıtımı, autoscaling (HPA ve KEDA), izleme (monitoring) ve servis mesh (Istio) gibi temel bileşenleri kapsar.

---

## 📄 nginx-deployment.yaml

NGINX web sunucusunu çalıştıran bir `Deployment` ve bu deployment için erişim sağlayan bir `Service` objesi içerir.

### Deployment Özellikleri:
- **Adı:** `nginx-app`
- **Replica Sayısı:** 1
- **Node Affinity:** Yalnızca `role=app` etiketine sahip node'larda çalışır (application-pool).
- **Container:** `nginx` imajı, 80 portu açılır.
- **Resource Requests:** `cpu: 100m`

### Service Özellikleri:
- **Adı:** `nginx-service`
- **Tür:** `ClusterIP`
- **Port:** 80 (TCP)

---

## 📄 nginx-hpa.yaml

Kubernetes native HPA (HorizontalPodAutoscaler) tanımı. CPU kullanımına göre `nginx-app` deployment’ını otomatik ölçekler.

### Özellikler:
- **Hedef Deployment:** `nginx-app`
- **Minimum Pod Sayısı:** 1
- **Maksimum Pod Sayısı:** 3
- **Trigger:** CPU kullanımı %25 üzerindeyse ölçekleme yapılır.
- **API Versiyonu:** `autoscaling/v2`

---

## 📄 nginx-keda.yaml

KEDA (Kubernetes Event-Driven Autoscaler) kullanılarak aynı deployment için autoscaling sağlar. HPA alternatifi olarak event tabanlı daha esnek bir yapı sunar.

### Özellikler:
- **Tür:** `ScaledObject`
- **Hedef Deployment:** `nginx-app`
- **Minimum Pod:** 1
- **Maksimum Pod:** 3
- **Trigger:** CPU kullanımı %25’in üzerine çıkarsa ölçeklenir.
- **Kullanım Notu:** `nginx-hpa.yaml` ile birlikte kullanılmamalıdır.

---

## 📁 Alt Klasörler

### 📁 monitoring/

Prometheus ve Grafana gibi monitoring bileşenlerinin kurulumuna yönelik manifest veya Helm values dosyalarını içerir.

### 📁 istio_yamls/

Istio servis mesh kurulumu için gerekli olan manifest dosyaları (örneğin: Gateway, VirtualService) burada yer alır.

---

## 📌 Notlar

- Bu klasördeki YAML dosyaları doğrudan `kubectl apply -f` komutu ile uygulanabilir.
- HPA ve KEDA birlikte uygulanmamalıdır. Tercihinize göre birini seçin.
- Affinity kuralları sayesinde `nginx` uygulaması yalnızca `application-pool` üzerinde çalışır.

---

🛠 Örnek Uygulama:

```bash
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-hpa.yaml         # veya
kubectl apply -f nginx-keda.yaml
