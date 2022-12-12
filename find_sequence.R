# Find Sequence 

# Main code to find best performing sequence 
    #! Work directory should be set manually
    # Code is computationaly demanding 

#load libraries ####
library(rio)
library(tidyverse)
library(synthpop)
library(gghighlight)

#set Workdirectory (set manually) 
wd <- "xxx"

#run data prep: ! needs data_tree_ext.R in Workdirectory
source(paste0(wd,"/data_tree_ext.R")) 
obs <- import.tree()

#sequence search grid ####
norm <- c(3,4,12)          #3 numeric variables with quasi-normal distribution 
bin <- c(1,2,7)            #3 binary variables 
num <- c(6,9,10,11)        #4 numeric variables with non-normal other distributions
fac <- c(8,14)             #2 factorial variables with 3 levels 
facl <- c(5,13,15)         #3 factorial variables with 4 levels or more

#estimate runtime  #####
start <- Sys.time()
syn_cart1 <- syn(obs,m=3,method="cart",visit.sequence=c(12,4,3,11,10,6,9,7,2,1,8,14,13,15,5))
syn_par1 <- syn(obs,m=3,method="parametric",visit.sequence=c(12,4,3,11,10,6,9,7,2,1,8,14,13,15,5))
fit_cart_c <- mean(utility.gen(syn_cart1,obs,method = "cart", nperms=5, print.every = 1)$S_pMSE)
fit_cart_l <- mean(utility.gen(syn_cart1,obs,method = "logit", maxorder = 0)$S_pMSE)
fit_par_c <- mean(utility.gen(syn_par1,obs,method = "cart", nperms=5, print.every = 1)$S_pMSE)
fit_par_l <- mean(utility.gen(syn_par1,obs,method = "logit", maxorder = 0)$S_pMSE)
end <- Sys.time()
runtime <- end-start
runs <- factorial(3)*factorial(3)*factorial(4)*factorial(2)*factorial(3)
print(paste0("Loop would run an estimated ", round((((runs*runtime))/60)/24,digits=2), " days"))

#ceate grids ####
norm.grid <- expand.grid(norm,norm,norm)
num.grid <-expand.grid(num,num,num,num)
bin.grid <- expand.grid(bin,bin,bin)
fac.grid <- expand.grid(fac,fac)
facl.grid <- expand.grid(facl,facl,facl)

#remove rows with duplicates 
norm.grid <- norm.grid[norm.grid$Var1 != norm.grid$Var2 &
    norm.grid$Var1 != norm.grid$Var3 & norm.grid$Var2 != norm.grid$Var3
    ,]
attributes(num.grid)$names <- c("Var4","Var5","Var6","Var7")
num.grid <- num.grid[num.grid$Var4 != num.grid$Var5 & 
    num.grid$Var4 != num.grid$Var6 & num.grid$Var4 != num.grid$Var7 &
    num.grid$Var5 != num.grid$Var6 & num.grid$Var5 != num.grid$Var7 &
    num.grid$Var6 != num.grid$Var7
    ,]
attributes(bin.grid)$names <- c("Var8","Var9","Var10")
bin.grid <- bin.grid[bin.grid$Var8 != bin.grid$Var9 &
    bin.grid$Var8 != bin.grid$Var10 & bin.grid$Var9 != bin.grid$Var10
  ,]
attributes(fac.grid)$names <- c("Var11","Var12")
fac.grid <- fac.grid[fac.grid$Var11 != fac.grid$Var12
  ,]
attributes(facl.grid)$names <- c("Var13","Var14","Var15")
facl.grid <- facl.grid[facl.grid$Var13 != facl.grid$Var14 &
  facl.grid$Var13 != facl.grid$Var15 & facl.grid$Var14 != facl.grid$Var15
  ,]
seq.grid <- merge(norm.grid, bin.grid, all=T)
seq.grid <- merge(seq.grid, num.grid, all=T)
seq.grid <- merge(seq.grid, fac.grid, all=T)
seq.grid <- merge(seq.grid, facl.grid, all=T)
nrow(seq.grid)==runs

#synth loop####
m <- 1
set.seed(6541)
#factorise variables 
for (v in c(bin,fac,facl)){
  obs[v] <- as.factor(obs[,v])
}
rm(v)
#v.seq <- c(norm,num,bin,fac,facl)

test.visit <- data.frame()
for (s in 1:nrow(seq.grid)){
  v.seq <- as.numeric(seq.grid[s,])
  #run synth model (CART)
  syn.cart <- syn(obs, 
                  m=m, 
                  method="cart",
                  visit.sequence=v.seq
  )
  
  #run synth model (parametric)
  syn.par <- syn(obs, 
                 m=m, 
                 method="parametric",
                 visit.sequence=v.seq
  )
  
  #compare synth and obs (univariate) ####
  x <- data.frame(
    Sequence=toString(v.seq), 
    S_pMSE.cc= mean(utility.gen(syn.cart,obs,method = "cart", nperms=5, print.every = 1)$S_pMSE),
    S_pMSE.cl= mean(utility.gen(syn.cart,obs,method = "logit", maxorder = 0)$S_pMSE),
    S_pMSE.pc= mean(utility.gen(syn.par,obs,method = "cart", nperms=5, print.every = 1)$S_pMSE),
    S_pMSE.pl= mean(utility.gen(syn.par,obs,method = "logit", maxorder = 0)$S_pMSE)
  )
  test.visit <- rbind(test.visit,x)
}
setwd(wd)
save(test.visit, file="test_vseq_ext.RData")
