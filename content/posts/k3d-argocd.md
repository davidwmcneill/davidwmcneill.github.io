---
title: "K3d + ArgoCD = Local GitOps"
date: 2021-08-09
draft: false
tags: ['k3d', 'argocd']
---

## The pre-ramble
A quick look at what ArgoCD and K3d are...

---
[What is ArgoCD?](https://argoproj.github.io/argo-cd/#what-is-argo-cd)
> Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

![ArgoCD UI](https://argoproj.github.io/argo-cd/assets/argocd-ui.gif "ArgoCD")

Top alternatives...
- [FluxCD](https://fluxcd.io/)
---
[What is K3d](https://k3d.io/)
> k3d is a lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker.

Top alternatives...
- [Kind](https://kind.sigs.k8s.io/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
---
## The idea
I've been working with ArgoCD in production for a few years now and it is in my opinion the biggest game changer in terms of Kubernetes continuous delivery management.

It got me thinking about a seamless way to get from a developers local laptop to an integration environment without any rework. It doesn't make sense to write docker compose files to provision stacks locally and at the same time write and maintain Kubernetes manifests (Helm, Kustomize etc) for the next leg of the journey.

- What if each developer had their own K8s cluster managed by ArgoCD that they could selectively synchronize application stacks on depending on which project they were working on
- Could profile Prometheus metrics on their local stack
- Recreate a running application stack based on the image tags of any environment for debugging etc
- Have an easy to use UI for the running state of local pods and logging
- Quick and easy Create/destroy option, saving time on debugging local setups and ensuring consistency for each developers local environment

---
## The how

There are some great tutorials on setting up K3d locally and running ArgoCD (I'll link to these in the references).\
My twist on this is to bootstrap the whole process down to a single command with as few pre-requisites as possible. I've been working on this [here](https://github.com/davidwmcneill/gitops-playground)

Not wishing to rewrite the readme again here, the bootstrap wraps the k3d install script passing in a base level configuration for the cluster (To simulate a real custer of sorts as opposed to a single node).

ArgoCD gets installed using a Kubernetes job that runs Helm (This is to remove Helm itself as a prerequisite)\

---
## The GitOps magic

Once ArgoCD installs in the cluster it automatically synchronizes the remaining cluster requirements - critically in this case an ingress controller. I've chosen to use [Ingress-Nginx](https://kubernetes.github.io/ingress-nginx/) in place of the K3d default Traefik.

The bootstrap also replaces the Flannel [network plugin](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/) with Calico.

Ingress-Nginx and the rest of the application stack are managed using GitOps and synchronized from the 'Local' branch of the repository [here](https://github.com/davidwmcneill/gitops-playground-apps)

---
## Now what?
In the time it takes to run the bootstrap a developer has a fully functional local Kubernetes cluster ready to work with GitOps! Developers can branch off 'Local' to shape the cluster to their needs and merge back in to share with other developers who will get the update all within a local context.

The nice part is that we don't need to use loads of different local ports (as can sometimes be the case with docker compose). We can expose any browser based service we need via a path based ingress behind the ingress controller.


In future posts I'll look at some of the projects I've deployed using this stack to learn new technologies!


---
## References

- https://en.sokube.ch/post/gitops-on-a-laptop-with-k3d-and-argocd-1
- https://www.sokube.ch/post/k3s-k3d-k8s-a-new-perfect-match-for-dev-and-test
- https://codeburst.io/creating-a-local-development-kubernetes-cluster-with-k3s-and-traefik-proxy-7a5033cb1c2d