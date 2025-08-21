package main

# Service should use NodePort type
deny contains msg if {
  input.kind == "Service"
  input.spec.type != "NodePort"
  msg = "Service type should be NodePort"
}

# Containers must not run as root
deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.securityContext.runAsNonRoot == true
  msg = sprintf("Container '%s' must not run as root - use runAsNonRoot within container security context", [container.name])
}

