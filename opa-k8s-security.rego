package main

# ✅ Allow both NodePort and LoadBalancer service types
deny contains msg if {
  input.kind == "Service"
  not allowed_service_type(input.spec.type)
  msg = sprintf("Service type '%s' is not allowed", [input.spec.type])
}

allowed_service_type(type) {
  type == "NodePort"
}

allowed_service_type(type) {
  type == "LoadBalancer"
}

# ❌ Deny containers running as root
deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.securityContext.runAsNonRoot == true
  msg = sprintf("Container '%s' must not run as root - use runAsNonRoot within container security context", [container.name])
}
