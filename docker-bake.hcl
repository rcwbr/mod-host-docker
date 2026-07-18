target "mod-host-docker" {
  inherits   = ["default"]
  context    = "cwd://"
  dockerfile = "cwd://Dockerfile"
  contexts = {
    base_context = "docker-image://python:3.12.4"
  }
}
