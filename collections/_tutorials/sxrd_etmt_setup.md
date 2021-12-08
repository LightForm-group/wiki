---
title: Tips for setting up ETMT at Diamond
author: Christopher Daniel
subcollection: SXRD
---

## Planning using the ETMT at Diamond

The Instron Electro-Thermal Mechanical Testing System (ETMT) is stored at Diamond, either in the Harwell complex, or in experimental hutch 2 on the I12 beamline. The beamline scientists can crane the ETMT into position on the I12 beamline, as well as connect up the cabling and water supply. This includes connecting 3x analogue outputs, which can be used for synching data from the ETMT with the recorded sycnhrotron patterns.

However, the ETMT is not an easy to use equipment. The ETMT at Diamond is also slightly different to the one at Manchester. Therefore, it is advised to have at least one day of training with Andrew Pearce (Instron), followed by at least one/two days of practice experiments with your samples, before the beamline experiment. 

## Practice check-list

Practice sessions with the ETMT at Diamond should be used before the synchrotron beamtime to;

- Set the gauge length of the machine. The samples at Diamond need to be tested in a chamber, which restricts the sample gauge length that can be tested. The largest gauge length of samples is about 40 mm, but samples should be less than this length if being deformed (for obvious reasons). To allow movement up to 40 mm it will be neccessary to remove the vacuum seal to the chamber attached to the top grip, which loosens a spring baffle. This is done by loosening the two grips underneath the rubber seal and above the baffle, using two rods and turning with opposite rotation. Note, this will mean that you now do not have a vacuum seal on the chamber.
- Connecting thermocouples. The chamber restricts the space, making it difficult to connect the thermocouples. For this reason, it is advised to have longer thermocouple and resistivity wires than usual (> 70 mm). It also helps to make the Pt/Rh (+ve terminal) wire slightly longer, by ~ 5 mm, than the Pt (-ve terminal) for easy identification and quick sample changeovers. Note, the Pt/Rh (+ve) wire also needs to be coming out from the top of the sample. The +ve on the top and -ve on the bottom prevents erroneous hot-spots forming along the sample length (no-one seems to know exactly why this happens).
- Create holders to support the thermocouple and resistivity connectors. If the connectors are pulling on the thermocouple wires, this is likely to pull them off during the experiment. So, use tape/metal objects to support the thermocouple connectors. Having the connectors upside down also makes it easier to insert the wires into the connector during the experiment.
- Check the connections into the computer are correct. There is a split connector for the thermocouple running into the back of the Eurotherm controller. In case of R-type the two orange connectors should connect into T/C-1 and T/C-2. However, in the case of K-type thermocouple it seems a connector with a looped wire is used to 'trick' the Eurortherm readout. Therefore, it is important to check the thermocouples connectors and the Eurotherm readout before starting an experiment.
- Check that no drive limits have been enabled. These limts are found in the settings (two arrows, bottom left) and are sometimes changed by users.
- Calibrate the PID settings. The PID settings for the different materials and sample geometries can vary. Calibrate these prior to the experiment to reduce time on the beamline.
- Check the ThermoLin settings for the temperature range you are testing at. The Diamond ETMT has a slightly different ThermoLin setting to the one used at Manchester. In this case, adjusting the "Thermocouple Range" temperature seems to largely affect the gradient at lower temperatures, whereas high temperatures remain largely unaffected. A typical value for "Thermocouple Range" is 1450C for tests running at high temperatures, but this can be adjusted to say 500C for more accurate temperature readouts for lower temperature test. Again, the "Adjusted Min T" seems to have more of an effect on lower temperatures, a typical value for this is 0.
- Check the analogue output settings for your data. Find the typical range of the Load (max N), Position (max mm), and Temperature (max C) from your tests. The output limit for the analogue output at Diamond is 10 volts. Therefore, using the maximum values allows you to set a scale for recording the Load (e.g. 200 N/V), Position (e.g. 0.5 mm/V), and Temperature (e.g. 150 C/V). You can check the output to the analgoue signal in the WaveForm software.
- Check you are recording the Eurotherm temperature in the data. The Eurotherm temperature is more accurate than the ETMT (controller) readout, with typically ~ 10 to 15 degrees difference. This is because the Eurotherm temperature can only be recorded at ~ 20 Hz, which is too slow to control during fast tests. Nevertheless, the Eurotherm temperature can be recorded as "Tempearture (Controller 1)" in Channels for correcting the data after a test.
- Check you can record the voltage output. The voltage output from two resistivity wires of the same type, e.g. Pt-Pt or Cu-Cu, and spot-welded ~ 2mm across the centre of the sample, can be used to record phase changes in the sample and plastic strain during a test. The voltage and current can be used to calculate electrical resistivity, which can be used to calculate phase fraction and plastic strain - see [Christopher S. Daniel EngD Thesis](https://www.research.manchester.ac.uk/portal/en/theses/an-investigation-into-the-texture-development-during-hotrolling-of-dualphase-zirconium-alloys(416cf1d6-15de-41d0-ad7c-3d0db664ae84).html). A BNC cable will need to be connected to the back of the computer to record this voltage signal. And the calibration will need to run with either High or Low voltage and a maximum of ~ 0.5 Volts. Also, check that you are actually recording this voltage signal in the data.
- Write out the testing methods. **Note, methods cannot be copied from the Manchester ETMT software**. Copying methods from different software versions can lead to errors running the tests and ouputting the data. 
- Check the methods on the Diamond ETMT run correctly.
- Check data output is in the correct format (correct acquisition frequency).

## Typical PID settings for Diamond ETMT

A useful description of PID settings can be found [here](https://www.reddit.com/r/FromTheDepths/comments/kuyftc/pid_tuning_guide_for_dummies/)

The PID settings on the ETMT can be tested by setting a waveform - using the waveform button, located in the bottom left panel. The ouput can be monitored using the scope tool. Note, it may be neccesary to change the axes of the scope to check the output.

Typical PID setting for the Linear Position Encoder are;
- P = 30 dB
- I = 1 /s
- D = 0 ms
- Lag = 0 ms

Typical PID setting for the Load are;
- P = 25.5 dB
- I = 0.5 /s
- D = 0 ms
- Lag = 0.5 ms

Typical PID setting for the Current are;
- P = 10 dB
- I = 15 /s
- D = 0 ms
- Lag = 20 ms

Typical PID setting for the Temperature are;
- P = 2 dB
- I = 0.2 /s
- D = 0 ms
- Lag = 50 ms
