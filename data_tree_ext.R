# Master thesis data prep ####

#Main data preparation function
  #!Workdirectory should be set

# load libraries ####
library(rio)
library(tidyverse)

# import function ####
import.tree <- function(){
  
  setwd("xxx") # Set workdirectory where datafiles are saved
  
  #import 
  import <- c("Wave_0","Wave_1","Wave_2","Weights")
  for (i in import){
    assign(i, rio::import(paste0("TREE2_Data_Stata_",i,"_v1.dta")))
    print(paste("Imported TREE data:",i,"- Rows:",nrow(get(i)),"- Columns:",ncol(get(i))))
  }
  rm(i)
  #merge   
  c <- 0
  r <- 8429
  obs <- Wave_0
  for (i in import){
    c <- c + ncol(get(i))
    if (i !="Wave_0") {    
      c <- c-1
      obs <- merge(obs, get(i), by="resp_id")
    }
    print(paste("Merging data:",i,"- Rows:",nrow(obs),"- Columns:",ncol(obs)))
    print(paste("Columns missing:",ncol(obs)!=c))
    print(paste("Rows missing:",nrow(obs)!=r))
  }
  varlist <- c("resp_id",          #1
               "t0sex",            #2
               "t0wlem",           #3
               "t0st_nprog_req",   #4
               "t0hisei08",        #5
               "t0hisced97_comp",  #6
               "t0immig",          #7
               "t0wealth_m_fs",    #8
               "t0joyreadp_comp",  #9 
               "t0fasiii_comp",    #10
               "t1bqvalids",       #11
               "t1educ_class_1",   #12
               "t1educ_class_2",   #13
               "t1educ_class_3",   #14
               "t2educ_class_1",   #15
               "t2educ_class_2",   #16
               "t2educ_class_3",   #17
               "t0aspmf",          #18
               "t0aspideal_comp",  #19
               "t0inccap_fs",      #20
               "aes_langreg.x",    #21
               "t0marklang1",      #22
               "t0markmath",       #23
               "t0markscience"     #24
  )
  obs <- obs[,varlist]
  #langreg 
  obs$aes_langreg.x[obs$aes_langreg.x==3] <- 2 
  #marks mean 
  obs <- obs %>% mutate(
    marks=case_when(
      t0marklang1 > 0 & t0markmath > 0 & t0markscience > 0 ~ (t0marklang1+t0markmath+t0markscience)/3,
      t0marklang1 > 0 & t0markmath > 0 & t0markscience < 0 ~ (t0marklang1+t0markmath)/2,
      t0marklang1 > 0 & t0markmath < 0 & t0markscience > 0 ~ (t0marklang1+t0markscience)/2,      
      t0marklang1 < 0 & t0markmath > 0 & t0markscience > 0 ~ (t0markmath+t0markscience)/2,      
      t0marklang1 > 0 & t0markmath < 0 & t0markscience < 0 ~ t0marklang1,
      t0marklang1 < 0 & t0markmath > 0 & t0markscience < 0 ~ t0markmath,
      t0marklang1 < 0 & t0markmath < 0 & t0markscience > 0 ~ t0markscience
    )
  )
  
  #t0 parental educ 
  obs <- obs %>% mutate(
    pareduc=case_when(
      t0hisced97_comp <= 3 ~ 0,
      t0hisced97_comp > 3 ~ 1, 
      TRUE ~ t0hisced97_comp
      )
  )    
  #t0 sekI school req
  obs <- obs %>% mutate(
    ls_req=case_when(
      t0st_nprog_req==0 | t0st_nprog_req==5 ~ 4,
      t0st_nprog_req==1 ~ 1, 
      t0st_nprog_req==2 ~ 2,
      t0st_nprog_req==3 | t0st_nprog_req==4 ~ 3,      
      TRUE ~ t0st_nprog_req
      )
  )
  #t1 educ epi 1 
  obs <- obs %>% mutate(
    us_enroll = case_when(
      t1educ_class_1 > 50 ~ 1,  
      t1educ_class_1 > 0 & t1educ_class_1 < 30 | t1educ_class_1 == 95 ~ 2,
      t1educ_class_1 >= 30 & t1educ_class_1 < 39 & 
        (t1educ_class_2 != 37 | is.na(t1educ_class_2)==T) & 
        (t1educ_class_3 != 37 | is.na(t1educ_class_3)==T) ~ 3,
      t1educ_class_1 >= 30 & t1educ_class_1 < 39 & t1educ_class_2 == 37 | t1educ_class_3 == 37 ~ 4,  
      t1educ_class_1 >= 39 & t1educ_class_1 <= 50 ~ 5,
      is.na(t1educ_class_1) == T & t1bqvalids == 1 ~ 0,
      is.na(t1educ_class_1) == T & t1bqvalids == 0 ~ 6
    )
  )
  #t1 educ epi 2 
  obs <- obs %>% mutate(
    us_enroll = case_when(
      us_enroll == 6 & t1educ_class_2 > 50 ~ 1,  
      (us_enroll <= 1 | us_enroll == 6) & t1educ_class_2 > 0 & t1educ_class_2 < 30 | t1educ_class_2 == 95 ~ 2,
      (us_enroll <= 2 | us_enroll == 6) & t1educ_class_2 >= 30 & t1educ_class_2 < 39 & 
        (t1educ_class_3 != 37 | is.na(t1educ_class_3)==T) ~ 3,
      (us_enroll <= 3 | us_enroll == 6) & t1educ_class_2 >= 30 & t1educ_class_2 < 39 & t1educ_class_3 == 37 ~ 4,  
      (us_enroll <= 4 | us_enroll == 6) & t1educ_class_2 >= 39 & t1educ_class_2 <= 50 ~ 5,
      TRUE ~ us_enroll 
    )
  )
  #t1 epi 3 not relevant 
  #t2 not included 
  rm(c,i,r,list=import)
  attributes(obs)$names <- sub("^t0", "", attributes(obs)$names)
  attributes(obs)$names <- sub("_comp$", "", attributes(obs)$names)
  attributes(obs)$names <- sub("_fs$", "", attributes(obs)$names)
  attributes(obs)$names <- sub("_m$", "", attributes(obs)$names)
  attributes(obs)$names <- sub("iii$", "", attributes(obs)$names)
  attributes(obs)$names <- sub("\\.x$", "", attributes(obs)$names) 
  attributes(obs)$names <- sub("^aes_", "", attributes(obs)$names) 
  rownames(obs)<-obs$resp_id    
  obs <- obs[,-c(1,4,6,11:17,22:24)]
  obs <- obs[,c(1,11,2,12,14,3,13,4:7,10,8,9,15)]
  return(obs)
}
