---
title: "Hugo with GitHub Pages"
date: 2021-08-06
draft: false
tags: ['hugo', 'github']
---

Before writing a blog, there needs to be a blog... \
A good place to start!

### Hugo with a Theme

I already had a [quick-start](https://gohugo.io/getting-started/quick-start/) Hugo site for testing a local k3d build pipeline and it was while creating this I stumbled upon the integration with github actions.

This time around I decided to give it a go....[hosting on github](https://gohugo.io/hosting-and-deployment/hosting-on-github/)

I went slightly beyond the quick-start and used [Hugo Modules](https://gohugo.io/hugo-modules/use-modules/) for importing a theme, following the steps for the [Ananke theme](https://github.com/theNewDynamic/gohugo-theme-ananke#installation). This appears to be a more manageable approach over using git submodule.


Fairly straight forward:
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

