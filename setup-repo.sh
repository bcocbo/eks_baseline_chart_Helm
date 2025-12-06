#!/bin/bash

# Script para crear el repositorio de GitHub y subir el chart
# Uso: ./setup-repo.sh <GITHUB_TOKEN> <GITHUB_USERNAME>

set -e

GITHUB_TOKEN=$1
GITHUB_USERNAME=$2
REPO_NAME="eks_baseline_chart_Helm"

if [ -z "$GITHUB_TOKEN" ] || [ -z "$GITHUB_USERNAME" ]; then
    echo "Uso: ./setup-repo.sh <GITHUB_TOKEN> <GITHUB_USERNAME>"
    exit 1
fi

echo "🚀 Creando repositorio en GitHub..."

# Crear el repositorio
curl -H "Authorization: token $GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/user/repos \
     -d "{
       \"name\": \"$REPO_NAME\",
       \"description\": \"Chart transversal base para despliegues en EKS\",
       \"private\": false,
       \"auto_init\": false
     }"

echo ""
echo "✅ Repositorio creado"
echo ""
echo "📦 Inicializando git y subiendo archivos..."

# Inicializar git si no existe
if [ ! -d .git ]; then
    git init
fi

# Configurar remote
git remote remove origin 2>/dev/null || true
git remote add origin "https://${GITHUB_TOKEN}@github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"

# Agregar archivos
git add .
git commit -m "Initial commit: EKS Baseline Chart v1.0.0

- Deployment template with security best practices
- Service, Ingress, and HPA templates
- ConfigMap and Secret support
- Comprehensive documentation"

# Subir a GitHub
git branch -M main
git push -u origin main

echo ""
echo "✅ Chart subido exitosamente!"
echo "📍 Repositorio: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
echo ""
echo "Para usar este chart en ArgoCD, usa:"
echo "  repoURL: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
echo "  path: ."
