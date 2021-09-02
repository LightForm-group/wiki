---
title: "Titanium CP/PF modelling - 2021 August"
author: Adam Plowman
tags:
  - titanium
  - crystal-plasticity
  - phase-field
  - dual-phase
published: true
subcollection: Modelling of dual-phase titanium under hot rolling conditions
order: 3
toc: true
---

*See the [project overview](/wiki/blog/ti-cp-pf-overview) for an outline. This page was last updated: September 2021*

| 🡸 [Previous month's update (July)](/wiki/blog/ti-cp-pf-2021-07) | [Next month's update (September)](/wiki/blog/ti-cp-pf-2021-09) 🡺 |

Following on from our preliminary low resolution crystal plasticity simulations, we then investigated ways to defined sub-grains within the deformed RVE. 

## Investigating methods of orientation-field clustering

### A naive orientation-clustering approach

Conventional k-means clustering proceeds as follows:

1. Choose some trial cluster centroids
2. Assign each sample to its nearest cluster (according to, for example, a Euclidean distance metric)
3. For each centroid, compute the mean position of all the associated samples
4. Move the trial centroids to coincide with these sample-mean positions
5. Repeat steps 2 to 4 until the trial centroids no longer move (within some tolerance)

There are some issues with applying this method to the problem of sub-grain segmentation within an RVE. Firstly, we must be careful about choosing a suitable "distance" metric, since our samples are quaternions. Although these quaternions are represented as four-vectors, the Euclidean distance between  two quaternion four-vectors does not seem particularly meaningful. Instead we should choose something that has meaning within the orientation domain, such as the angle between quaternions. Likewise, we must be careful about averaging orientation samples; a meaningful quaternion average can be calculated, which is distinct from an arithmetic mean of the quaternion vector components. However, even if we are careful to employ quaternion-specific maths in our implementation of k-means clustering, we have not yet encoded any spatial information into the algorithm. Thus, such an approach would result in disconnected (sub-)grains, which are composed of voxels that have been clustered together due to the similarity of their orientations without regard for the location of the voxels within the RVE.

We could perhaps implement a k-means orientation-clustering algorithm where the angle between quaternions is additionally weighted by their spatial separation. However, instead of this, we worked initially on a cost-function approach, as discussed below.

### Minimise centroid positions according to the variance in orientations

Our initial approach was to:

1. Choose a set of centroid positions within the RVE
2. Assign each RVE voxel to its nearest centroid (thereby performing a discrete Voronoi tessellation)
3. Calculate an "average" quaternion for each Voronoi region
4. Calculate the quaternion "variance" for each Voronoi region (using the rotation angle between quaternions as the "distance" metric)
5. Wrap up steps 1. to 5. in a cost function that returns the sum of the region "variances"
6. Use the Nelder-Mead optimisation algorithm (as implemented in SciPy[^8]) with the above cost function to iterate on centroid positions 

Unfortunately, using our current implementation, Step 2 (tessellation) is slow and memory intensive, which makes the optimisation very slow. Additionally, we must specify in advance how many clusters (i.e. centroid positions) we wish to use. Ideally, we would instead specify the "distance" (i.e. rotation angle) between the clusters.

We chose the Nelder-Mead algorithm since it is "gradient-free", meaning the optimisation proceeds without the use of a gradient (i.e. a Jacobian or Hessian matrix). Other gradient-free optimisation algorithms also exist [^9], which we could try. These include the Powell algorithm [^10] and the basin-hopping method [^11].

We might investigate if using QHull as exposed in SciPy would be faster at performing discrete Voronoi tessellation than our implementation. If so, this could make the algorithm faster.

### Existing methods in use to segment EBSD data

We should be able to use existing methods for grain segmentation within EBSD data. Surveying the literature, we found that the MatLab toolbox MTEX, in its `calcGrains`[^7] function, uses [^3] [^4] one of two methods to segment (sub-)grains in EBSD data:

1. Markovian clustering [^1] [^2]
2. Fast multiscale clustering
    - Implementation details in MTEX discussed in Ref. [^5]
    - Original algorithm discussed in Ref. [^6]

The pipeline-based package Dream.3D also has a filter for segmenting grains, which we will investigate.

#### MTEX

The MTEX documentation gives some examples of loading in data from arbitrary text files[^12]. The first step was to generate from the deformed RVE a text file whose rows represent voxels and that contains columns with the following information:

- Phase (two phases in our data)
- Spatial coordinates: x, y, z
- Euler angles: Euler1, Euler2, Euler3

We have encounted some problems when trying to get MTEX to successfully load 3D data for grain segmentation; see the GitHub issue via Ref. [^13].

#### Dream.3D

