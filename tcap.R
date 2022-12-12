# TCAP function ####

#Function to calculate the Targeted Correct Attribution Probability
  # Should be saved in work directory
  # Returns synthetic data set with TCAP score per row

#load libraries ####
library(rio)
library(tidyverse)
library(synthpop)

#tcap function ####
tcap <- function (syn,obs,key,target) { 
  #function takes four arguments:
    #syn    = synthetic data (data.frame)
    #obs    = observed data (data.frame)
    #key    = key variables on which data is matched (numeric vector)
    #target = target variables that are at risk of disclosure (numeric vector)
  #Calculate WEAP
    l.syn <- nrow(syn)      #number of records in synthetic data
    syn$weap <- 0           #create new variable in synthetic data (weap)
    k.line1 <- "nrow(syn["  #create string to build WEAP function denominator line 
    for (k in key){         #cycle through key variables 
      if (k!=key[length(key)]) { 
        k.line1 <-  paste0(k.line1,"syn[,",k,"]==syn[r,",k,"] & ")       
      }
      else {k.line1 <-  paste0(k.line1,"syn[,",k,"]==syn[r,",k,"]")}
    }
    t.line1 <- paste(k.line1,"& ") #create string to build WEAP function numerator line 
    for (t in target){             #cycle through target variables 
      if (t!=target[length(target)]) {    
        t.line1 <-  paste0(t.line1,"syn[,",t,"]==syn[r,",t,"] & ")
      }
      else {t.line1 <-  paste0(t.line1,"syn[,",t,"]==syn[r,",t,"],])")}
    }
    k.line1 <- paste0(k.line1,",])")
    for (r in 1:nrow(syn)){     #calcuate WEAP per record 
      k.row1 <- eval(parse(text=k.line1))
      t.row1 <- eval(parse(text=t.line1))
      syn[r,"weap"] <- t.row1/k.row1
    }
    syn <- syn[syn$weap==1,]    #keep cases with WEAP = 1 
  #Calculate TCAP
    syn$tcap_score <- 0          #create new variable in syn data (tcap)
    k.line2 <- "nrow(obs["       #create string to build TCAP function denominator line 
    for (k in key){              #cycle through key variables 
      if (k!=key[length(key)]) {
        k.line2 <-  paste0(k.line2,"obs[,",k,"]==syn[r,",k,"] & ")       
      }
      else {k.line2 <-  paste0(k.line2,"obs[,",k,"]==syn[r,",k,"]")}
    }
    t.line2 <- paste(k.line2,"& ")#create string to build TCAP function numerator line
    for (t in target){            #cycle through target variables
      if (t!=target[length(target)]) {
        t.line2 <-  paste0(t.line2,"obs[,",t,"]==syn[r,",t,"] & ")
      }
      else {t.line2 <-  paste0(t.line2,"obs[,",t,"]==syn[r,",t,"],])")}
    }
    k.line2 <- paste0(k.line2,",])")  
    for (r in 1:nrow(syn)){      #calcuate TCAP per record 
      k.row2 <- eval(parse(text=k.line2))
      t.row2 <- eval(parse(text=t.line2))
      if (k.row2==0){syn[r,"tcap_score"]<-0}
      else {syn[r,"tcap_score"] <- t.row2/k.row2}
    } 
  print(paste("Synthetic data - ",nrow(syn),"rows retained: TCAP score: ",mean(syn$tcap_score)))
  return(syn)   #return syn data with TCAP scores
}
