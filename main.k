import yaml
import manifests
import k8s.api.core.v1 as k8core
import argoproj.v1alpha1 as argoproj
_release = {
   name = "nginx-ingress"
   namespace = "nginx-ingress"
   version = "4.10.0"
   chart = {
      name = "ingress-nginx"
      repoURL = "https://kubernetes.github.io/ingress-nginx"
   }
}
_ingress_chart = argoproj.Application {
    metadata = {
        name = _release.name
        namespace = "argocd"
    }
    spec = {
        destination = {
            namespace = _release.namespace
            server = "https://kubernetes.default.svc"
        }
        project = "default"
        source = {
            chart = _release.chart.name
            repoURL = _release.chart.repoURL
            targetRevision = _release.version
            helm = {
                values = yaml.encode(_release.values)
                releaseName = _release.name
            }


        }
        syncPolicy = {
            automated = {
                selfHeal = True
            }
            syncOptions = [
                "CreateNamespace=true"
            ]
        }

    }
}
manifests.yaml_stream([
   [
       k8core.Namespace { metadata.name = ns }
   ] for ns in ["leblon", "minio"]
] + [_ingress_chart])
