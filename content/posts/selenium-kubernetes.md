---
title: "Selenium with Kubernetes"
date: 2021-08-16
draft: true
tags: ['kubernetes', 'Selenium', 'python']
---
## Background
I've read and heard a lot about Selenium over the years, but never got my hands dirty. It's been on my 'todo' list for a fair while!

This blog topic is a good excuse to cover off a few learning points:
- Get an automated test running in a local k3d cluster to generate some traffic when testing progressive deployments with Argo-rollouts
- Investigate the options for running Selenium in K8s and how it can scale
- Write some Python!

## What is Selenium
Selenium was originally developed in 2004 as an internal web application test tool at ThoughtsWork. This was known as Selenium Core.
Selenium Grid was later developed for parallel testing and reduce the execution time. In 2006 Selenium Web Driver was added which facilitates a programmatic approach to creating the tests which can be interchangeably run across many browsers.

![history](https://www.webomates.com/wp-content/uploads/2019/12/Selenium1.png "Selenium History")

So Selenium covers a number of different projects:
- WebDriver: Uses browser automation APIs provided by the browser vendors to control and run tests as if being used by a real user
- IDE: Used to develop test cases. Chrome/Firefox extension to record browser using existing Selenium commands.
- Grid: Executing test cases on remote servers ( i.e. running on multiple browsers and operating systems)


## What are the options?
My first port of call was to check for existing frameworks or packages specifically for running Selenium on K8s. Maybe an existing Helm package or set of manifests.

This is where I discovered [Zalenium](https://github.com/zalando/zalenium) - A selenium Grid extension to scale a local grid dynamically with docker containers.\
But sadly this project is no longer under development. However this project does refer to a more popular and active project [Docker-Selenium](https://github.com/seleniumhq/docker-selenium/).



## What is GitOps and why do I need it?


## Other test tools
Some other test I have or plan to look at (not specific to UI testing):
- https://github.com/tsenart/vegeta
- 

---
## Reference
- https://www.selenium.dev/documentation/overview/
- https://www.blazemeter.com/blog/How-%20to-Scale-Selenium-Tests-in-a-Kubernetes-Cluster
- https://www.pingdom.com/solution/automated-browser-tests/