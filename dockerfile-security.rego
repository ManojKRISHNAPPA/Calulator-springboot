package main

# Do Not store secrets in ENV variables
secrets_env = ["passwd", "password", "pass", "secret", "key", "access", "api_key", "apikey", "token", "tkn"]

deny[msg] {
    input[i].Cmd == "env"
    val := input[i].Value
    some s
    s := secrets_env[_]
    contains(lower(val), s)
    msg = sprintf("Line %d: Potential secret in ENV key found: %s", [i, val])
}

# Only use trusted base images
deny[msg] {
    input[i].Cmd == "from"
    val := split(input[i].Value[0], "/")
    count(val) > 1
    msg = sprintf("Line %d: Use a trusted base image", [i])
}

# Do not use 'latest' tag for base images
deny[msg] {
    input[i].Cmd == "from"
    val := split(input[i].Value[0], ":")
    count(val) > 1
    lower(val[1]) == "latest"
    msg = sprintf("Line %d: Do not use 'latest' tag for base images", [i])
}

# Avoid curl/wget bashing
deny[msg] {
    input[i].Cmd == "run"
    val := concat(" ", input[i].Value)
    regex.match(".*(curl|wget).*\\|.*", lower(val))
    msg = sprintf("Line %d: Avoid curl bashing", [i])
}

# Do not upgrade system packages
warn[msg] {
    input[i].Cmd == "run"
    val := concat(" ", input[i].Value)
    regex.match(".*(apk|yum|dnf|apt|pip).*(install|upgrade|update).*", lower(val))
    msg = sprintf("Line %d: Do not upgrade your system packages: %s", [i, val])
}

# Do not use ADD
deny[msg] {
    input[i].Cmd == "add"
    msg = sprintf("Line %d: Use COPY instead of ADD", [i])
}

# Require USER directive
deny[msg] {
    not input[_].Cmd == "user"
    msg = "Do not run as root, use USER instead"
}

# Forbid root user
forbidden_users = ["root", "toor", "0"]

deny[msg] {
    users := [name | input[i].Cmd == "user"; name := input[i].Value]
    lastuser := users[count(users)-1]
    some u
    forbidden_users[u]
    lower(lastuser) == u
    msg = sprintf("Last USER directive (USER %s) is forbidden", [lastuser])
}

# Do not use sudo
deny[msg] {
    input[i].Cmd == "run"
    val := concat(" ", input[i].Value)
    contains(lower(val), "sudo")
    msg = sprintf("Line %d: Do not use 'sudo' command", [i])
}

# Enforce multi-stage builds
deny[msg] {
    input[i].Cmd == "copy"
    not contains(lower(concat(" ", input[i].Flags)), "--from=")
    msg = "COPY detected without multi-stage build (--from=). Use multi-stage builds."
}
