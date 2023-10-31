---
title: Figures and file formats
author: Gerard Capes
---
## Which file format to use?
When processing data (e.g. with python and matplotlib) to create figures, there are multiple options for saving them.

[This blog](https://btjanaka.net/blog/matplotlib-figures/) gives some great tips and discussion on this topic, 
but the key points are summarised below:

- Prefer vector-based formats (svg and pdf)
  These represent images with points, lines, and curves, so they have 'infinite resolution'.
  Raster-based formats like png represent images with pixels, so they will get blurry when zoomed in.
- Use png when you need a raster-based format
  PNG files are saved with lossless compression, whereas jpg uses lossy compression, which gives rise to artifacts
  or distortions due to the data when saving.
