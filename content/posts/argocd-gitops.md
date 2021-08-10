---
title: "GitOps in practice"
date: 2021-08-10
draft: false
tags: ['gitops', 'argocd']
---
## GitOps in practice

Previously I looked at K3d with ArgoCD and recklessly threw in GitOps without a real explanation...

## What is GitOps and why do I need it?

Just another buzzword? I personally don't think so.\
To Quote from [WeaveWorks](https://www.weave.works/technologies/gitops/):
> GitOps works by using Git as a single source of truth for declarative infrastructure and applications. With GitOps, the use of software agents can alert on any divergence between Git with what's running in a cluster, and if there's a difference, Kubernetes reconcilers automatically update or rollback the cluster depending on the case. 

We can take all the good stuff from IaC (Infrastructure as code) and close the loop on ensuring that what is in Git is always the source of truth with continuous monitoring and divergence alignment.

Cant beat the feeling of looking at an ArgoCD dashboard that spans multiple clusters with everything perfectly in synchronization!

This becomes even more powerful when the infrastructure tooling and the application stack itself can all be managed in exactly the same way. No need to access the running system anymore, absolutely everything is done via Git....

- Who and when updated 'x' service? Check the Git PR
- We started seeing increased number of 4xx errors at 2pm, did anything change? Check Git
- What is the diff between v1.45 and v1.46 in the Helm chart for 'x' service? Check ArgoCD (This can prove really useful for external Helm charts)

---
## Application stack
I'm using [this](https://github.com/davidwmcneill/gitops-playground-apps) repository for my local experiments with GitOps. The goal of the project:
- Testing ArgoCD itself for upgrades and template patterns before moving to live platforms
- Experimenting with new Kubernetes tools which can easily be removed when I run low on resources whilst maintaining a git state allowing for a quick startup again in the future

### App of Apps
By implementing ArgoCD in an declarative setup, there is a concept refereed to as [App of apps](https://argoproj.github.io/argo-cd/operator-manual/declarative-setup/#app-of-apps)
This allows for a top level to bootstrap sub layers of apps.\
In a production grade setup this can be really useful for grouping application stacks by teams, functions etc, each with their own project level permissions.\
For simplicity in the local stack all apps are currently sitting under a single top level app and project, but it gives an idea for the use case.

### Templates and Manifests
ArgoCD supports a range manifest types. Primarily I've used Helm. But more and more I see good justification to use Kustomize. I might look to use this more in the future.

---
## Tips and Tricks
Through working with ArgoCD I've come across and number of well thought out features. Some of the most useful being:
- Pulling the ArgoCD cli binary from the ArgoCD server. This is really useful when using the cli as part of a CICD pipeline. Whenever you upgrade ArgoCD, the cli used else where will always be on the same version


---
## Reference
- https://www.weave.works/technologies/gitops/
- https://www.weave.works/technologies/gitops-frequently-asked-questions/
- 