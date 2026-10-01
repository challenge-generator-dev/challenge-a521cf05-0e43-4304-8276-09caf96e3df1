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