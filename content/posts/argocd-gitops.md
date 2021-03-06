---
title: "GitOps in practice"
date: 2021-08-10
draft: false
tags: ['gitops', 'argocd']
---


Previously I looked at K3d with ArgoCD and recklessly threw in GitOps without a real explanation...

## What is GitOps and why do I need it?

Just another buzzword? I personally don't think so.\
To Quote from [WeaveWorks](https://www.weave.works/technologies/gitops/):
> GitOps works by using Git as a single source of truth for declarative infrastructure and applications. With GitOps, the use of software agents can alert on any divergence between Git with what's running in a cluster, and if there's a difference, Kubernetes reconcilers automatically update or rollback the cluster depending on the case. 

We can take all the good stuff from IaC (Infrastructure as code) and close the loop on ensuring that what is in Git is always the source of truth with continuous monitoring and divergence alignment.

Cant beat the feeling of looking at an ArgoCD dashboard that spans multiple clusters with everything perfectly in synchronization!

This becomes even more powerful when the infrastructure tooling and the application stack itself can all be managed in exactly the same way. No need to access the running system anymore, absolutely everything is done via Git....

- When was 'x' service updated? Check the Git PR
- Alerts for increased volume of 5xx errors since 2pm, did anything change? Check Git
- What is the diff between v1.45 and v1.46 in the Helm chart for 'x' service? Check ArgoCD (This can prove really useful for external Helm charts)

---
## Application stack
I'm using [this](https://github.com/davidwmcneill/gitops-playground-apps) repository for my local experiments with GitOps. The goal of the project:
- Testing ArgoCD itself for upgrades and template patterns before moving to live platforms
- Experimenting with new Kubernetes tools which can easily be removed when resources get low, whilst maintaining a git state allowing for a quick startup again in the future

### App of Apps
By implementing ArgoCD in an declarative setup, there is a concept referred to as [App of apps](https://argoproj.github.io/argo-cd/operator-manual/declarative-setup/#app-of-apps)
This allows for a top level to bootstrap sub layers of applications.\
In a production grade setup this can be really useful for grouping application stacks by teams, functions etc, each with their own project level permissions.\
For simplicity in the local stack all apps are currently sitting under a single top level app and project, but it gives an idea for the use case.

This also becomes really useful for generating the parent apps in a Helm template. There is a really nice example and explanation of this [here](https://github.com/stevesea/argocd-helm-app-of-apps-example) which I have used as a foundation for the application template.

### Templates and Manifests
ArgoCD supports a range manifest types. Primarily I've used [Helm](https://helm.sh/). More recently I've started to use [Kustomize](https://kustomize.io/) and might look to incorporate this more in the future.

---
## Tips and Tricks
Through working with ArgoCD I've come across and number of well thought out features. Some of the most useful being:
- Pulling the ArgoCD [CLI binary](https://argoproj.github.io/argo-cd/user-guide/ci_automation/#synchronize-the-app-optional) directly from the ArgoCD server. This is really useful when using the cli as part of a CICD pipeline. Whenever you upgrade ArgoCD, the cli used elsewhere will always be on the same version


---
## Reference
- https://www.weave.works/technologies/gitops/
- https://www.weave.works/technologies/gitops-frequently-asked-questions/
