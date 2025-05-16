# Istio Gateway & VirtualService Setup

Bu klasör, GKE üzerindeki uygulamalara dış erişim sağlamak için kullanılan **Istio Gateway** ve **VirtualService** manifest dosyalarını içerir.

## 🚧 CNI Hatası Notu

Istio kurulumu sırasında `helm install istio` komutunda **CNI (Container Network Interface)** hatası alınabiliyor. Bu hatayı önlemek için `values.yaml` dosyasında aşağıdaki şekilde `cni.enabled=false` yapılmalıdır:

```yaml
cni:
  enabled: false
```

Bu değerle birlikte Helm kurulumu şu şekilde yapılır:

```bash
helm install istio istio/istio -n istio-system -f values.yaml
```

## 📁 Dosyalar ve Görevleri

### `gateway.yaml`

- Istio Gateway kaynağıdır.
- Port 80 üzerinden gelen HTTP trafiğini kabul eder.
- `istio: ingressgateway` selector’ü ile Istio ingress pod’larına yönlendirilir.

### `nginx-virtualservices.yaml`

- ClusterIP türüne sahip bir service için ingressRoute ayarlaması yapabiliriz.
- Gateway üzerinden gelen istekleri `nginx-service` adlı servise yönlendirir.
- `/` adresine gelen istekleri `/nginx`'e yönlendirir (**redirect**).
- `/nginx` adresine gelen istekleri nginx pod’una iletir (**rewrite / → nginx root**).

## 🌐 Erişim

Kurulumdan sonra tarayıcıda aşağıdaki gibi erişim sağlanabilir:

- `http://<EXTERNAL-IP>/` → otomatik olarak `/nginx`’e yönlendirilir → nginx sayfası görünür.
- `http://<EXTERNAL-IP>/nginx` → doğrudan nginx'e gider.

`EXTERNAL-IP`'i öğrenmek için:

```bash
kubectl get svc istio-ingressgateway -n istio-system
```

---

✅ Bu yapı sayesinde GKE ortamındaki nginx servisine dışarıdan IP ile erişim sağlanır.
