---
title: Operating the Diamond beamline
author: Christopher Daniel
subcollection: SXRD
---

## Operating the Diamond beamline

The beamline scientists will show you how to operate the beamline during your session. However, this can be quite an overwhelming experience. The notes here can provide a checklist for running particular tests, so that you do not miss out recording important data.

## Launching the controls

## Method for standard acquisition

1. Rotate ETMT to run experiment - change TAB2 from 45 to 0 degrees
2. Change beamline setup to capture image of sample - MoveToEndOfDetectorDiagnostics
3. Open shutters (once move has completed) - press Reset, then Open
4. Change camera diagnostic to continuously record - npeg, continuous
5. Open camera to view sample - cam, open QT Viewer 
6. Adjust X and Y positions of TAB2 to move beam to centre of sample
7. Take sample image at 0.2 second acquisition frequency - scan ix 1 1 1 camEH1end 0.2 
8. Change beamline setup to capture diffraction patterns - MoveToDiffractionMode
9. Open shutters (once move has completed) - press Open
10. Start recording diffraction patterns at 2 second acquisition frequency - scan ix 1 10000 1 pilatus_eh1_sw 2
11. Start ETMT test using a laptop with remote desktop link
12. Once test has finished, stop recording diffraction patterns by pression stop button (top right of script window)
13. Change beamline setup to capture image of sample - MoveToEndOfDetectorDiagnostics
14. Open shutters (once move has completed) - press Open
15. Change camera diagnostic to continuously record - npeg, continuous
16. Open camera to view sample - cam, open QT Viewer
17. Take sample image at 0.2 second acquisition frequency - scan ix 1 1 1 camEH1end 0.2 
18. Close shutters
19. Rotate ETMT to take out sample - change TAB2 from 0 to 45 degrees
20. Open hutch and replace sample to setup another test...

## Method for fast acquisition

