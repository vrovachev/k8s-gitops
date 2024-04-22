import yaml
import manifests
import k8s.api.core.v1 as k8core
manifests.yaml_stream([
   [
       k8core.Namespace { metadata.name = ns }
   ] for ns in ["testns"]
])

