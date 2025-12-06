# Changelog

All notable changes to this chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-12-06

### Added
- Initial release of EKS Baseline Chart
- Deployment template with security best practices
- Service template for internal exposure
- Ingress template with TLS support
- ServiceAccount with configurable annotations
- HorizontalPodAutoscaler for automatic scaling
- ConfigMap and Secret templates
- Comprehensive values.yaml with sensible defaults
- Liveness and readiness probes configuration
- Pod and container security contexts
- Resource limits and requests
- Node selector, tolerations, and affinity support
- Environment variables configuration
- Complete documentation in README.md

### Security
- Pod runs as non-root user (UID 1000)
- Container security context with dropped capabilities
- Read-only root filesystem
- No privilege escalation allowed
