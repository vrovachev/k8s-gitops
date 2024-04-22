import yaml
import manifests
import k8s.api.core.v1 as k8core
list_ns = [
    "leblon",
    "minio"
]

manifests.yaml_stream([
   [
       k8core.Namespace { metadata.name = ns }
   ] for ns in list_ns
])

