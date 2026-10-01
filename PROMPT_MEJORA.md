# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `microservices/service-a/templates/deployment.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `microservices/service-a/values.yaml`
- `microservices/service-a/templates/deployment.yaml`
- `monitoring/prometheus/values.yaml`
- `monitoring/grafana/values.yaml`
- `monitoring/grafana/dashboards/microservices-dashboard.json`

## Como saber que terminaste

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Contexto técnico original
Diseñar y desplegar una plataforma de microservicios con Kubernetes, Helm, GitOps con ArgoCD y monitoreo con Prometheus y Grafana

### Reto
- Tema: kubernetes-devops
- Seniority: junior-l2
- Tipo: practical
- Título: Despliegue de una plataforma de microservicios con Kubernetes
- Tiempo estimado: 2 semanas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Kubernetes — objetivo: Configurar un clúster de Kubernetes y desplegar un microservicio básico. — entregable (NO resolver): Clúster de Kubernetes configurado y microservicio básico desplegado.
- Fase 2: Implementación de GitOps con ArgoCD — objetivo: Configurar ArgoCD para gestionar el despliegue de microservicios de manera automatizada. — entregable (NO resolver): Configuración de ArgoCD para el despliegue automatizado de microservicios.
- Fase 3: Configuración de monitoreo con Prometheus y Grafana — objetivo: Configurar Prometheus y Grafana para monitorear la plataforma de microservicios. — entregable (NO resolver): Configuración de Prometheus y Grafana para el monitoreo de la plataforma de microservicios.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: providers.tf ===
# Proveedores de Terraform para gestionar infraestructura en Kubernetes y Helm
# Esta configuración es fundamental para que Terraform pueda interactuar con
# Kubernetes, Helm y otros servicios necesarios para el despliegue.

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
    argocd = {
      source  = "oboukili/argocd"
      version = "~> 6.0.3"
    }
  }
}

# Configuración del proveedor Kubernetes
# Permite a Terraform interactuar con el clúster de Kubernetes.
# Los valores sensibles como el token y el certificado se inyectan
# mediante variables para mantener la seguridad.
provider "kubernetes" {
  host                   = var.kubernetes_host
  token                  = var.kubernetes_token
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)
  insecure               = false
}

# Configuración del proveedor Helm
# Necesario para gestionar charts de Helm dentro de Terraform.
provider "helm" {
  kubernetes {
    host                   = var.kubernetes_host
    token                  = var.kubernetes_token
    cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)
  }
}

# Configuración del proveedor Kubectl
# Facilita la aplicación de manifiestos de Kubernetes directamente desde Terraform.
provider "kubectl" {
  host                   = var.kubernetes_host
  token                  = var.kubernetes_token
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)
  load_config_file       = false
}

# Configuración del proveedor ArgoCD
# Permite gestionar ArgoCD desde Terraform, incluyendo la creación de aplicaciones y proyectos.
provider "argocd" {
  server_addr = var.argocd_server_addr
  username    = var.argocd_username
  password    = var.argocd_password
  insecure    = false
  grpc_web    = true
}

// === ARCHIVO: variables.tf ===
# Variables de Terraform para parametrizar la configuración
# Estas variables permiten personalizar el despliegue sin modificar el código,
# facilitando la reutilización en diferentes entornos.

# Variables para la conexión con el clúster de Kubernetes
variable "kubernetes_host" {
  description = "URL del servidor API de Kubernetes"
  type        = string
}

variable "kubernetes_token" {
  description = "Token de autenticación para acceder al clúster de Kubernetes"
  type        = string
  sensitive   = true
}

variable "kubernetes_cluster_ca_certificate" {
  description = "Certificado CA del clúster de Kubernetes en formato base64"
  type        = string
}

# Variables para la conexión con ArgoCD
variable "argocd_server_addr" {
  description = "Dirección del servidor ArgoCD"
  type        = string
}

variable "argocd_username" {
  description = "Nombre de usuario para autenticarse en ArgoCD"
  type        = string
  default     = "admin"
}

variable "argocd_password" {
  description = "Contraseña para autenticarse en ArgoCD"
  type        = string
  sensitive   = true
}

# Variables para la configuración de namespaces
variable "namespaces" {
  description = "Lista de namespaces a crear en el clúster de Kubernetes"
  type = list(object({
    name        = string
    annotations = optional(map(string))
    labels      = optional(map(string))
  }))
  default = [
    {
      name = "fintech"
      labels = {
        environment = "dev"
      }
    }
  ]
}

# Variables para la configuración de Helm releases
variable "helm_releases" {
  description = "Lista de releases de Helm a desplegar"
  type = list(object({
    name       = string
    repository = string
    chart      = string
    version    = string
    namespace  = string
    values     = map(any)
  }))
  default = [
    {
      name       = "prometheus"
      repository = "https://prometheus-community.github.io/helm-charts"
      chart      = "kube-prometheus-stack"
      version    = "51.2.0"
      namespace  = "monitoring"
      values     = {}
    },
    {
      name       = "argocd"
      repository = "https://argoproj.github.io/argo-helm"
      chart      = "argo-cd"
      version    = "5.46.7"
      namespace  = "argocd"
      values     = {}
    }
  ]
}

# Variables para la configuración de servicios
variable "microservices" {
  description = "Lista de microservicios a desplegar"
  type = list(object({
    name          = string
    namespace     = string
    chart_path    = string
    values_path   = string
    target_revision = string
  }))
  default = [
    {
      name            = "service-a"
      namespace       = "fintech"
      chart_path      = "./microservices/service-a"
      values_path     = "./microservices/service-a/values.yaml"
      target_revision = "main"
    }
  ]
}

