---
title: Organisation of research data
author: Peter Crowther
---
# Organisation of research data

This is a summary of the points covered in the paper **Good enough practices in scientific computing**: https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510

## Why organise data?

All modern research means collecting and processing data. As equipment has increased in complexity and computing power has increased, the amount of data collected and its complexity has also increased. In order to do good reproducible research, it is important that the data is treated correctly. If the data is not treated correctly it can result in drawing inappropriate conclusions which does not make good science.

## Data organisation

### Keep raw data

The raw data from a measurement should always be kept. While it is possible to reproduce analysis of a raw dataset, it may not be possible to reproduce the original raw data. Keeping the original raw data is important so that others can reproduce the analysis that you have done.

### Ensure data are backed up

Data should be backed up, preferably in more than one location. Where possible use university networked storage as this is much more robust than USB hard disks.

### Record metadata

Metadata tells people about how the data was collected. Data without context is meaningless as it cannot be analysed. Make sure that you know what metadata is important for each experiment and make sure that it is being recorded for each measurement you do. It may be the case that the metadata is collected along with the result in the result file but it may be the case that you have to record some of the data manually. This is what a lab book is for but it is also a good idea to make a digital record of the metadata too so that if the files are passed on but not the lab book, the data does not lose its value.

### Organisation

Put each project in its own directory. If a project is big, it may be relevant to break it up into sub projects. Keep documentation in a *docs* folder, analysis code in a *src* folder, raw data in a *data* folder and analysed results in a *results* folder. If you are publishing then make a new folder for the paper and have a *data* folder for data, a *plots* folder for code that plots graphs and a *figures* folder for the completed plots.

### Use version control

For any text based documents such as papers or code, use version control tools to keep a single versioned copy. This reduces the chances of losing vital work and allows easy collaboration with other people.