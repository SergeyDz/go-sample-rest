job("Build and push Docker") {
    docker {
        build {
            context = "docker"
            file = "./Dockerfile"
            labels["vendor"] = "mycompany"
        }

        push("sergeydz/go-sample-rest") {
            tags("1.0-space")
        }
    }
}