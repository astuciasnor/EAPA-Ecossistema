# Interactive effects of temperature and food ration on growth and mercury concentration in eastern brook trout

Dataset DOI: [10.5061/dryad.v6wwpzh86](10.5061/dryad.v6wwpzh86)

## Description of the data and file structure

This dataset and analysis evaluate the brook trout mercury (Hg) experiments presented  by Rutledge et al. 2025. Interactive Effects of Temperature and Food Ration on Specific Growth and Mercury Concentration in Eastern Brook Trout. *CJFAS*. The focus of the laboratory experiment used manipulations of water temperature and food ration treatments to see how Hg concentration changed in brook trout.

### Files and variables

#### File: Rutledge_etal_2025CJFAS_Rproj.zip

**Description:** 

This zipfile contains an RStudio R Project directory. At the top directory level, there are three main files.

1. The first is the R Project file named "Rutledge_etal_2025CJFAS_Rproj.Rproj". Open this project file within RStudio.
2. The second and third files are named similarly but represent .Rmd and .html file types. The .Rmd file named "*bkt_hg_temp_ration_experiment_analysis.Rmd*" contains the R code chunks for data import, manipulation, statistical analysis, and figure generation for the paper. The HTML version of the file ("*bkt_hg_temp_ration_experiment_analysis.html*") is a knitted version of the .Rmd file for easy viewing of the analysis code. These files contain sections for each of the two experiments in the paper. Additionally, for each experimental data set, there is a metadata dictionary for the imported data sets.

The top directory also contains 5 subdirectories. These are:

1. **data** - contains four data files that represent the raw data produced by the two experiments. each experiment has an .RDS file to easily import the data into R and a corresponding .csv file that presents the same data in a more shareable format for most operating system spreadsheet software options.
   1. ***Experiment One data files*** contain the following variables:
      1. ***PIT:*** pit tag identifier for each individual fish.
      2. ***tank:*** the experimental tank the individual fish was within for the duration of the experiment.
      3. ***Hg:*** brook trout mercury muscle tissue concentration in ng per g of dry weight.
      4. ***temperature:*** the mean temperature of the water measured in the tank across the duration of the study in degrees Celsius.
      5. ***tempfac:*** classification for temperature treatments as a factor (16, 18, 20, 22, 24 degrees C).
      6. ***tot_tank_consumption:*** the total mass (g) of food fed to a treatment across the duration of the experiment.
      7. ***day00massg:*** mass (g) of individual fish at the start of the experiment
      8. ***day24massg:*** mass (g) of individual fish at the end of the experiment
      9. ***conv_eff:*** tank-based conversion efficiency for fish (unitless value)
      10. ***growth_spe:*** specific growth rate for individual brook trout calculated as the ((ln(day24massg)-ln(day00massg))/24days)*100.

      <br />
   2. ***Experiment Two data files*** contain the following variables:
      1. ***PIT:*** pit tag identifier for each individual fish.
      2. ***tank:*** the experimental tank the individual fish was within for the duration of the experiment.
      3. ***Hg:*** brook trout mercury muscle tissue concentration in ng per g of dry weight.
      4. ***temperature:*** the mean temperature (degrees C) of the water measured in the tank across the duration of the study.
      5. ***tempfac:*** classification for temperature treatments as a factor (16, 18, 20, 22, 24 degrees C).
      6. ***ration:*** mass (g) of food fed to an individual fish as an average value for a given tank.
      7. ***rationfac:*** classification for ration treatments as a factor ("zero", "low", or "high").
      8. ***day00massg:*** mass (g) of individual fish at the start of the experiment
      9. ***day30massg:*** mass (g) of individual fish at the end of the experiment
      10. ***growth_spe:*** specific growth rate for individual brook trout calculated as: ((ln(day30massg)-ln(day00massg))/30days)*100.
      11. ***growth_abs:*** absolute growth change for individual brook trout calculated as: day30massg-day00massg.
      12. \***conv_eff: ***tank-based conversion efficiency for fish (unitless value)
      13. ***growth_abs_tnk_rnk:*** absolute growth difference rank for individual fish within a given tank. Values range from 1-10, with fish ranked near 1 having larger absolute growth differences between the start and end of the experiment, and fish ranked closer to 10 having smaller absolute growth differences.
      14. ***VARIABLE_s:*** named variable (in place of "*VARIABLE*") scaled to a mean of 0 and standard deviation of 1, appended with a "_s" to distinguish from the raw units column. 

      <br />
2. **figs** -  the figures generated in the paper will be populated here as both PNG and EPS file types if this R script is run.
3. **fnx** - contains a function .R file written for fitting and visualizing piecewise regression models specific to this data set. This is sourced in the .Rmd file.
4. **sessionInfo** - contains one text file with the "sessionInfo()" output for the R project. This file lists the R packages and their version numbers, as well as the R version and computer operating system used when this data package was published.
5. **tables** - contains a .csv file with the data supporting Table 1 from the paper.

## Code/software

This data package used R (v4.5.0) and RStudio (v2024.12.1) to complete the data analysis and visualization. Additionally, the R Project session information is populated in the data product as noted above with each R package and its version number to help future users maintain R package versions for transferability and compatibility of the data analysis when attempting to rerun the analyses with the associated data set.

## Access information

Data were all derived from experimental laboratory analyses and are not located anywhere else for access.