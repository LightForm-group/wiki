---
title: Dilatometer quenching tests
author: Ed Pickering, Josh Collins, Mark Taylor
---

## Executive Summary

*What is this technique?*

Quenching dilatometry is a technique that measures of the expansion or contraction of a sample (i.e., its dilatation) when its temperature is changed.  A small specimen of material is placed into the dilatometer and is heat treated according to an inputted programme.  The temperature is controlled very accurately, typically using induction to heat the sample and pressurised inert gas to cool it.  Concurrently, the change in length of the sample is measured.  This is typically recorded in one direction only, using pushrods.  The change in length not only provides information regarding thermal expansion, but also solid-state phase transformations that involve significant changes in volume (e.g., the austenite to ferrite transition).  

*What information does it provide?*

The principal output of an experiment is a graph of change in length vs. temperature.  From this, the following can be extracted using appropriate data analysis:
•	Transformation start and finish temperatures (e.g., martensite start).  This can be used to create continuous cooling transformation (CCT) diagrams, continuous heating transformation (CHT) diagrams, and time-temperature-transformation (TTT) diagrams.  
•	The evolution of the volume fractions of microstructural constituents (e.g., martensite) with temperature.  
•	Thermal expansion coefficients.  

*Why/when use this technique?*

The technique is very useful when attempting to characterise and predict the microstructures that form in steels during industrial heat treatment processes, in particular austenitisation + quenching.  Different cooling rates can be experienced in different areas of large components when quenching, which may lead to the formation of different microstructures.  Dilatometry allows for the heat treatments at specific locations or (e.g., at different thicknesses) to be simulated, and hence the microstructures to be characterised and predicted more readily.  The construction of CCT and TTT diagrams is a particularly useful output in this regard.  

*What are the sample requirements?*

Samples need to be cylinders measuring 4 mm in diameter and 10 mm in length.  They may be made hollow for very fast heating and cooling rates.  The flat ends of the cylinder should be as parallel as possible and ground or milled to a fine finish.  The surface of the sample should be free from oxide.  

*How do we assess the data quality?*

To assess the origins of artefacts that may be apparent within datasets, a number of approaches can be used:
•	Different sample geometries and multiple thermocouple placements can be used to test whether non-uniform temperatures (or other geometry-related effects) are the cause of a phenomenon or not.  
•	Alternative sample materials, such as platinum, are also useful when looking for the cause of artefacts. 
•	Machine-derived artefacts can be assessed by examining the metadata gathered from results files, such as the data associated with HF power.  
•	Repeat measurements, either on the same sample or on samples of the same material, are always useful to determine whether artefacts have originated from one-time sample or machine oddities.  

In addition, to ensure good data quality and that our interpretations are sound in general, the following may be used: 
•	Repeat measurements on different samples of the same material.
•	Comparisons of results to those obtained through other experimental methods, in particular optical and scanning electron microscopy (SEM), and hardness.
•	Comparisons to empirical relationships for start temperatures can provide reassurances with respect to the identity of a transformation start temperature.  
•	Comparisons to results from more advanced models for phase transformation kinetics can also be a useful way validate the interpretation of transformation curves. 

*What are the common limitations/pitfalls?*

•	Only phase transformations that involve significant changes in sample length can be measured using dilatometry.  Hence, it is useful for steels that display solid-state allotropic phase transitions on heating/cooling, but is less useful for examining precipitation in nickel alloys or aluminium alloys. 
•	Sample sizes are typically no more than 4 mm diameter x 10 mm long.  The technique measures the length change of the entire specimen only (it samples the whole volume at once).  
•	Heating and cooling rates of up to 100˚C s-1 are usually achievable in a well-controlled manner in most alloys.  Heating and cooling rates of 1000˚C s-1 are achievable, but samples usually need to be hollow, the material has to have high thermal conductivity, and rates may not be so controllable.  
•	Typical maximum temperature of 1600˚C, although measurements and/or control of temperature may be less reliable at very high temperatures.  
•	It is difficult to assess volume fractions and start temperatures in mixed microstructures where there is overlap of transformations (e.g., bainite into martensite). 
•	It is also difficult to calculate accurate volume fractions if there is a significant amount of retained austenite (with unknown volume fraction) at the end of the test, or under certain circumstances in which there is a significant amount of carbon partitioning to the austenite during transformation(s), since the procedure does not account for these occurrences.  
•	The orientation of the samples should be considered where transformations may be non-isotropic in terms of their strain, for example when a sample is textured and the transformation has a strain that varies with crystallographic direction.

##1.	Introduction

**Dilatometry is the measurement of the expansion or contraction of a sample (i.e., its dilatation) when its temperature is changed.** This typically involves measurement in one direction (e.g., change in sample length), but measurements can also be multi-dimensional.  

The most common reason for conducting dilatometry measurements is to measure the thermal expansion coefficients a material. However, for steels and other metals that display allotropic transformations (i.e., a change in crystal structure with temperature), dilatometry can be used to examine their phase transformation behaviour.  In steels, the change from body-centred cubic (BCC) ferrite to face-centred cubic (FCC) austenite (and the reverse) is accompanied by a change in volume of a few percent – precise values depend on the temperature of transformation and the composition of the steel.  See Fig. 1 for an example of how the dilatation changes when a low-alloy steel is heated from room temperature to above its Ae3 temperature, where austenite is stable, and is then cooled back to room temperature.  

![Fig1](/wiki/assets/images/posts/Quenching_Dil_Fig1.png)
**Figure 1.**  Dilatation curve for SA508 Grade 3 steel heated to 1000˚C at 20˚C s-1 and cooled to room temperature at 20˚C s-1.  The transformation on cooling around 400˚C is that to martensite.  ![image](https://user-images.githubusercontent.com/26139658/113914295-4e27ee00-97d5-11eb-8fc7-81bdb5050ed3.png)

