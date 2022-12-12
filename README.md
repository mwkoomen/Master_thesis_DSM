# Mitigating panel attrition with synthetic data
## Statistical disclosure control for linked panel survey and register data
### Master thesis in Applied Data Science & Measurement (Mannheim Business School)

- Main thesis text [here](Mitigating_panel_attrition_with_syndata.pdf) (pdf)

### Code and guide for reproduction

Data for this master thesis are not publically available. However, the code can be run by downloading the TREE2 scientific-use-files, available for download [here](https://www.swissubase.ch/en/catalogue/studies/12476/17413/datasets/1255/2026/overview). After downloading the data, add the data preperation function to your work directory: 

1. Code for data prep. [here](data_tree_ext.R) (Rscript)

Next, the loops for finding the optimal variable visit sequence and synthesis modelling should be run consecutively (warnring, these loops are computatinally intensive and will likely run for multiple weeks) 

2. Loop to find optimal variable sequence [here](find_sequence.R) (Rscript)
3. Loop to find optimal synthesis models [here](find_model.R) (Rscript)

4. Function to calculate the Targeted Correct Attribution Probability [here](tcap.R) (Rscript)
5. Code to compile pdf [here](master_thesis.Rmd) (Rmarkdown)

### R-session info: 
R version 4.2.1 (2022-06-23 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 19045)

Matrix products: default

locale:
[1] LC_COLLATE=German_Switzerland.utf8 
[2] LC_CTYPE=C                         
[3] LC_MONETARY=German_Switzerland.utf8
[4] LC_NUMERIC=C                       
[5] LC_TIME=German_Switzerland.utf8    

attached base packages:
[1] stats     graphics  grDevices utils    
[5] datasets  methods   base     

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

loaded via a namespace (and not attached):
  [1] minqa_1.2.5          TH.data_1.1-1       
  [3] googledrive_2.0.0    colorspace_2.0-3    
  [5] ellipsis_0.3.2       class_7.3-20        
  [7] modeltools_0.2-23    mipfp_3.2.1         
  [9] htmlTable_2.4.1      fs_1.5.2            
 [11] gld_2.6.6            rmutil_1.1.10       
 [13] rstudioapi_0.14      proxy_0.4-27        
 [15] SnowballC_0.7.0      fansi_1.0.3         
 [17] mvtnorm_1.1-3        lubridate_1.9.0     
 [19] coin_1.4-2           ranger_0.14.1       
 [21] xml2_1.3.3           codetools_0.2-18    
 [23] splines_4.2.1        rootSolve_1.8.2.3   
 [25] libcoin_1.0-9        knitr_1.40          
 [27] jsonlite_1.8.3       nloptr_2.0.3        
 [29] broom_1.0.1          dbplyr_2.2.1        
 [31] compiler_4.2.1       httr_1.4.4          
 [33] backports_1.4.1      assertthat_0.2.1    
 [35] fastmap_1.1.0        gargle_1.2.1        
 [37] strucchange_1.5-3    cli_3.4.1           
 [39] htmltools_0.5.3      tools_4.2.1         
 [41] coda_0.19-4          lmom_2.9            
 [43] gtable_0.3.1         glue_1.6.2          
 [45] broman_0.80          Rcpp_1.0.9          
 [47] cellranger_1.1.0     vctrs_0.5.0         
 [49] nlme_3.1-157         insight_0.18.6      
 [51] xfun_0.34            proto_1.0.0         
 [53] openxlsx_4.2.5.1     rvest_1.0.3         
 [55] timechange_0.1.1     lifecycle_1.0.3     
 [57] cmm_0.12             googlesheets4_1.0.1 
 [59] polspline_1.1.20     zoo_1.8-11          
 [61] scales_1.2.1         hms_1.1.2           
 [63] parallel_4.2.1       sandwich_3.0-2      
 [65] expm_0.999-6         Exact_3.2           
 [67] yaml_2.3.6           curl_4.3.3          
 [69] rpart_4.1.19         stringi_1.7.8       
 [71] tokenizers_0.2.3     randomForest_4.7-1.1
 [73] checkmate_2.1.0      e1071_1.7-12        
 [75] boot_1.3-28          zip_2.2.2           
 [77] truncnorm_1.0-8      rlang_1.0.6         
 [79] pkgconfig_2.0.3      matrixStats_0.62.0  
 [81] Rsolnp_1.16          evaluate_0.18       
 [83] lattice_0.20-45      htmlwidgets_1.5.4   
 [85] tidyselect_1.2.0     plyr_1.8.8          
 [87] magrittr_2.0.3       R6_2.5.1            
 [89] generics_0.1.3       multcomp_1.4-20     
 [91] DBI_1.1.3            pillar_1.8.1        
 [93] haven_2.5.1          foreign_0.8-82      
 [95] withr_2.5.0          abind_1.4-5         
 [97] survival_3.3-1       janeaustenr_1.0.0   
 [99] modelr_0.1.10        crayon_1.5.2        
[101] KernSmooth_2.23-20   utf8_1.2.2          
[103] party_1.3-11         tzdb_0.3.0          
[105] grid_4.2.1           readxl_1.4.1        
[107] data.table_1.14.4    reprex_2.0.2        
[109] digest_0.6.30        classInt_0.4-8      
[111] numDeriv_2016.8-1.1  stats4_4.2.1        
[113] munsell_0.5.0 
