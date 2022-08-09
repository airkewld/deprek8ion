# Deprek8ion 🕵️‍

[![build and deploy](https://github.com/airkewld/deprek8ion/actions/workflows/build_and_push.yaml/badge.svg)](https://github.com/airkewld/deprek8ion/actions/workflows/build_and_push.yaml)

A set of rego policies to monitor Kubernetes APIs deprecations.

The Kubernetes API deprecations can be found using <https://relnotes.k8s.io/?markdown=deprecated> and <https://kubernetes.io/docs/reference/using-api/deprecation-guide/>.

## Docker image

The docker container contains the most recent version of [conftest](https://www.conftest.dev/) as well as the policies at `/policies`.

## Example usage

An example of how to use the docker container can be seen below:
```sh
docker run --rm --name demo -v $(pwd)/demo:/demo ttl.sh/deprek8ion /demo/ingress.yaml
```
Or directly pipe some resources into the container:
```sh
cat ./demo/ingress.yaml | docker run ttl.sh/deprek8ion -
```
