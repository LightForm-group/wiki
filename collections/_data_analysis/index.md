---
layout: post
title: Data and Analysis
show_breadcrumbs: false
show_meta: false
published: true
author: Peter Crowther
toc: true
---

The experimental and simulation methods we use in modern research produce huge amounts of data. This data is valuable since it takes time and resources to produce, but if this data is not stored and analysed correctly this can greatly decrease its value. In these pages, data management and producing reliable and reproducible analysis workflows are broken down into key sections which are discussed in detail. Guidelines are given in each section to set out what is expected of you to make sure that we maintain a high standard in these areas.

A series of presentations were given to group members in July 2020. The slides for these can be found here: [Data management slides](./data_management.pdf)

## Introduction to open and reproducible science
Open research is the principle that as well as sharing results, the methods data and analysis used to create the results are also shared. The principles of open research are what drives all of the considerations discussed below.

[Open Research](./open-research)


## Data Management
Data management is about ensuring that the data we collect is stored, collated and annotated in such a way that it can be used in the future as easily as when it is first collected.

### Organisation of Research data
Starting out at the beginning of your PhD with just a few files, it might seem a lot of bother to set up an organisation system. The sooner you get into the habit of organising your research data, the easier it will be. Digital data also has to be stored carefully, since a single unpredictable event such as the failure of a storage device can result in permanganate data loss. In this section we set out guidelines for how you should be storing your data.

[Organisation of research data](./organisation-of-research-data)


### Metadata
Raw experimental or simulation data means nothing without information about the context of the simulation or experiment. If this metadata is not captured and stored along with the data, the data is likely to lose meaning over time. In this section we discuss metadata and guidelines for how to capure it.

[Experimental Metadata](./experimental-metadata)


### Uploading data to a repository
When we publish data, we need to put it somwhere it will be accessible well into the future. For this we use a data repository. This section has details about how to upload datasets to Zenodo.

[Uploading data to Zenodo](./zenodo)

## Reproducible scientific workflows for data analysis
Our analyses are often complex which reflects the complexity of the physical properties and processes that we are analysing. It is important that we are able to produce clear and reproducible analyses so that other people can verify the work that we do. The other important reason is that it allows others to more easily build on the work we do.

### Writing good code
Because our datasets are getting larger, automating our analyses has become essential rather than just nice to have. A lot of modern data analysis means programming. You don't need to be a programming expert but there are some simple things we can do to ensure that the code we write is maintainable, reproducible and shareable.

[Writing good code](./writing-good-code)

### Examples of good analysis workflows

[Analysis workflows](./analysis-workflows)

## Saving images
Some advice on choosing a suitable image [file format and resolution](./saving-figures)
