---
title: Tutorial for TOPAS to analyse phase fraction changes
author: Christopher Daniel
---

## Notes on manual fitting in TOPAS using the GUI

**1. Load scan files**
- In .raw format for XRD, or .xy format for SXRD.
- Load scan files option found under *‘File’* tab. Can load more than one scan at a time or refine each pattern separately.
- Options to change settings in global (changes all at once across all scans), or you can change each scan individually.

**2. Emission profile**
- If Lab-XRD data, then load *‘emission profile’* for each of the scans (CoKa3.Iam is the standard Cobalt emission profile). This builds the profile of apolychromatic source by sharing the beam composition.
- If SXRD data, only one profile is needed in *‘emission profile’*, since it is monochromatic, so the second profile can be deleted.
- Change the area to 0.01, wavelength to 0.1391986 angstrom, Lortz/area to 0.01 (lowest possible), delete other column.
- Set Ymin – Ymax as 1 e-5 in emission profile options, which defines the ratio of peak to width. Sharp peaks in SXRD mean low value of 1 e-5 is appropriate.
- *Note, @ is used to refine a parameter.*

**3. Background**
- Set Chebychev order 5 and tick 1/x bkg and refine with 1000 steps. The 1/x background corrects for large background at low scattering angles in L-XRD.

**4. Instrument**
- For XRD set radius of 33 cm (330 mm) for the distance of the primary and secondary goniometer arms (for Bruker D8-Discover).  Select linear PSD and refine. Use simple axial model, due to effect of conical beam of varying intensity, to account for the umbrella effect of the diffraction cone within the Ewald sphere, where intensity can vary depending on source/detector position.
- For SXRD untick point detector. Beam delivering slits in EH1 at Diamond I12 mean R-primary = 47 m (47000 mm) and sample-detector distance mean R-secondary = 1500 mm for Zr or 12000 mm for Ti. Use simple axial model with default value of 12.

**5. Corrections**
- For XRD tick Lorentz-Polarisation (LP) factor and change to 0. A graphite monochromator = 26.4
- For SXRD change LP factor to 90 and fix.
- 2th correction for sample displacement. Corrects for sample Z height (defining zero position). Start at zero, only refine at the end. Not required for SXRD, but certainly needed for XRD setup.
- Option to tick zero order error in peak shift to improve fit. Zero error occurs due to slight detector misalignment between the actual zero position of the goniometer versus what the microswitch believes is zero.

**6. Miscellaneous**
- 0.0001 calculation steps (finer will slow refinement down, coarser could lead to square peaks).
- Set start x = 2.4$^\circ$ and finish x = 8.94$^\circ$ for the range of 2-theta.

**7. Load cifs and refine**
- Load cifs by right clicking in the scan experiment.
- For two-phase materials, first start with only alpha-phase and refine the parameters, then tick use the beta phase cif and to improve the fit to the second phase.
- Untick crystal size steps (switch off). Choose peak type = PV_TCHZ, which combines L and G (Lorentzian and Gaussian). TCHZ Thompson-Cox-Hastings psuedo-Voight is best for L-XRD and SXRD. Pseudo-Voigt is fast, but not the best fit. For sycnhrotron may also use PVII (Pearson 7), but this can go awry.
- Firstly, fix cell parameters and refine only the scale parameters. Scale governs magnitude of peak intensites based on a convolution of the various structural parameters. Leave preferred orientation turned off.
- Then, refine cell params and add in texture if needed. Try increasing preferred orientation from order 2, 4 and 6 (maybe 8 for very strong alignment).

**8. Goodness of fit**
- A value of Rwp < 15 is a good result. But, the fitting quality is better determined by the goodness of fit (GOF). Generally GOF < 2 is considered excellent, < 3 is acceptable and < 1 is beginning to over-constrain the model fitting.
*Note, possible error (cannot find file in isotopes.txt) is due to missing atomic sites, such as a Ti atom needing to be filled in in the SITES option. Another error can also arise due to cubic phase missing a hyphen Im3m = Im-3m.*

** 9. Save analysis as .pro file**
- For reloading in TOPAS

## Setting up TOPAS in batch mode

**1. Download jedit 4.3**
- See John Evans TOPAS jEdit Install for instructions - https://community.dur.ac.uk/john.evans/topas_academic/jedit_setup.htm
- *Note, there is a problem with the plugins disappearing.*

**2. Use TOPAS5 (version 5.0)**

**3. Create TOPAS .inp analysis file**
- Use example .inp file for Ti-64 or Zr-2.5Nb materials and open in jEdit.
- *Note, commented instructions are included throughout the .inp file.*
- In java the **’** signals a commented line. To load an individual fit, uncomment ‘macro filename’ and give the absolute path to the .xy data file. To run batch mode comment out ‘macro filename’ to reference different data files.
- *‘#define report’* at the top writes out a report, with the contents defined at the bottom *‘#ifdef report...’*
- Results for named parameters can be included in the output report - **results.txt**
- The command xdd runs the analysis on the given filename.
- @ means refine, no @ means fix.
- If named value then ! is needed to fix it, i.e. ba1 will refine, !ba1 is fixed.
- Set zero background (5 zeros for refining 5 parameters) - *bkg @ 0 0 0 0 0*
- Set zero 1/x, zero error, scale.
- Fix LP factor 90, specimen displacement 0, simple axial model 12, ymin - ymax 0.00001, wavelength  0.1391986, calculation step 0.0001.
- Delete spherical harmonics and replace with *‘PO_Spherical_Harmonics(sh_1, 6)’*
- Biso refinement not needed. *Note, to refine biso use Beq @ 0 min = 0*

**4. Run refinment for first .inp file**
- Open TOPAS5.
- Click on launch mode (rocket icon, right hand side).
- *‘Launch Mode: C:\ChrisBatch\ ...inp’* should appear.
- Click run (play icon, right hand side).

**5. Write batch mode as ‘batch.bat’ file using the script below**
- Assume working in C-drive, so change directory to *C:\TOPAS5*.
- *C:\TOPAS5\tc* launches an executable for refining external .inp files.
- Batch files should be located in a seperate folder on C-drive - *C:\ChrisBatch\*
- Each line of the batch file contains: ‘macro filename’ of current analysis, absolute path for the next .xy data files, filename for current analysis output, filename for current output .inp file.
- *‘pause’* leaves command window open at the end (rather than *‘end’* which would close it).

**6. Data organisation**
- C:\ChrisBatch\
    - .bat batch mode file
    - .inp file for first refined analysis
    - Data\
        - .xy data files
        
**7. Run batch mode**
- Double click .bat file.
