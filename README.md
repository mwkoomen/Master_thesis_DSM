# Mitigating panel attrition with synthetic data
## Statistical disclosure control for linked panel survey and register data
### Master thesis in Applied Data Science & Measurement (Mannheim Business School)

- Main thesis text [here](Mitigating_panel_attrition_with_syndata.pdf) (pdf)

### Code and guide for reproduction

Data for this master thesis are not publically available. However, the code can be run by downloading the TREE2 scientific-use-files, available for download [here](https://www.swissubase.ch/en/catalogue/studies/12476/17413/datasets/1255/2026/overview). After downloading the data, add the data preparation function to your work directory: 

1. Function for data merging and preparation [here](data_tree_ext.R) (Rscript)

Next, two loops for finding the optimal variable visit sequence and synthesis modelling should be run consecutively (warnring, these loops are computatinally intensive and will likely run for multiple weeks, code to estimated runtime is included) 

2. Loop to find optimal variable sequence [here](find_sequence.R) (Rscript)
3. Loop to find optimal synthesis models [here](find_model.R) (Rscript)

After these loops are completed, the function to calculate the TCAP can be added to the work directory:

4. Function to calculate the Targeted Correct Attribution Probability [here](tcap.R) (Rscript)

Last, putting it all together, a pdf can be compiled by running the Rmarkdown file below:

5. Code to compile pdf [here](master_thesis.Rmd) (Rmarkdown)

### Info on the R-session used for compilation: 

R version 4.2.1 (2022-06-23 ucrt) <br> 
Platform: x86_64-w64-mingw32/x64 (64-bit) 
Running under: Windows 10 x64 (build 19045)

Matrix products: default

locale:
LC_COLLATE=German_Switzerland.utf8 
LC_CTYPE=C                         
LC_MONETARY=German_Switzerland.utf8
LC_NUMERIC=C                       
LC_TIME=German_Switzerland.utf8    

attached base packages: <br>
| | |
|:-------------|:-------------|:-------------|
| stats        |  graphics    | grDevices utils  |
| datasets     |    methods   |   base       |

other attached packages:
 [1] arm_1.13-1        lme4_1.1-31      
 [3] Matrix_1.4-1      MASS_7.3-57      
 [5] tidytext_0.3.4    gridExtra_2.3    
 [7] sjlabelled_1.2.0  gghighlight_0.4.0
 [9] rmarkdown_2.18    nnet_7.3-18      
[11] DescTools_0.99.47 expss_0.11.4     
[13] maditr_0.8.3      synthpop_1.8-0   
[15] forcats_0.5.2     stringr_1.4.1    
[17] dplyr_1.0.10      purrr_0.3.5      
[19] readr_2.1.3       tidyr_1.2.1      
[21] tibble_3.1.8      ggplot2_3.4.0    
[23] tidyverse_1.3.2   rio_0.5.29       
