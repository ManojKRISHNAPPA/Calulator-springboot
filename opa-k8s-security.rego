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

# Require security context for all containers
deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.securityContext
  msg = sprintf("Container '%s' must have a security context defined", [container.name])
}

# Prevent privileged containers
deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  container.securityContext.privileged == true
  msg = sprintf("Container '%s' must not run in privileged mode", [container.name])
}

# Require resource limits
warn contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.resources.limits
  msg = sprintf("Container '%s' should have resource limits defined", [container.name])
}

# Require resource requests
warn contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.resources.requests
  msg = sprintf("Container '%s' should have resource requests defined", [container.name])
}

# Prevent containers from running as UID 0 (root)
deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  container.securityContext.runAsUser == 0
  msg = sprintf("Container '%s' must not run as UID 0 (root)", [container.name])
}

# Require readiness probe
warn contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.readinessProbe
  msg = sprintf("Container '%s' should have a readiness probe defined", [container.name])
}

# Require liveness probe
warn contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.livenessProbe
  msg = sprintf("Container '%s' should have a liveness probe defined", [container.name])
}

# Prevent use of latest tag
deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  endswith(container.image, ":latest")
  msg = sprintf("Container '%s' should not use 'latest' tag: %s", [container.name, container.image])
}

# Prevent use of images without tags
deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not contains(container.image, ":")
  msg = sprintf("Container '%s' should specify an image tag: %s", [container.name, container.image])
}

# Require allowPrivilegeEscalation to be false
deny contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  container.securityContext.allowPrivilegeEscalation == true
  msg = sprintf("Container '%s' must not allow privilege escalation", [container.name])
}

# Require readOnlyRootFilesystem
warn contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.securityContext.readOnlyRootFilesystem == true
  msg = sprintf("Container '%s' should use read-only root filesystem", [container.name])
}

# Check for hostNetwork usage
deny contains msg if {
  input.kind == "Deployment"
  input.spec.template.spec.hostNetwork == true
  msg = "Deployment must not use hostNetwork"
}

# Check for hostPID usage
deny contains msg if {
  input.kind == "Deployment"
  input.spec.template.spec.hostPID == true
  msg = "Deployment must not use hostPID"
}

# Check for hostIPC usage
deny contains msg if {
  input.kind == "Deployment"
  input.spec.template.spec.hostIPC == true
  msg = "Deployment must not use hostIPC"
}

# Prevent containers from running with capabilities
warn contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  count(container.securityContext.capabilities.add) > 0
  msg = sprintf("Container '%s' should not add capabilities: %v", [container.name, container.securityContext.capabilities.add])
}

# Require dropping ALL capabilities
warn contains msg if {
  input.kind == "Deployment"
  container := input.spec.template.spec.containers[_]
  not "ALL" in container.securityContext.capabilities.drop
  msg = sprintf("Container '%s' should drop ALL capabilities", [container.name])
}
