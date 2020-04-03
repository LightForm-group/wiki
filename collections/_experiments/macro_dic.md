---
published: true
author: Wayne Heatman
title: Macro DIC
---

This document oulines the procedure for carrying out macro DIC measurements. This procedure should be followed for achieving best quality data and make it ready for sharing and re-use.


## Application of speckle pattern
--can someone add some lines here?--

## Image aquisistion setup
The images that are to be obtained need to be as sharp as possible. Therefore, when firstly setting up a camera prior to testing there are a number of considerations that need to be taken into account:
- good, bright lighting is essential, and the LED lights included on the DIC equipment should be used. 
- use a dark background behind the sample (e.g. use non-reflective gaffer tape)
- The aperture needs to as high and (as closed as possible) -  this gives shaper image and increased depth of focus. 
- Speckles should be 3-4 pixels in size and well focused before starting the test.
- Working distance should be as small as possible and must be recorded

## Testing
- take up to 10 images of the sample before starting the test
- in most cases, chose an aquisition rate to give 300-1000 images per test
- check exposure time is at least 100 ms

## DIC calculation
- correlation mode needs to be set to ‘Relative to first’  
- calculation mode should be ste set to ‘Accurate’. 

### Error determination and calibration
The settings for best both subset size and step size should be determined from the frames captured before the test was started. The following analysis should be carried out on the first (10 or so) images:

- Subset size 11, step size 5
- Subset size 21, step size 10
- Subset size 31, step size 15
- Sunset size 41, step size 21

The data should then be exported and run through the analysis parameters test script. The smallest subset size that gives reasobnable (assymptotic error) should be used.

### Data export for analysis
- Export data using ASCII test. Make sure the decimal seprator is set to ('.').
- export images in a lossless format (TIF)
- analysis should be carried out using Python scripts, which will be shared on GitHub. Links to appear here.

