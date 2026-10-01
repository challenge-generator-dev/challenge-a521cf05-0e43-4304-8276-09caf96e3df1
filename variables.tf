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