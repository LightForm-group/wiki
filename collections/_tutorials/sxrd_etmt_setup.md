---
title: Tips for setting up ETMT at Diamond
author: Christopher Daniel
subcollection: SXRD
---

## Planning using the ETMT at Diamond

The Instron Electro-Thermal Mechanical Testing System (ETMT) is stored at Diamond, either in the Harwell complex, or in experimental hutch 2 on the I12 beamline. The beamline scientists can crane the ETMT into position on the I12 beamline, as well as connect up the cabling and water supply. This includes connecting 3x analogue outputs, which can be used for synching data from the ETMT with the recorded sycnhrotron patterns.

However, the ETMT is not an easy to use equipment. The ETMT at Diamond is also slightly different to the one at Manchester. Therefore, it is advised to have at least one day of training with Andrew Pearce (Instron), followed by at least one/two days of practice experiments with your samples, before the beamline experiment. 

## Practice sessions

Practice sessions with the ETMT at Diamond are needed to;

- Practice connecting the thermocouples. The samples at Diamond need to be tested in a chamber, which restricts the space to connect the thermocouples. For this reason, it is advised to have longer thermocouple and resistivity wires (> 70 mm). It also helps to make the Pt/Rh (+ve terminal) wire slightly longer, by ~ 5 mm, than the Pt (-ve terminal) for easy identification. Note, the Pt/Rh (+ve) wire also needs to be at the top of the sample, to prevent erroneous hot-spots forming along the sample length.
- Create holders to support the thermocouple and resistivity connectors. If the connectors are pulling on the thermocouple wires, this is likely to pull them off during the experiment. So, use tape/metal objects to support the thermocouple connectors. It is also easier to insert the wires into the connector during the experiment if the connectors are upside down.
- Write out the testing methods. **Note, methods cannot be copied from the Manchester ETMT software**. Copying methods from different software can lead to errors and ouputting the data. Check these methods run and output the data in the correct format.
- Check the connections into the computer are correct. There is a split connector for the thermocouple running into the back of the Eurotherm controller. In case of R-type the two orange connectors should connect into T/C-1 and T/C-2. However, in the case of K-type thermocouple it seems a connector with a looped wire is used to 'trick' the Eurortherm readout. Therefore, it is important to check the Eurotherm readout is showing what is expected.
- Check you are recording the Eurotherm temperature. The Eurotherm temperature is more accurate than the ETMT (controller) readout, with typically ~ 10 to 15 degrees difference. This is because the Eurotherm temperature can only be recorded at ~ 20 Hz, which is too slow to control during fast tests. Nevertheless, the Eurotherm temperature can be recorded as "Tempearture (Controller 1)" in Channels for corrected the data.
- Check you can record the voltage output. The voltage output from two resistivity wires of the same type, e.g. Pt-Pt or Cu-Cu, can record phase changes in the sample and the plastic strain, see (Christopher S. Daniel EngD Thesis)[https://www.research.manchester.ac.uk/portal/en/theses/an-investigation-into-the-texture-development-during-hotrolling-of-dualphase-zirconium-alloys(416cf1d6-15de-41d0-ad7c-3d0db664ae84).html]. The BNC cable will need to be connected. And the calibration will need running with either High or Low voltage and a maximum of ~ 0.5 Volts.
- Check the 
- Calibrate the PID settings. The PID settings for the different materials and sample geometries can vary. Calibrate these prior to the experiment to reduce time on the beamline.


## Typical PID settings



