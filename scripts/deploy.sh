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