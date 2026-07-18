target "mod-host-docker" {
  inherits   = ["default"]
  context    = "cwd://"
  dockerfile = "cwd://Dockerfile"
  contexts = {
    base_context    = "docker-image://python:3.12.4"
    github-mod-host = "https://github.com/rcwbr/mod-host.git#2026-07-21"
  }
}
