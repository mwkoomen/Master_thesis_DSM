# Loop to find optimal model 

# Main code to find best performing model per variable 
  #! Work directory needs to be set manually

#load libraries ####
library(rio)
library(tidyverse)
library(synthpop)
library(gghighlight)

#set work directory manually
wd <- "xxx"

#run data prep: needs data_tree_ext.R in work directory
source(paste0(wd,"/data_tree_ext.R"))
obs <- import.tree()

# parameters ####
m <- 5
set.seed(6541)
p <- c("parametric","cart")
m.grid <- expand.grid(p[2], #1
                      p,    #2
                      p,    #3
                      p,    #4  
                      p[2], #5
                      p[2], #6
                      p,    #7
                      p[1], #8
                      p[2], #9
                      p[2], #10
                      p[2], #11
                      p,    #12
                      p,    #13
                      p[1], #14
                      p,    #15
                      stringsAsFactors = F
                      )
vseq <- list(
  c(12, 3, 4, 2, 7, 1, 9, 6, 10, 11, 14, 8, 15, 13, 5),#1
  c(12, 3, 4, 2, 7, 1, 6, 11, 10, 9, 14, 8, 13, 15, 5),#2
  c(12, 4, 3, 7, 1, 2, 10, 6, 11, 9, 14, 8, 13, 15, 5),#3
  c(4, 12, 3, 7, 1, 2, 10, 11, 6, 9, 8, 14, 15, 5, 13),#4
  c(4, 12, 3, 7, 1, 2, 6, 10, 11, 9, 8, 14, 15, 5, 13),#5
  c(4, 12, 3, 1, 7, 2, 9, 10, 11, 6, 8, 14, 5, 13, 15),#6
  c(12, 3, 4, 7, 2, 1, 9, 11, 10, 6, 14, 8, 15, 5, 13),#best performing cart seq 
  c(3, 4, 12, 7, 2, 1, 10, 11, 6, 9, 14, 8, 13, 5, 15) #best performing par seq 
)
for (v in c(1,2,5,7,8,13,14,15)){
  obs[v] <- as.factor(obs[,v])
}
rm(v)

#estimate runtime  #####
start <- Sys.time()
test.model <- data.frame()
c <- 0
for (v in vseq){
  c <- c +1 
  k <- as.character(m.grid[1,])
  k[vseq[[c]][1]] <- "sample"
  syn <- syn(
    obs,
    m=5,
    method=k,
    visit.sequence = v
  ) 
  x <- data.frame(
    Sequence=toString(vseq),
    Model=toString(k),
    S_pMSE.c= mean(utility.gen(syn,obs,method = "cart", nperms=5, print.every = 1)$S_pMSE),
    S_pMSE.l= mean(utility.gen(syn,obs,method = "logit", maxorder = 0)$S_pMSE)
  )
  test.model <- rbind(test.model,x)
}
end <- Sys.time()
runtime <- end-start
print(paste0("Loop would run an estimated ", round((((128*runtime))/60)/24,digits=2), " days"))

# run full loop ####
test.model <- data.frame()
c <- 0
for (v in vseq){
  c <- c +1 
  for (g in 1:nrow(m.grid)){
    k <- as.character(m.grid[g,])
    k[vseq[[c]][1]] <- "sample"
    syn <- syn(
      obs,
      m=5,
      method=k,
      visit.sequence = v
    ) 
    x <- data.frame(
      Sequence=toString(v),
      Model=toString(k),
      pMSE.c = mean(utility.gen(syn,obs,method = "cart", nperms=5, print.every = 1)$pMSE),
      pMSE.l = mean(utility.gen(syn,obs,method = "logit", maxorder = 0)$pMSE),      
      S_pMSE.c= mean(utility.gen(syn,obs,method = "cart", nperms=5, print.every = 1)$S_pMSE),
      S_pMSE.l= mean(utility.gen(syn,obs,method = "logit", maxorder = 0)$S_pMSE)
    )
  test.model <- rbind(test.model,x)
  }
}
setwd(wd) 
save(test.model, file="test_model_redux4.RData")
