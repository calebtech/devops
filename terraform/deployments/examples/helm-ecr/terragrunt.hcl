terraform {
    source = "../../../modules/helm-release/helm-aws"
}

inputs = {
    cluster_name = "my-example-cluster"
    name = "my-example-ecr"
    chart_name = "ecr-sync"
    chart_repo = "https://aws.github.io/eks-charts"
    chart_version = "1.0.0"

    values = []
    timeout = 300

}