- The pipeline-based Dream.3D package can perform grain segmentation using the `ScalarSegmentFeatures` filter[^14].
- A [previous discussion](https://github.com/BlueQuartzSoftware/DREAM3D/issues/321) on the Dream.3D GitHub repository regarding importing results from crystal plasticity simulations into Dream.3D.
- Performing segmentation in Dream.3D requires an `ImageGeometry`, which is a uniform rectilinear grid. This means we cannot use the displacement information of each deformed voxel when doing this segmentation. However, I don't think this matters.
- We have written a pipelines for performing the segmentation on a deformed RVE using a 128-cubed grid size. The deformed RVE and the resulting feature segmentation from the Dream3D pipeline is shown below. In this case we used a threshold misorientation angle of three degrees. I have yet to find a comprehensive description of the clustering algorithm that Dream3D uses for the segmentation, but it is reasonable to assume that our selected threshold means that neighbouring voxels that are misoriented by more than three degrees are considered to belong to distinct features (i.e. sub-grains).

![dual_phase_Ti_RVE_128_grid_deformed_hard](/wiki/assets/images/posts/dual_phase_Ti_RVE_128_grid_deformed_hard.png)

![dual_phase_Ti_RVE_128_grid_dream3D_clustered_3_degs_hard](/wiki/assets/images/posts/dual_phase_Ti_RVE_128_grid_dream3D_clustered_3_degs_hard.png)

These preliminary results do not show significant formation of sub-grains, since the additional features are in very close proximity to the boundary of the $\alpha$ precipitates. We will continue to investigate this.

## MatFlow integration

We have developed a MatFlow workflow (and associated task schemas/extension functionality) to perform the DAMASK simulations and grain segmentation using Dream.3D. More details will be provided as and when we concretise our analysis approach. However, an example task for generating the dual-phase RVE can be found [here](https://github.com/LightForm-group/UoM-CSF-matflow/blob/524fe20f2453df42e0ec3c59fc9265997de4c0e2/task_examples/generate_volume_element.yml#L110).

## Quaternion component ordering conventions

During our development of the associated MatFlow workflow, we found that different software can employ different orderings of quaternion components; vector-scalar or scalar-vector:

- Dream3D: vector-scalar[^15]
- DAMASK: scalar-vector[^16]
- MTEX: scalar-vector (I could not find an explicit statement, but from doing an Euler-to-quaternion conversion in MTEX, it seems so.)

## References

[^1]: [https://sites.cs.ucsb.edu/~xyan/classes/CS595D-2009winter/MCL_Presentation2.pdf](https://sites.cs.ucsb.edu/~xyan/classes/CS595D-2009winter/MCL_Presentation2.pdf)
[^2]: [https://micans.org/mcl/ani/mcl-animation.html](https://micans.org/mcl/ani/mcl-animation.html)
[^3]: [https://mtex-toolbox.github.io/GrainReconstructionAdvanced.html](https://mtex-toolbox.github.io/GrainReconstructionAdvanced.html)
[^4]: Bachmann, Florian, Ralf Hielscher, and Helmut Schaeben. ‘Grain Detection from 2d and 3d EBSD Data—Specification of the MTEX Algorithm’. Ultramicroscopy 111, no. 12 (1 December 2011): 1720–33. [https://doi.org/10.1016/j.ultramic.2011.08.002](https://doi.org/10.1016/j.ultramic.2011.08.002).
[^5]: Loeb, Andrew, Michael Ferry, and Lori Bassman. ‘Segmentation of 3D EBSD Data for Subgrain Boundary Identification and Feature Characterization’. Ultramicroscopy 161 (1 February 2016): 83–89. [https://doi.org/10.1016/j.ultramic.2015.11.003](https://doi.org/10.1016/j.ultramic.2015.11.003).
[^6]: Kushnir, Dan, Meirav Galun, and Achi Brandt. ‘Fast Multiscale Clustering and Manifold Identification’. Pattern Recognition 39, no. 10 (October 2006): 1876–91. [https://doi.org/10.1016/j.patcog.2006.04.007](https://doi.org/10.1016/j.patcog.2006.04.007).
[^7]: [https://mtex-toolbox.github.io/EBSD.calcGrains.html](https://mtex-toolbox.github.io/EBSD.calcGrains.html)
[^8]: [https://docs.scipy.org/doc/scipy/reference/optimize.minimize-neldermead.html](https://docs.scipy.org/doc/scipy/reference/optimize.minimize-neldermead.html)
[^9]: [http://scipy-lectures.org/advanced/mathematical_optimization/#gradient-less-methods](http://scipy-lectures.org/advanced/mathematical_optimization/#gradient-less-methods)
[^10]: [https://docs.scipy.org/doc/scipy/reference/optimize.minimize-powell.html](https://docs.scipy.org/doc/scipy/reference/optimize.minimize-powell.html)
[^11]: [https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.basinhopping.html](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.basinhopping.html)
[^12]: [https://mtex-toolbox.github.io/EBSD.load.html](https://mtex-toolbox.github.io/EBSD.load.html)
[^13]: [https://github.com/mtex-toolbox/mtex/issues/1170](https://github.com/mtex-toolbox/mtex/issues/1170)
[^14]: [http://www.dream3d.io/Filters/ReconstructionFilters/ScalarSegmentFeatures/](http://www.dream3d.io/Filters/ReconstructionFilters/ScalarSegmentFeatures/)
[^15]: [http://www.dream3d.io/Filters/OrientationAnalysisFilters/ConvertQuaternion/](http://www.dream3d.io/Filters/OrientationAnalysisFilters/ConvertQuaternion/)
[^16]: [https://git.damask.mpie.de/damask/DAMASK/-/blob/development/src/rotations.f90](https://git.damask.mpie.de/damask/DAMASK/-/blob/development/src/rotations.f90) indicates that DAMASK adopts the conventions listed in: Rowenhorst, D, A D Rollett, G S Rohrer, M Groeber, M Jackson, P J Konijnenberg, and M De Graef. ‘Consistent Representations of and Conversions between 3D Rotations’. Modelling and Simulation in Materials Science and Engineering 23, no. 8 (1 December 2015): 083501. [https://doi.org/10.1088/0965-0393/23/8/083501](https://doi.org/10.1088/0965-0393/23/8/083501), which writes quaternions in the scalar-vector format.
