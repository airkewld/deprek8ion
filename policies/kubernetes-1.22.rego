package main

warn[msg] {
  input.apiVersion == "v1"
  input.kind == "List"
  obj := input.items[_]
  msg := _warn with input as obj
}

warn[msg] {
  input.apiVersion != "v1"
  input.kind != "List"
  msg := _warn
}

deny[msg] {
  input.apiVersion == "v1"
  input.kind == "List"
  obj := input.items[_]
  msg := _deny with input as obj
}

deny[msg] {
  input.apiVersion != "v1"
  input.kind != "List"
  msg := _deny
}

# Based on https://github.com/kubernetes/kubernetes/issues/82021

# The admissionregistration.k8s.io/v1beta1 versions of MutatingWebhookConfiguration and ValidatingWebhookConfiguration are deprecated in 1.19. Migrate to use admissionregistration.k8s.io/v1 instead
_deny = msg {
  kinds := ["MutatingWebhookConfiguration", "ValidatingWebhookConfiguration"]
  input.apiVersion == "admissionregistration.k8s.io/v1beta1"
  input.kind == kinds[_]
  msg := sprintf("%s/%s: API admissionregistration.k8s.io/v1beta1 is deprecated in Kubernetes 1.22, use admissionregistration.k8s.io/v1 instead, available since v1.16", [input.kind, input.metadata.name])
}

_deny = msg {
  kinds := ["CertificateSigningRequest"]
  input.apiVersion == "certificates.k8s.io/v1beta1"
  input.kind == kinds[_]
  msg := sprintf("%s/%s: API certificates.k8s.io/v1beta1 is deprecated in Kubernetes 1.22, use certificates.k8s.io/v1 instead, available since v1.19", [input.kind, input.metadata.name])
}
