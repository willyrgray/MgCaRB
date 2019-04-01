# MgCaRB
MgCaRB is a tool to calculate temperature from planktic foraminiferal Mg/Ca, accounting for the influences of pH and salinity.

To use, dowload the MgCaRB folder using the link above. Double click the 'MgCaRBv1.R' file to open it (you need to have R installed), and follow the instructions in the file.  
A Matlab script is available from https://github.com/dbjevans/MgCaRB.

The key component of the MgCaRB script is that it iteratively solves Mg/Ca and either boron isotopes or atmospheric CO2 (using ice core data) for temperature and pH. 
The function MgCaRB.pCO2 is used when using pCO2, and the function MgCaRB.d11B is used for boron isotopes. 
In both cases salinity is treated as a known, accounting for Glacial-Interglacial sea level changes. 
Underlying the use of atmospheric CO2 is the assumption that the core site has remained at equilibrium, or constant disequilibrium, with the atmosphere. 

Using Monte-Carlo simulation MgCaRB propagates uncertainties from Mg/Ca measurement, calibration, salinity (with prescribed error of ±1 PSU 2sigma), and carbonate chemistry. 
When using boron isotopes the uncertainty in the d11B of borate is given by the user. 
When using CO2 the user is required to give the modern disequilibrium from atmospheric CO2 and Alkalinity at the site. 
Uncertainty in ALK is prescribed as -25 to +75 umol/kg about the modern value, with a flat probability distribution; 
this is equivalent to the whole ocean G-IG range in the box model of Toggweiler 1999, scaled to a surface ocean/whole ocean salinity increase of 0.7/1 PSU. 
Error in DpCO2 is given as ±40 uatm (2sigma). 
Age error is accounted for when sampling the sea level curve or atmospheric CO2. 
Sea level data comes from the stack of Spratt and Lisiecki 2016 which spans the last 798 ka. 
Ice core CO2 data is given on the AICC2012 timescale, except for the period oldest section (see Bereiter et al 2014). 
The original references for the ice core data can be found in the icecoreCO2.csv file.  

Species specific equations for G. ruber (white), T. sacculifer, G. bulloides, and O. universa can be selected. 
The default equations for each species use the generic temperature and salinity sensitivity, and species specific pH sensitivities and 'intercepts'. 
Options are available to use equations with temperature and salinity sensitivities from the species specific regressions, however the uncertainties in these estimates are larger. 
As all of the species specific temperature and salinity sensitivities are all within error of each other, there doesn't seem to be a good reason to do this, but the option is there. 
For species that have not been calibrated in culture a 'generic' calibration is available; 
however this should only be used to look at relative temperature changes and given the effect of pH appears to be species specific, this calibration should only be used with caution.  

The citation for MgCaRBv1 is Gray and Evans, 2019, Paleoceanography and Paleoclimatology, 34. https://doi.org/ 10.1029/2018PA003517.

References

Bereiter et al., 2015, Geophysical Research Letters, DOI: 10.1002/2014GL061957

Spratt and Lisiecki, 2016, Climate of the Past, DOI: 10.5194/cp-12-1079/2016

Toggweiler 1999, Paleoceanography 14, 571-588 
