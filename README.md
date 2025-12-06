# EKS Baseline Chart

Chart transversal base para despliegues estandarizados en Amazon EKS.

## Descripción

Este chart de Helm proporciona una configuración base reutilizable para desplegar aplicaciones en Kubernetes/EKS siguiendo las mejores prácticas de seguridad y escalabilidad.

## Características

- ✅ Deployment con configuración de seguridad robusta
- ✅ Service para exposición interna
- ✅ Ingress opcional para acceso externo
- ✅ ServiceAccount con anotaciones configurables
- ✅ ConfigMap y Secret opcionales
- ✅ HorizontalPodAutoscaler para escalado automático
- ✅ Probes de liveness y readiness configurables
- ✅ Security contexts siguiendo mejores prácticas

## Instalación

### Usando Helm directamente

```bash
helm install my-app ./eks_baseline_chart_Helm \
  --set image.repository=my-registry/my-app \
  --set image.tag=1.0.0
```

### Usando ArgoCD

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/your-org/eks_baseline_chart_Helm
    targetRevision: HEAD
    path: .
    helm:
      valueFiles:
        - values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: my-namespace
```

## Configuración

### Valores Principales

| Parámetro | Descripción | Valor por defecto |
|-----------|-------------|-------------------|
| `replicaCount` | Número de réplicas | `2` |
| `image.repository` | Repositorio de la imagen | `nginx` |
| `image.tag` | Tag de la imagen | `""` (usa appVersion) |
| `image.pullPolicy` | Política de pull de imagen | `IfNotPresent` |
| `service.type` | Tipo de servicio | `ClusterIP` |
| `service.port` | Puerto del servicio | `80` |
| `service.targetPort` | Puerto del contenedor | `8080` |
| `ingress.enabled` | Habilitar ingress | `false` |
| `resources.limits.cpu` | Límite de CPU | `500m` |
| `resources.limits.memory` | Límite de memoria | `512Mi` |
| `autoscaling.enabled` | Habilitar HPA | `false` |

### Ejemplo de values.yaml personalizado

```yaml
replicaCount: 3

image:
  repository: my-registry/my-app
  tag: "v1.2.3"
  pullPolicy: Always

service:
  type: ClusterIP
  port: 80
  targetPort: 3000

ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  hosts:
    - host: my-app.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: my-app-tls
      hosts:
        - my-app.example.com

resources:
  limits:
    cpu: 1000m
    memory: 1Gi
  requests:
    cpu: 250m
    memory: 256Mi

autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70

env:
  - name: ENVIRONMENT
    value: production
  - name: LOG_LEVEL
    value: info

configMap:
  enabled: true
  data:
    APP_CONFIG: |
      {
        "feature": "enabled"
      }
```

## Seguridad

El chart incluye configuraciones de seguridad siguiendo las mejores prácticas:

- **Pod Security Context**: Ejecuta como usuario no-root (UID 1000)
- **Container Security Context**: 
  - No permite escalado de privilegios
  - Elimina todas las capabilities
  - Filesystem de solo lectura
- **ServiceAccount**: Crea una cuenta de servicio dedicada por aplicación

## Versionado

Este chart sigue [Semantic Versioning](https://semver.org/):

- **MAJOR**: Cambios incompatibles en la API
- **MINOR**: Nuevas funcionalidades compatibles hacia atrás
- **PATCH**: Correcciones de bugs compatibles hacia atrás

## Changelog

Ver [CHANGELOG.md](./CHANGELOG.md) para el historial de cambios.

## Mantenimiento

Mantenido por el Platform Team.

Para reportar issues o contribuir, por favor contacta al equipo de plataforma.

## Licencia

Uso interno de la organización.
