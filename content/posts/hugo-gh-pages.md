---
title: "Hugo with GitHub Pages"
date: 2021-08-06
draft: false
tags: ['hugo', 'github']
---

Before writing a blog, there needs to be a blog... \
A good place to start!

### Hugo to the rescue
What is [Hugo](https://gohugo.io/getting-started/quick-start/)?
> Hugo is a static HTML and CSS website generator written in Go
### Hugo with a Theme
I first crossed paths with Hugo while working on a project using the [git-sync sidecar](https://github.com/kubernetes/git-sync) integration; Hugo is used as part of the demo configuration for this tool.\
I've since used Hugo for a demo local k3d build pipeline and it was while creating this I stumbled upon the integration with github actions.

There are noteworthy alternatives such as [Jekyll](https://github.com/jekyll/jekyll), but for now I'll give Hugo a go....[hosting on github](https://gohugo.io/hosting-and-deployment/hosting-on-github/)

I went slightly beyond the quick-start and used [Hugo modules](https://gohugo.io/hugo-modules/use-modules/) for importing a theme, following the steps for the [Ananke theme](https://github.com/theNewDynamic/gohugo-theme-ananke#installation). This appears to be a more manageable approach over using git submodule.


Straight forward enough:
```al
hugo mod init github.com/<your_user>/<your_project>
```

Add the theme's repo to your config.toml:
```al
theme = ["github.com/theNewDynamic/gohugo-theme-ananke"]
```

### Github Actions
The [sample gh-actions](https://github.com/peaceiris/actions-gh-pages#getting-started) configuration can be found here with more details on the setup.\
Due to the use of the Theme module, the extended Hugo build is required.

Don't forget to set the source to the ```gh-pages``` branch (settings -> pages)

Push to main and voila!

https://davidwmcneill.github.io/

