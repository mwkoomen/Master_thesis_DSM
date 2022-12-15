# Mitigating panel attrition with synthetic data
## Statistical disclosure control for linked panel survey and register data
### Master thesis in Applied Data Science & Measurement (Mannheim Business School)

- Author: Maarten Koomen
- Main thesis text [here](Mitigating_panel_attrition_with_syndata.pdf) (pdf) <br> <br>

### Code and guide for reproduction

The data needed to reproduce this master thesis are not publically available. However, the code can be run by downloading the TREE2 scientific-use-files, available for download [here](https://www.swissubase.ch/en/catalogue/studies/12476/17413/datasets/1255/2026/overview). After downloading the data, add the data preparation function to your work directory: 

1. Function for data merging and preparation [here](data_tree_ext.R) (Rscript)

Next, two loops for finding the optimal variable visit sequence and synthesis modelling should be run consecutively (warning, these loops are computationally intensive and will likely run for multiple weeks, code to estimated runtime is included) 

2. Loop to find optimal variable sequence [here](find_sequence.R) (Rscript)
3. Loop to find optimal synthesis models [here](find_model.R) (Rscript)

After these loops are completed, the function to calculate the TCAP can be added to the work directory:

4. Function to calculate the Targeted Correct Attribution Probability [here](tcap.R) (Rscript)

Last, putting it all together, a pdf can be compiled by running the Rmarkdown file below:

5. Code to compile pdf [here](Mitigating_panel_attrition.Rmd) (Rmarkdown)
<br> <br> 

### Info on the R-session used for compilation: 

> R version 4.2.1 (2022-06-23 ucrt) <br> 
> Platform: x86_64-w64-mingw32/x64 (64-bit) <br> 
> Running under: Windows 10 x64 (build 19045) <br> 
> Matrix products: default

locale:
>LC_COLLATE=German_Switzerland.utf8, LC_CTYPE=C                         
>LC_MONETARY=German_Switzerland.utf8, LC_NUMERIC=C                       
>LC_TIME=German_Switzerland.utf8    

attached base packages: <br>
<table align="left">
    <tr>
        <td align="left">stats</td>
        <td align="left">graphics</td>
        <td align="left">grDevices utils</td>
    </tr>
    <tr>
        <td align="left">datasets</td>
        <td align="left">methods</td>
        <td align="left">base</td>
    </tr>
</table>
<br>
<br>
<br>
<br>
other attached packages: 
<br>
<table align="left">
    <tr>
        <td align="left">arm_1.13-1</td>
        <td align="left">lme4_1.1-31</td>
    </tr>
    <tr>
        <td align="left">Matrix_1.4-1</td>
        <td align="left">MASS_7.3-57</td>
    </tr>
    <tr>
        <td align="left">tidytext_0.3.4</td>
        <td align="left">gridExtra_2.3</td>
    </tr>
    <tr>
        <td align="left">sjlabelled_1.2.0</td>
        <td align="left">gghighlight_0.4.0</td>
    </tr>
    <tr>
        <td align="left">rmarkdown_2.18</td>
        <td align="left">nnet_7.3-18</td>
    </tr>
    <tr>
        <td align="left">DescTools_0.99.47</td>
        <td align="left">expss_0.11.4</td>
    </tr> 
    <tr>
        <td align="left">maditr_0.8.3</td>
        <td align="left">synthpop_1.8-0</td>
    </tr>
    <tr>
        <td align="left">forcats_0.5.2</td>
        <td align="left">stringr_1.4.1</td>
    </tr> 
    <tr>
        <td align="left">dplyr_1.0.10</td>
        <td align="left">purrr_0.3.5</td>
    </tr>
    <tr>
        <td align="left">readr_2.1.3</td>
        <td align="left">tidyr_1.2.1</td>
    </tr> 
    <tr>
        <td align="left">tibble_3.1.8</td>
        <td align="left">ggplot2_3.4.0 </td>
    </tr>
    <tr>
        <td align="left">tidyverse_1.3.2</td>
        <td align="left">rio_0.5.29</td>
    </tr>  
</table>         
