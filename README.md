# Despliegue de una plataforma de microservicios con Kubernetes

En el contexto de una empresa de fintech, necesitas desplegar una plataforma de microservicios utilizando Kubernetes, Helm, GitOps con ArgoCD y monitoreo con Prometheus y Grafana. La plataforma debe soportar un tráfico de 5000 solicitudes por segundo con un tiempo de respuesta promedio de 200ms. Debes asegurar que los servicios sean desplegados de manera idempotente y que el sistema pueda recuperarse automáticamente de fallos temporales en los servicios downstream.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | kubernetes-devops |
| **Nivel** | junior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 2 semanas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Kubernetes

**Objetivo:** Configurar un clúster de Kubernetes y desplegar un microservicio básico.

**Tiempo estimado:** 3 días

**Instrucciones:**

- Configurar un clúster de Kubernetes en un entorno de desarrollo.
- Desplegar un microservicio de ejemplo utilizando Helm.
- Asegurar que el microservicio esté accesible y responda correctamente a las solicitudes.

**Entregable:** Clúster de Kubernetes configurado y microservicio básico desplegado.

<details>
<summary>Pistas de conocimiento</summary>

- Considera las mejores prácticas para la configuración de Kubernetes en un entorno de desarrollo.
- Piensa en cómo asegurar que el microservicio sea desplegado de manera idempotente.

</details>

### Fase 2: Implementación de GitOps con ArgoCD

**Objetivo:** Configurar ArgoCD para gestionar el despliegue de microservicios de manera automatizada.

**Tiempo estimado:** 4 días

**Instrucciones:**

- Configurar ArgoCD en tu clúster de Kubernetes.
- Crear un repositorio Git para almacenar las configuraciones de tus microservicios.
- Configurar ArgoCD para que sincronice automáticamente las configuraciones del repositorio Git con tu clúster de Kubernetes.

**Entregable:** Configuración de ArgoCD para el despliegue automatizado de microservicios.

<details>
<summary>Pistas de conocimiento</summary>

- Considera cómo estructurar tu repositorio Git para que sea fácil de mantener y escalar.
- Piensa en cómo manejar las actualizaciones de los microservicios de manera segura y sin interrupciones.

</details>

### Fase 3: Configuración de monitoreo con Prometheus y Grafana

**Objetivo:** Configurar Prometheus y Grafana para monitorear la plataforma de microservicios.

**Tiempo estimado:** 5 días

**Instrucciones:**

- Configurar Prometheus para recopilar métricas de los microservicios desplegados.
- Configurar Grafana para visualizar las métricas recopiladas por Prometheus.
- Crear dashboards en Grafana para monitorear el rendimiento y la salud de la plataforma.

**Entregable:** Configuración de Prometheus y Grafana para el monitoreo de la plataforma de microservicios.

<details>
<summary>Pistas de conocimiento</summary>

- Considera qué métricas son importantes para monitorear el rendimiento y la salud de la plataforma.
- Piensa en cómo configurar alertas en Grafana para notificarte de problemas críticos.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Kubernetes y por qué se utiliza en el despliegue de microservicios?
- **paraQueSirve**: ¿Para qué sirve ArgoCD en el despliegue de microservicios?
- **comoSeUsa**: ¿Cómo se utiliza Prometheus y Grafana para monitorear una plataforma de microservicios?
- **erroresComunes**: ¿Cuáles son los errores comunes al configurar Kubernetes, ArgoCD, Prometheus y Grafana?
- **queDecisionesImplica**: ¿Qué decisiones implica el despliegue de una plataforma de microservicios con Kubernetes, Helm, GitOps con ArgoCD y monitoreo con Prometheus y Grafana?

## Criterios de Evaluacion

- Configuración de un clúster de Kubernetes y despliegue de un microservicio básico.
- Configuración de ArgoCD para el despliegue automatizado de microservicios.
- Configuración de Prometheus y Grafana para el monitoreo de la plataforma de microservicios.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
