---
title: Animations with ImageMagick
author: Adam Plowman
tags: []
toc: true
published: true
subcollection: Misc
---

ImageMagick command to convert a series of PNGs (named `ani.*.png`; as produced by ParaView) to an animated GIF:

`convert -delay 10 ani.*.png ani.gif`
