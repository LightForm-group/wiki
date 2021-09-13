---
title: "Titanium CP/PF modelling - 2021 September"
author: Adam Plowman
tags:
  - titanium
  - crystal-plasticity
  - phase-field
  - dual-phase
published: true
subcollection: Modelling of dual-phase titanium under hot rolling conditions
order: 4
toc: true
---

**<span style="color:red">This page is a work-in-progress</span>**

*See the [project overview](/wiki/blog/ti-cp-pf-overview) for an outline. This page was last updated: September 2021*

| 🡸 [Previous month's update (August)](/wiki/blog/ti-cp-pf-2021-08) |

## Resource requirements

The crystal plasticity simulations must be performed with a sufficiently dense grid resolution. In particular, we must ensure:

1. smooth spatial variations of final stress/strain fields
2. sufficient modelling of the curved surfaces of the $\alpha$-phase particles
3. valid results when we later investigate the effects of the surface roughness of the $\alpha$-phase particles

To this end, we performed the same simple shear deformation on a set of volume elements with grid sizes ranging from (32 $\times$ 32 $\times$ 32) to (256 $\times$ 256 $\times$ 256).

![resource_req_RVEs](/wiki/assets/images/posts/blog/ti_cp_pf/resource_req_RVEs.png)
*Lower- and higher-resolution RVEs*

 The simulation durations and memory consumptions are plotted below, where grid sizes 32 and 64 where run using eight CPU cores, grid sizes 128 and 192 were run using 16 cores, and grid size 256 was run using 32 cores.

{% include plotly_figures/resource_use.html %}

