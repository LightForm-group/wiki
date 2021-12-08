---
title: Operating the Diamond beamline
author: Christopher Daniel
subcollection: SXRD
---

## Setting up the beamline

The beamline scientists will take you through the beam calibration. It is useful at this stage to know how many rings of a particular phase you would like to collect. The beamline scientist can then take you through the appropriate beam size (eg. 0.5 x 0.5 mm) and detector distance (eg. 750 mm). The new pilatus detector has lots of gaps which can be a problem for capturing the rings. It could also be an advantage to assume orthorhombic symmetry and adjust the detector height, so that you can capture only the bottom half of the pattern. This can improve the resolution of the rings for better pattern fitting. However, it may be a problem for calculating accurate texture and phase fraction, which require full rings.

## Operating the Diamond beamline

The beamline scientists will also show you how to operate the beamline during your session. However, this can be quite an overwhelming experience. The notes here can provide a checklist for running particular tests, particularly late at night, so that you do not miss out recording important data.

## Launching the controls

In case the computer crashes late at night, here are where the beamline controls are found...

Beamline controls: Start (top right corner) / Beamlines / EH1

GDA (for running scripts to operate beamline): Start / Data Acquisition / GDA Client
GDA scripts: GDA / Scripts / src / users / "Experiment Number"

Camera: Equipment / EH1 End
Start camera: npeg / start / image mode / continuous
See sample image: cam / QT Viewer


## Method for standard acquisition

1. Rotate ETMT to run experiment - change TAB2 from 45 to 0 degrees
2. Change beamline setup to capture image of sample - MoveToEndOfDetectorDiagnostics
3. Open slits (once move has completed) - press Reset, then Open
4. Change camera diagnostic to continuously record - npeg, continuous
5. Open camera to view sample - cam, open QT Viewer 
6. Adjust X and Y positions of TAB2 to move beam to centre of sample
7. Take sample image at 0.2 second acquisition frequency - scan ix 1 1 1 camEH1end 0.2 
8. Change beamline setup to capture diffraction patterns - MoveToDiffractionMode
9. Open slits (once move has completed) - press Open
10. Start recording diffraction patterns at 2 second acquisition frequency - scan ix 1 10000 1 pilatus_eh1_sw 2
11. Start ETMT test using a laptop with remote desktop link
12. Once test has finished, stop recording diffraction patterns by pression stop button (top right of script window)
13. Change beamline setup to capture image of sample - MoveToEndOfDetectorDiagnostics
14. Open slits (once move has completed) - press Open
15. Change camera diagnostic to continuously record - npeg, continuous
16. Open camera to view sample - cam, open QT Viewer
17. Take sample image at 0.2 second acquisition frequency - scan ix 1 1 1 camEH1end 0.2 
18. Close slits
19. Rotate ETMT to take out sample - change TAB2 from 0 to 45 degrees
20. Open hutch and replace sample to setup another test...

## Method for fast acquisition

For fast acquisition a new script had to be created. It seems there is a limit with how many frames can be recorded, so 100 Hz can at max be ran for up to 60 seconds. There is also a delay after running fast acquisition mode for the data from the Pilatus detector to be saved out to the Diamond storage. Additionally, it seems the it takes longer than expected to record at a particular frequency, so setting the number of frames can cause the acquisition to overrun - Stefan Michalik can advise on this.

1. Rotate ETMT to run experiment - change TAB2 from 45 to 0 degrees
2. Change beamline setup to capture image of sample - MoveToEndOfDetectorDiagnostics
3. Open slits (once move has completed) - press Reset, then Open
4. Change camera diagnostic to continuously record - npeg, continuous
5. Open camera to view sample - cam, open QT Viewer 
6. Adjust X and Y positions of TAB2 to move beam to centre of sample
7. Enter the X and Y positions into xstage_pos and ystage_pos variables in the script
8. Save the script
9. Adjust folderName and timeDuration variables in the script to match the test
10. Take sample image at 0.2 second acquisition frequency - scan ix 1 1 1 camEH1end 0.2
11. Change beamline setup to capture diffraction patterns - MoveToDiffractionMode
12. Open slits (once move has completed) - press Open
13. Record a single diffraction pattern at 5 second acquisition frequency - scan ix 1 1 1 pilatus_eh1_sw 5
15. Prepare to start the ETMT test using a laptop with remote desktop link
16. At same time as starting ETMT test, click 'run' on the script
17. Once test has finished, stop recording diffraction patterns by pression stop button (top right of script window)
18. Record a single diffraction pattern at 5 second acquisition frequency - scan ix 1 1 1 pilatus_eh1_sw 5
19. Change beamline setup to capture image of sample - MoveToEndOfDetectorDiagnostics
20. Open slits (once move has completed) - press Open
21. Change camera diagnostic to continuously record - npeg, continuous
22. Open camera to view sample - cam, open QT Viewer
23. Take sample image at 0.2 second acquisition frequency - scan ix 1 1 1 camEH1end 0.2 
24. Close slits
25. Rotate ETMT to take out sample - change TAB2 from 0 to 45 degrees
26. Open hutch and replace sample to setup another test...