# Variables para el monitoreo
variable "monitoring_enabled" {
  description = "Indica si el monitoreo con Prometheus y Grafana está habilitado"
  type        = bool
  default     = true
}

variable "grafana_dashboards" {
  description = "Lista de dashboards de Grafana a desplegar"
  type = list(object({
    name     = string
    path     = string
    namespace = string
  }))
  default = [
    {
      name     = "microservices-dashboard"
      path     = "./monitoring/grafana/dashboards/microservices-dashboard.json"
      namespace = "monitoring"
    }
  ]
}

// === ARCHIVO: main.tf ===
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "dev-cluster"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "dev-cluster"
  }
}

resource "kubernetes_namespace" "fintech" {
  metadata {
    name = "fintech"
    labels = {
      environment = "development"
      managed-by  = "terraform"
    }
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
    labels = {
      environment = "development"
      managed-by  = "terraform"
    }
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
    labels = {
      environment = "development"
      managed-by  = "terraform"
    }
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.45.0"
  namespace  = "argocd"
  create_namespace = true

  values = [<<-EOT
    server:
      service:
        type: ClusterIP
    repoServer:
      replicaCount: 1
    applicationSet:
      enabled: true
    notifications:
      enabled: false
    EOT
  ]

  depends_on = [kubernetes_namespace.argocd]
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "51.2.0"
  namespace  = "monitoring"
  create_namespace = true

  values = [<<-EOT
    prometheus:
      prometheusSpec:
        retention: 15d
        retentionSize: 50GB
        replicas: 2
        replicaExternalURLName: prometheus
    alertmanager:
      enabled: true
      alertmanagerSpec:
        replicas: 2
    grafana:
      enabled: true
      persistence:
        enabled: true
        size: 10Gi
    EOT
  ]

  depends_on = [kubernetes_namespace.monitoring]
}

resource "kubernetes_config_map" "argocd-project" {
  metadata {
    name      = "fintech-project-config"
    namespace = "argocd"
    labels = {
      app.kubernetes.io/name = "argocd-projects"
    }
  }

  data = {
    "project.yaml" = <<-EOT
      apiVersion: argoproj.io/v1alpha1
      kind: AppProject
      metadata:
        name: fintech
        namespace: argocd
      spec:
        description: Fintech Microservices Project
        sourceRepos:
          - '*'
        destinations:
          - namespace: fintech
            server: https://kubernetes.default.svc
          - namespace: monitoring
            server: https://kubernetes.default.svc
        roles:
          - name: admin
            groups:
              - fintech-admins
            policies:
              - p, role:admin, *, *, *, allow
          - name: developer
            groups:
              - fintech-developers
            policies:
              - p, role:developer, *, get, *, allow
              - p, role:developer, *, sync, *, allow
    EOT
  }

  depends_on = [helm_release.argocd]
}

output "argocd_url" {
  description = "URL de acceso a ArgoCD"
  value       = "http://argocd-server.argocd.svc.cluster.local"
}

output "prometheus_url" {
  description = "URL de acceso a Prometheus"
  value       = "http://prometheus.monitoring.svc.cluster.local:9090"
}

output "grafana_url" {
  description = "URL de acceso a Grafana"
  value       = "http://grafana.monitoring.svc.cluster.local:3000"
}

// === ARCHIVO: README.md ===
# Plataforma de Microservicios - Kubernetes DevOps

## Descripción del Proyecto

Plataforma de microservicios para empresa fintech desplegada en Kubernetes con GitOps mediante ArgoCD y monitoreo integral con Prometheus y Grafana.

## Requisitos Previos

- Kubernetes 1.28+ (kind, minikube o cluster cloud)
- Terraform >= 1.5.0
- Helm 3.14.0+
- kubectl configurado
- Docker (para kind si se usa cluster local)

## Estructura del Proyecto

```
.
├── main.tf                    # Configuración principal de Terraform
├── providers.tf               # Definición de providers (generado en paralelo)
├── variables.tf               # Variables de configuración (generado en paralelo)
├── clusters/
│   └── dev-cluster.yaml       # Configuración del cluster de desarrollo
├── namespaces/
│   └── fintech.yaml           # Definición de namespaces (generado en paralelo)
├── microservices/
│   └── service-a/             # Helm chart del microservicio A
├── argocd/
│   ├── applications/          # Aplicaciones ArgoCD
│   └── projects/              # Proyectos ArgoCD
├── monitoring/
│   ├── prometheus/            # Configuración de Prometheus
│   └── grafana/               # Dashboards de Grafana
└── scripts/
    └── deploy.sh              # Script de despliegue
```

## Configuración Inicial

### 1. Crear Cluster de Desarrollo

```bash
# Usando kind
kind create cluster --name fintech-dev --config clusters/dev-cluster.yaml

# O usando minikube
minikube start --kubernetes-version=1.28.0
```

### 2. Inicializar Terraform

```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

### 3. Obtener Credenciales de ArgoCD

```bash
# Obtener password inicial
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Acceder al UI
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### 4. Acceder a Prometheus y Grafana

```bash
# Prometheus
kubectl port-forward svc/prometheus-kube-prometheus-stack -n monitoring 9090:9090

# Grafana (password por defecto: admin/prom-operator)
kubectl port-forward svc/grafana -n monitoring 3000:3000
```

## Despliegue de Microservicios

### Método 1: Mediante ArgoCD (GitOps)

Los microservicios se despliegan automáticamente cuando se confirman cambios en el repositorio Git.

```bash
# Sincronizar aplicaciones
argocd app sync fintech
```

### Método 2: Mediante Helm Directo

```bash
cd microservices/service-a
helm install service-a . -n fintech
```

## Métricas y Monitoreo

### Dashboards Disponibles

- **Microservices Overview**: Vista general de todos los microservicios
- **Kubernetes Cluster**: Estado del cluster y recursos
- **Application Performance**: Tiempos de respuesta y throughput

### Alertas Configuradas

- Alta tasa de errores (5xx)
- Latencia elevada (>500ms p95)
- Alta utilización de CPU (>80%)
- Memoria baja disponible (<20%)

## Variables de Entorno

| Variable | Descripción | Valor por Defecto |
|----------|-------------|-------------------|
| ENVIRONMENT | Entorno de despliegue | dev |
| LOG_LEVEL | Nivel de logging | info |
| REPLICA_COUNT | Número de réplicas | 3 |
| MAX_REPLICAS | Réplicas máximas para HPA | 10 |
| TARGET_CPU_UTILIZATION | Umbral CPU para HPA | 70 |

## Troubleshooting

### Verificar Estado de Pods

```bash
kubectl get pods -n fintech
kubectl describe pod <pod-name> -n fintech
```

### Verificar Logs

```bash
kubectl logs -n fintech -l app=service-a
```

### Reiniciar Despliegue

```bash
kubectl rollout restart deployment/service-a -n fintech
```

### Verificar Recursos de ArgoCD

```bash
argocd app get fintech
argocd app history fintech
```

## Métricas de Rendimiento Objetivo

- **Throughput**: 5000 solicitudes por segundo
- **Latencia promedio**: 200ms
- **Disponibilidad**: 99.9%
- **Tiempo de recuperación**: < 5 minutos

## Líneas Base de Métricas

```promql
# Requests por segundo
rate(http_requests_total[5m])

# Latencia p95
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))

# Tasa de errores
rate(http_requests_errors_total[5m]) / rate(http_requests_total[5m])
```

## Mantenimiento

### Actualizar Versión de Microservicio

1. Modificar `microservices/service-a/Chart.yaml`
2. Actualizar `image.tag` en `values.yaml`
3. Commit y push a Git
4. ArgoCD detectará el cambio y aplicará

### Escalar Horizontalmente

```bash
kubectl scale deployment service-a --replicas=5 -n fintech
```

### Backup y Restauración

```bash
# Backup de recursos
kubectl get all,configmap,secret -n fintech -o yaml > backup.yaml

# Restauración
kubectl apply -f backup.yaml
```

## Seguridad

- Namespaces aislados por entorno
- RBAC configurado para diferentes roles
- Secrets gestionados via Kubernetes Secrets
- Network policies para restringir tráfico entre servicios

## Referencias

- [Documentación de Kubernetes](https://kubernetes.io/docs/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Prometheus Operator](https://prometheus-operator.dev/)
- [Grafana Dashboards](https://grafana.com/docs/)

// === ARCHIVO: clusters/dev-cluster.yaml ===
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: fintech-dev
networking:
  apiServerAddress: "127.0.0.1"
  apiServerPort: 6443
  podSubnet: "10.244.0.0/16"
  serviceSubnet: "10.96.0.0/16"
  disableDefaultCNI: false
  kubeProxyMode: "iptables"
nodes:
  - role: control-plane
    kubeadmConfigPatches:
      - |
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "node-role=master,environment=dev"
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
        protocol: TCP
      - containerPort: 443
        hostPort: 443
        protocol: TCP
      - containerPort: 3000
        hostPort: 3000
        protocol: TCP
      - containerPort: 9090
        hostPort: 9090
        protocol: TCP
    extraMounts:
      - hostPath: /dev/mount
        containerPath: /dev/mount
        readOnly: true
  - role: worker
    kubeadmConfigPatches:
      - |
        kind: JoinConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "node-role=worker,environment=dev,workload-type=general"
    labels:
      node-role: worker
      environment: dev
      workload-type: general
  - role: worker
    kubeadmConfigPatches:
      - |
        kind: JoinConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "node-role=worker,environment=dev,workload-type=memory-intensive"
    labels:
      node-role: worker
      environment: dev
      workload-type: memory-intensive


// === ARCHIVO: namespaces/fintech.yaml ===
apiVersion: v1
kind: Namespace
metadata:
  name: fintech
  labels:
    environment: production
    platform: fintech-core
    managed-by: argocd
    compliance-level: pci-dss
    cost-center: engineering-platform
    team: platform-team
    monitoring-enabled: "true"
    backup-enabled: "true"
  annotations:
    description: "Namespace principal para la plataforma de microservicios de fintech"
    maintainer: "platform-team@fintech.company.com"
    created-date: "2024-01-15T00:00:00Z"
    last-modified: "2024-01-15T00:00:00Z"
    environment-type: production
    compliance-requirements: "pci-dss,sox"
    backup-schedule: "daily-at-02:00-utc"
    monitoring-datadog-integration: "enabled"
    service-mesh: "istio"
---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: fintech-quota
  namespace: fintech
spec:
  hard:
    requests.cpu: "32"
    requests.memory: 64Gi
    limits.cpu: "64"
    limits.memory: 128Gi
    persistentvolumeclaims: "20"
    services: "50"
    secrets: "100"
    configmaps: "50"
    pods: "100"
    replicationcontrollers: "20"
    services.loadbalancers: "10"
    services.nodeports: "5"
  scopeSelector:
    matchExpressions:
      - operator: In
        scopeName: PriorityClass
        values: ["high", "critical"]
---
apiVersion: v1
kind: LimitRange
metadata:
  name: fintech-limits
  namespace: fintech
spec:
  limits:
    - max:
        cpu: "8"
        memory: 16Gi
      min:
        cpu: 50m
        memory: 64Mi
      default:
        cpu: 500m
        memory: 512Mi
      defaultRequest:
        cpu: 100m
        memory: 128Mi
      type: Container
    - max:
        cpu: "16"
        memory: 32Gi
      min:
        cpu: 100m
        memory: 128Mi
      type: Pod
    - max:
        storage: 50Gi
      min:
        storage: 1Gi
      type: PersistentVolumeClaim
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: fintech-namespace-config
  namespace: fintech
  labels:
    app.kubernetes.io/managed-by: argocd
data:
  environment: "production"
  platform: "fintech-core"
  cluster-region: "us-east-1"
  backup-retention-days: "30"
  log-retention-days: "90"
  enable-metrics: "true"
  enable-tracing: "true"
  service-timeout-seconds: "30"
  health-check-interval-seconds: "10"
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-default-deny
  namespace: fintech
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-allow-ingress
  namespace: fintech
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/name: ingress-nginx
  policyTypes:
    - Ingress
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
      ports:
        - protocol: TCP
          port: 80
        - protocol: TCP
          port: 443
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-allow-egress-dns
  namespace: fintech
spec:
  podSelector: {}
  policyTypes:
    - Egress
  egress:
    - to:
        - namespaceSelector: {}
      ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-allow-egress-internal
  namespace: fintech
spec:
  podSelector: {}
  policyTypes:
    - Egress
  egress:
    - to:
        - namespaceSelector:
            matchLabels:
              name: fintech
      ports:
        - protocol: TCP
          port: 8080
        - protocol: TCP
          port: 9090
        - protocol: TCP
          port: 5432
        - protocol: TCP
          port: 6379
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: fintech-deployer
  namespace: fintech
  labels:
    app.kubernetes.io/managed-by: argocd
  annotations:
    description: "ServiceAccount usado por ArgoCD para desplegar recursos en el namespace fintech"
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: fintech-deployer-role
  namespace: fintech
rules:
  - apiGroups: ["", "apps", "networking.k8s.io", "autoscaling"]
    resources: ["*"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: [""]
    resources: ["configmaps", "secrets", "services"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["coordination.k8s.io"]
    resources: ["leases"]
    verbs: ["get", "create", "update"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: fintech-deployer-rolebinding
  namespace: fintech
subjects:
  - kind: ServiceAccount
    name: fintech-deployer
    namespace: fintech
roleRef:
  kind: Role
  name: fintech-deployer-role
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: v1
kind: Secret
metadata:
  name: fintech-registry-credentials
  namespace: fintech
  labels:
    app.kubernetes.io/managed-by: argocd
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: eyJhdXRocyI6ImRvY2tlci1yZWdpc3RyeS5maW50ZWNoLmNvbSJ9

// === ARCHIVO: microservices/service-a/Chart.yaml ===
apiVersion: v2
name: service-a
description: Helm chart para el microservicio A de la plataforma fintech
type: application
version: 1.0.0
appVersion: "1.0.0"
keywords:
  - fintech
  - microservices
  - kubernetes
  - service-a
maintainers:
  - name: Platform Team
    email: platform@fintech.example.com
sources:
  - https://github.com/fintech/microservices
dependencies: []


// === ARCHIVO: microservices/service-a/templates/service.yaml ===
apiVersion: v1
kind: Service
metadata:
  name: {{ include "service-a.fullname" . }}
  labels:
    {{- include "service-a.labels" . | nindent 4 }}
    app.kubernetes.io/component: service
    app.kubernetes.io/part-of: fintech-platform
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "{{ .Values.service.port | default 8080 }}"
    prometheus.io/path: "/actuator/prometheus"
spec:
  type: {{ .Values.service.type | default "ClusterIP" }}
  ports:
    - port: {{ .Values.service.port | default 8080 }}
      targetPort: {{ .Values.service.targetPort | default 8080 }}
      protocol: TCP
      name: http
      {{- if eq .Values.service.type "NodePort" }}
      nodePort: {{ .Values.service.nodePort | default 30080 }}
      {{- end }}
  selector:
    {{- include "service-a.selectorLabels" . | nindent 4 }}
    app.kubernetes.io/component: pod
---
# Configuración de Service para el microservicio service-a
# Este Service expone el pod internamente dentro del clúster de Kubernetes
# permitiendo la comunicación entre microservicios de la plataforma fintech.
#
# El tipo ClusterIP es el valor por defecto y expone el servicio en una IP
# interna del clúster, accesible únicamente desde dentro del mismo.
# Para exponeción externa se puede cambiar a NodePort o LoadBalancer.
#
# Las anotaciones de Prometheus habilitan el scrape automático de métricas
# por parte del operador de Prometheus, permitiendo monitoreo en Grafana.
#
# La configuración de labels sigue las convenciones de Kubernetes Labels
# para facilitar la identificación y selección de recursos relacionados.
# Se incluyen labels para indicar el componente y la plataforma a la que
# pertenece este servicio.

---
apiVersion: v1
kind: Service
metadata:
  name: {{ include "service-a.fullname" . }}-headless
  labels:
    {{- include "service-a.labels" . | nindent 4 }}
    app.kubernetes.io/component: headless-service
    app.kubernetes.io/part-of: fintech-platform
spec:
  type: ClusterIP
  clusterIP: None
  ports:
    - port: {{ .Values.service.port | default 8080 }}
      targetPort: {{ .Values.service.targetPort | default 8080 }}
      protocol: TCP
      name: http
  publishNotReadyAddresses: true
  selector:
    {{- include "service-a.selectorLabels" . | nindent 4 }}
    app.kubernetes.io/component: pod
---
# Servicio headless para descubrimiento de pods en StatefulSets
# El clusterIP: None indica que Kubernetes no asigna una IP virtual
# al servicio, permitiendo que los clientes se conecten directamente
# a los pods descubiertos mediante DNS.
#
# publishNotReadyAddresses: true permite que los pods no listos
# también sean descubiertos, útil durante el inicio de la aplicación
# y para escenarios de zero-downtime deployment.
#
# Este servicio es necesario cuando el microservicio necesita
# comunicación directa entre instancias (ej. clustering, shardig).

// === ARCHIVO: microservices/service-a/templates/hpa.yaml ===
{{- if .Values.autoscaling.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "service-a.fullname" . }}
  labels:
    {{- include "service-a.labels" . | nindent 4 }}
    app.kubernetes.io/component: autoscaler
    app.kubernetes.io/part-of: fintech-platform
  annotations:
    prometheus.io/apscale: "true"
    {{- if .Values.autoscaling.annotations }}
    {{- toYaml .Values.autoscaling.annotations | nindent 4 }}
    {{- end }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "service-a.fullname" . }}
  minReplicas: {{ .Values.autoscaling.minReplicas | default 2 }}
  maxReplicas: {{ .Values.autoscaling.maxReplicas | default 10 }}
  metrics:
    {{- if .Values.autoscaling.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ .Values.autoscaling.targetCPUUtilizationPercentage }}
    {{- end }}
    {{- if .Values.autoscaling.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ .Values.autoscaling.targetMemoryUtilizationPercentage }}
    {{- end }}
    {{- if .Values.autoscaling.customMetrics }}
    {{- toYaml .Values.autoscaling.customMetrics | nindent 4 }}
    {{- end }}
  behavior:
    scaleDown:
      stabilizationWindowSeconds: {{ .Values.autoscaling.scaleDownStabilization | default 300 }}
      policies:
        - type: Percent
          value: {{ .Values.autoscaling.scaleDownPercent | default 10 }}
          periodSeconds: 60
        - type: Pods
          value: {{ .Values.autoscaling.scaleDownPods | default 2 }}
          periodSeconds: 60
      selectPolicy: Min
    scaleUp:
      stabilizationWindowSeconds: {{ .Values.autoscaling.scaleUpStabilization | default 0 }}
      policies:
        - type: Percent
          value: {{ .Values.autoscaling.scaleUpPercent | default 100 }}
          periodSeconds: 15 }}
        - type: Pods
          value: {{ .Values.autoscaling.scaleUpPods | default 4 }}
          periodSeconds: 15
      selectPolicy: Max
---
# Horizontal Pod Autoscaler para escalamiento automático del microservicio
# El HPA ajusta el número de réplicas del Deployment basándose en métricas
# de CPU, memoria o métricas personalizadas configuradas.
#
# Configuración de escalamiento para soportar 5000 solicitudes por segundo
# con tiempo de respuesta promedio de 200ms según los requisitos de la
# plataforma fintech. Los valores por defecto permiten manejar picos de
# tráfico mientras optimizan el uso de recursos durante períodos de baja
# demanda.
#
# El comportamiento de scaleUp usa selectPolicy: Max para priorizar el
# escalamiento rápido cuando hay alta demanda, mientras que scaleDown
# usa selectPolicy: Min para evitar eliminaciones excesivas de pods
# durante fluctuaciones breves de tráfico.
#
# La política de scaleDown incluye stabilizationWindowSeconds para
# prevenir el efecto yo-yo (escalamiento rápido hacia arriba y abajo)
# causado por métricas que fluctúan rápidamente.

---
{{- if .Values.autoscaling.vpaEnabled }}
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: {{ include "service-a.fullname" . }}-vpa
  labels:
    {{- include "service-a.labels" . | nindent 4 }}
    app.kubernetes.io/component: vertical-autoscaler
    app.kubernetes.io/part-of: fintech-platform
spec:
  targetRef:
    apiVersion: "apps/v1"
    kind: Deployment
    name: {{ include "service-a.fullname" . }}
  updatePolicy:
    updateMode: "{{ .Values.autoscaling.vpaUpdateMode | default "Auto" }}"
  resourcePolicy:
    containerPolicies:
      - containerName: {{ .Chart.Name }}
        minAllowed:
          memory: "{{ .Values.autoscaling.vpaMinMemory | default "256Mi" }}"
          cpu: "{{ .Values.autoscaling.vpaMinCpu | default "100m" }}"
        maxAllowed:
          memory: "{{ .Values.autoscaling.vpaMaxMemory | default "4Gi" }}"
          cpu: "{{ .Values.autoscaling.vpaMaxCpu | default "2000m" }}"
        controlledResources: ["cpu", "memory"]
{{- end }}
---
# Vertical Pod Autoscaler para ajuste automático de recursos por pod
# El VPA ajusta las solicitudes y límites de CPU/memoria de cada pod
# basándose en el uso histórico, optimizando la asignación de recursos.
#
# Esta configuración complementa el HPA cuando se requiere tanto
# escalamiento horizontal (más pods) como vertical (mejores recursos
# por pod). Es especialmente útil para cargas de trabajo donde el
# consumo de recursos varía significativamente entre diferentes
# períodos del día.
#
# El modo "Auto" aplica automáticamente las recomendaciones de VPA
# con evictación de pods cuando es necesario. Para entornos de producción
# con tolerancia cero a interrupciones, considerar el modo "Recreate".
{{- end }}
---
# Configuración de métricas personalizadas para escalamiento basado en
# solicitudes HTTP. Esta configuración adicional permite al HPA usar
# métricas de la aplicación cuando las métricas de CPU/memoria no son
# suficientes para capturar la carga real del servicio.
#
# Para habilitar esta funcionalidad, agregar en values.yaml:
# autoscaling:
#   customMetrics:
#     - type: Pods
#       pods:
#         metric:
#           name: http_requests_per_second
#         target:
#           type: AverageValue
#           averageValue: "1000"


// === ARCHIVO: argocd/applications/service-a.yaml ===
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: service-a
  namespace: argocd
  labels:
    app: service-a
    environment: production
    tier: backend
    managed-by: argocd
  annotations:
    description: "Microservicio principal de la plataforma fintech"
    maintainer: "plataforma-devops@fintech.com"
    revision-history-limit: "3"
spec:
  project: fintech
  source:
    - repoURL: https://github.com/fintech/platform-config.git
      targetRevision: main
      path: microservices/service-a
      helm:
        valueFiles:
          - values.yaml
        parameters:
          - name: image.repository
            value: fintechregistry.azurecr.io/service-a
          - name: image.tag
            value: v1.2.0
          - name: replicaCount
            value: "3"
          - name: resources.limits.cpu
            value: "2000m"
          - name: resources.limits.memory
            value: "2Gi"
          - name: resources.requests.cpu
            value: "500m"
          - name: resources.requests.memory
            value: "512Mi"
          - name: autoscaling.enabled
            value: "true"
          - name: autoscaling.minReplicas
            value: "3"
          - name: autoscaling.maxReplicas
            value: "10"
          - name: autoscaling.targetCPUUtilizationPercentage
            value: "70"
          - name: service.type
            value: ClusterIP
          - name: service.port
            value: "8080"
          - name: service.targetPort
            value: "8080"
          - name: ingress.enabled
            value: "true"
          - name: ingress.hostname
            value: api.fintech.internal
          - name: ingress.className
            value: nginx
          - name: monitoring.enabled
            value: "true"
          - name: monitoring.prometheusScrape
            value: "true"
          - name: monitoring.prometheusPort
            value: "9090"
  destination:
    server: https://kubernetes.default.svc
    namespace: fintech-prod
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - CreateNamespace=true
      - PrunePropagationPolicy=foreground
      - PruneLast=true
      - Replace=false
      - ServerSideApply=false
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
  ignoreDifferences:
    - group: apps
      kind: Deployment
      jsonPointers:
        - /spec/replicas
    - group: ""
      kind: Service
      jsonPointers:
        - /spec/clusterIP
  revisionHistory:
    limit: 10
  info:
    - name: architecture
      value: microservices
    - name: team
      value: payments
    - name: sla
      value: "99.9%"
    - name: scaling
      value: horizontal-autoscaling
// === ARCHIVO: argocd/projects/fintech.yaml ===
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: fintech
  namespace: argocd
  labels:
    environment: production
    organization: fintech-platform
    cost-center: engineering
  annotations:
    description: "Proyecto principal para la plataforma de microservicios de fintech"
    owner: "plataforma-devops@fintech.com"
    business-unit: "financial-services"
spec:
  description: |
    Proyecto ArgoCD para gestionar el ciclo de vida de los microservicios
    de la plataforma fintech. Incluye servicios de procesamiento de pagos,
    gestión de cuentas, notificaciones y analytics. Este proyecto garantiza
    separación de entornos y políticas de despliegue controladas.
  sourceRepos:
    - "https://github.com/fintech/platform-config.git"
    - "https://github.com/fintech/microservices.git"
    - "https://github.com/fintech/infrastructure.git"
    - "https://github.com/fintech/monitoring.git"
    - "git@github.com:fintech/platform-config.git"
    - "git@github.com:fintech/microservices.git"
  destinations:
    - server: https://kubernetes.default.svc
      namespace: fintech-dev
      allowedNamespaces:
        - fintech-dev
    - server: https://kubernetes.default.svc
      namespace: fintech-staging
      allowedNamespaces:
        - fintech-staging
    - server: https://kubernetes.default.svc
      namespace: fintech-prod
      allowedNamespaces:
        - fintech-prod
    - server: https://kubernetes.default.svc
      namespace: argocd
      allowedNamespaces:
        - argocd
    - server: https://kubernetes.default.svc
      namespace: monitoring
      allowedNamespaces:
        - monitoring
        - prometheus
        - grafana
    - server: https://kubernetes.default.svc
      namespace: fintech-common
      allowedNamespaces:
        - fintech-common
  clusterResourceWhitelist:
    - group: ""
      kind: Namespace
    - group: ""
      kind: ResourceQuota
    - group: ""
      kind: LimitRange
    - group: rbac.authorization.k8s.io
      kind: Role
    - group: rbac.authorization.k8s.io
      kind: RoleBinding
    - group: networking.k8s.io
      kind: NetworkPolicy
  clusterResourceBlacklist:
    - group: rbac.authorization.k8s.io
      kind: ClusterRole
    - group: rbac.authorization.k8s.io
      kind: ClusterRoleBinding
    - group: admissionregistration.k8s.io
      kind: ValidatingWebhookConfiguration
    - group: admissionregistration.k8s.io
      kind: MutatingWebhookConfiguration
  namespaceResourceWhitelist:
    - group: ""
      kind: Service
    - group: ""
      kind: ConfigMap
    - group: ""
      kind: Secret
    - group: ""
      kind: Pod
    - group: ""
      kind: ServiceAccount
    - group: apps
      kind: Deployment
    - group: apps
      kind: ReplicaSet
    - group: apps
      kind: StatefulSet
    - group: apps
      kind: DaemonSet
    - group: autoscaling
      kind: HorizontalPodAutoscaler
    - group: networking.k8s.io
      kind: Ingress
    - group: networking.k8s.io
      kind: IngressClass
    - group: policy
      kind: PodDisruptionBudget
    - group: policy
      kind: PodSecurityPolicy
    - group: monitoring.coreos.com
      kind: ServiceMonitor
    - group: monitoring.coreos.com
      kind: PrometheusRule
  namespaceResourceBlacklist:
    - group: rbac.authorization.k8s.io
      kind: Role
    - group: rbac.authorization.k8s.io
      kind: RoleBinding
  roles:
    - name: admin
      description: "Rol de administrador con permisos completos sobre el proyecto"
      policies:
        - p, proj:fintech:admin, applications, *, proj:fintech/*, allow
        - p, proj:fintech:admin, applicationsets, *, proj:fintech/*, allow
        - p, proj:fintech:admin, projects, proj:fintech, allow
      groups:
        - fintech-platform-admins
        - platform-engineers
    - name: developer
      description: "Rol de desarrollador con permisos de lectura y despliegue"
      policies:
        - p, proj:fintech:developer, applications, get, proj:fintech/*, allow
        - p, proj:fintech:developer, applications, sync, proj:fintech/*, allow
        - p, proj:fintech:developer, applications, create, proj:fintech/*, allow
        - p, proj:fintech:developer, applications, update, proj:fintech/*, allow
        - p, proj:fintech:developer, applications, delete, proj:fintech/*, allow
        - p, proj:fintech:developer, applicationsets, get, proj:fintech/*, allow
        - p, proj:fintech:developer, applicationsets, create, proj:fintech/*, allow
      groups:
        - fintech-developers
        - payments-team
    - name: readonly
      description: "Rol de solo lectura para auditoría y revisión"
      policies:
        - p, proj:fintech:readonly, applications, get, proj:fintech/*, allow
        - p, proj:fintech:readonly, applicationsets, get, proj:fintech/*, allow
        - p, proj:fintech:readonly, projects, get, proj:fintech, allow
      groups:
        - fintech-auditors
        - qa-team
  syncWindows:
    - kind: allow
      schedule: "0 8-18 * * 1-5"
      duration: 10h
      applications:
        - "fintech-prod/*"
      namespaces:
        - fintech-prod
    - kind: deny
      schedule: "0 0 * * 0"
      duration: 4h
      applications:
        - "fintech-prod/*"
      namespaces:
        - fintech-prod
      reason: "Mantenimiento programado domingo"
  signatureKeys:
    keyID: ""
  orbots:
    - name: fintech-bot
      token: ""
      projects:
        - fintech
      policies:
        - p, proj:fintech:bot, applications, *, proj:fintech/*, allow

// === ARCHIVO: scripts/deploy.sh ===
#!/bin/bash

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
readonly KUBECTL_VERSION="1.28.0"eadonly HELM_VERSION="3.14.0"eadonly ARGOCD_VERSION="v2.9.3"

readonly CLUSTER_NAME="dev-cluster"
readonly NAMESPACE_FINTECH="fintech"
readonly NAMESPACE_MONITORING="monitoring"
readonly NAMESPACE_ARGOCD="argocd"

log_info() {
    echo "[INFO] $(date +'%Y-%m-%d %H:%M:%S') - $*"
}

log_error() {
    echo "[ERROR] $(date +'%Y-%m-%d %H:%M:%S') - $*" >&2
}

log_success() {
    echo "[SUCCESS] $(date +'%Y-%m-%d %H:%M:%S') - $*"
}

check_prerequisites() {
    log_info "Verificando prerrequisitos del sistema..."
    
    if ! command -v kubectl &> /dev/null; then
        log_error "kubectl no está instalado. Versión requerida: ${KUBECTL_VERSION}"
        return 1
    fi
    
    if ! command -v helm &> /dev/null; then
        log_error "helm no está instalado. Versión requerida: ${HELM_VERSION}"
        return 1
    fi
    
    if ! kubectl cluster-info &> /dev/null; then
        log_error "No hay conexión con el clúster de Kubernetes"
        return 1
    fi
    
    log_success "Prerrequisitos verificados correctamente"
}

install_argocd() {
    log_info "Instalando ArgoCD en el clúster..."
    
    kubectl create namespace "${NAMESPACE_ARGOCD}" --dry-run=client -o yaml | kubectl apply -f -
    
    kubectl apply -n "${NAMESPACE_ARGOCD}" -f "https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/install.yaml"
    
    log_info "Esperando que ArgoCD esté disponible..."
    kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n "${NAMESPACE_ARGOCD}" --timeout=300s || true
    
    log_success "ArgoCD instalado correctamente"
}

deploy_namespace() {
    local namespace=$1
    local manifest_path=$2
    
    log_info "Desplegando namespace ${namespace}..."
    
    if [[ -f "${PROJECT_ROOT}/${manifest_path}" ]]; then
        kubectl apply -f "${PROJECT_ROOT}/${manifest_path}"
        log_success "Namespace ${namespace} desplegado"
    else
        kubectl create namespace "${namespace}" --dry-run=client -o yaml | kubectl apply -f -
        log_success "Namespace ${namespace} creado"
    fi
}

deploy_cluster() {
    local cluster_manifest=$1
    
    log_info "Desplegando configuración del clúster..."
    
    if [[ -f "${PROJECT_ROOT}/${cluster_manifest}" ]]; then
        kubectl apply -f "${PROJECT_ROOT}/${cluster_manifest}"
        log_success "Configuración del clúster aplicada"
    else
        log_error "Manifiesto del clúster no encontrado: ${cluster_manifest}"
        return 1
    fi
}

deploy_microservice() {
    local service_name=$1
    local chart_path="${PROJECT_ROOT}/microservices/${service_name}"
    
    log_info "Desplegando microservicio ${service_name} con Helm..."
    
    if [[ ! -d "${chart_path}" ]]; then
        log_error "Chart de Helm no encontrado: ${chart_path}"
        return 1
    fi
    
    helm upgrade --install "${service_name}" "${chart_path}" \
        --namespace "${NAMESPACE_FINTECH}" \
        --create-namespace \
        --wait \
        --timeout 5m \
        -f "${chart_path}/values.yaml"
    
    log_success "Microservicio ${service_name} desplegado correctamente"
}

deploy_argocd_application() {
    local app_name=$1
    local app_manifest="${PROJECT_ROOT}/argocd/applications/${app_name}.yaml"
    
    log_info "Registrando aplicación ${app_name} en ArgoCD..."
    
    if [[ -f "${app_manifest}" ]]; then
        kubectl apply -f "${app_manifest}" -n "${NAMESPACE_ARGOCD}"
        log_success "Aplicación ${app_name} registrada en ArgoCD"
    else
        log_error "Manifiesto de aplicación ArgoCD no encontrado: ${app_manifest}"
        return 1
    fi
}

deploy_monitoring() {
    log_info "Desplegando stack de monitoreo..."
    
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo add grafana https://grafana.github.io/helm-charts
    helm repo update
    
    log_info "Instalando Prometheus..."
    helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
        --namespace "${NAMESPACE_MONITORING}" \
        --create-namespace \
        --wait \
        --timeout 10m \
        -f "${PROJECT_ROOT}/monitoring/prometheus/values.yaml"
    
    log_info "Instalando Grafana..."
    helm upgrade --install grafana grafana/grafana \
        --namespace "${NAMESPACE_MONITORING}" \
        --wait \
        --timeout 10m \
        -f "${PROJECT_ROOT}/monitoring/grafana/values.yaml"
    
    log_success "Stack de monitoreo desplegado correctamente"
}

deploy_argocd_project() {
    local project_manifest="${PROJECT_ROOT}/argocd/projects/fintech.yaml"
    
    log_info "Creando proyecto ArgoCD para fintech..."
    
    if [[ -f "${project_manifest}" ]]; then
        kubectl apply -f "${project_manifest}" -n "${NAMESPACE_ARGOCD}"
        log_success "Proyecto ArgoCD creado"
    else
        log_error "Manifiesto de proyecto ArgoCD no encontrado"
        return 1
    fi
}

sync_argocd_app() {
    local app_name=$1
    
    log_info "Sincronizando aplicación ${app_name} en ArgoCD..."
    
    argocd app sync "${app_name}" --timeout 600 || {
        log_error "Error al sincronizar ${app_name}. La aplicación se sincronizará automáticamente."
        return 1
    }
    
    log_success "Aplicación ${app_name} sincronizada"
}

verify_deployment() {
    local namespace=$1
    local expected_replicas=${2:-1}
    
    log_info "Verificando despliegue en namespace ${namespace}..."
    
    local ready_pods
    ready_pods=$(kubectl get pods -n "${namespace}" -o jsonpath='{.items[*].status.conditions[?(@.type=="Ready")].status}' | wc -w)
    
    if [[ "${ready_pods}" -ge "${expected_replicas}" ]]; then
        log_success "Verificación exitosa: ${ready_pods} pods listos en ${namespace}"
        return 0
    else
        log_error "Verificación fallida: solo ${ready_pods} pods listos"
        return 1
    fi
}

main() {
    log_info "Iniciando despliegue de la plataforma de microservicios..."
    log_info "Directorio del proyecto: ${PROJECT_ROOT}"
    
    check_prerequisites || exit 1
    
    log_info "Fase 1: Configuración inicial del clúster"
    deploy_cluster "clusters/dev-cluster.yaml"
    deploy_namespace "${NAMESPACE_FINTECH}" "namespaces/fintech.yaml"
    deploy_namespace "${NAMESPACE_MONITORING}" "namespaces/monitoring.yaml"
    
    log_info "Fase 2: Instalación de ArgoCD"
    install_argocd
    deploy_argocd_project
    
    log_info "Fase 3: Despliegue de microservicios"
    deploy_microservice "service-a"
    deploy_argocd_application "service-a.yaml"
    
    log_info "Fase 4: Despliegue de monitoreo"
    deploy_monitoring
    
    log_info "Fase 5: Verificación final"
    verify_deployment "${NAMESPACE_FINTECH}" 2
    verify_deployment "${NAMESPACE_MONITORING}" 1
    
    log_success "========================================="
    log_success "Despliegue completado exitosamente"
    log_success "========================================="
    log_info "ArgoCD disponible en: https://localhost:8080 (configurar port-forward)"
    log_info "Grafana disponible en: https://localhost:3000 (configurar port-forward)"
    log_info "Para acceder a ArgoCD: kubectl port-forward svc/argocd-server -n argocd 8080:443"
    log_info "Para acceder a Grafana: kubectl port-forward svc/grafana -n monitoring 3000:80"
}

main "$@"

```
