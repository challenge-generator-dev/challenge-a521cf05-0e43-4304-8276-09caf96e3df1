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