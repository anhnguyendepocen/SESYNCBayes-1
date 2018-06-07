rm(list=ls())
library(rjags)
library(tidyverse)
library(boot)
library(arm)
set.seed(23)

Beta=c(-.6,.05)
sigma = .02
x=seq(1,6)
mu=inv.logit(Beta[1] + Beta[2]*x)
plot(x,mu)
a <-(mu^2-mu^3-mu*sigma^2)/sigma^2
b <- (mu-2*mu^2+mu^3-sigma^2+mu*sigma^2)/sigma^2

n=20
n.year = 6
c=1
z=matrix(nrow=n*n.year,ncol=2)
for(t in 1: n.year){
  for(i in 1:n){
    z[c,1]=rbeta(1,a[t],b[t])
    z[c,2]=t
    c=c+1
  }
  
}

plot(z[,2],z[,1])
lines(x,mu)
#make ordinal data
y <- z
y[,1][z[,1] < .35] <- 1

y[,1][z[,1] >= .35 & z[,1] < .38] <- 2

y[,1][z[,1] >= .38 & z[,1] < .41] <- 3

y[,1][z[,1] >= .41 & z[,1] < .45 ] <- 4
y[,1][z[,1] >= .45] <- 5


# Threshold 1 and nYlevels-1 are fixed; other thresholds are predicted.
# This allows all parameters to be interpretable on the response scale.
nYlevels = max(y[,1])  
thresh = rep(NA,nYlevels-1)
thresh[1] =  0.35  #results are very sensitive to these choices--they must be assumed to be known
thresh[nYlevels-1] = .45
# Specify the data in a list, for later shipment to JAGS:
dataList = list(
  y = y[,1],
  x = y[,2],
  nYlevels = nYlevels ,
  thresh = thresh
)

inits= list(
  list( beta=c(-2,.05), sigma = .05, thresh=c(NA,.2,.3,NA))
)

sink("ordinal_model2.R")
cat("model {
    beta[1] ~ dnorm(0,.0001)
    beta[2] ~ dnorm(0,.0001)
    sigma ~ dunif(.01,.5)
    for (i in 1:length(y)) {
    mu[i] = ilogit(beta[1] + beta[2]*x[i])
    a[i] <-max(.00001,(mu[i]^2-mu[i]^3-mu[i]*sigma^2)/sigma^2)
    b[i] <- max(.00001,(mu[i]-2*mu[i]^2+mu[i]^3-sigma^2+mu[i]*sigma^2)/sigma^2 )
    y[i] ~ dcat( pr[i,1:nYlevels])
    y.sim[i] ~ dcat( pr[i,1:nYlevels])
    pr[i,1] <- pbeta( thresh[1], a[i] , b[i])
    for ( k in 2:(nYlevels-1) ) {
    pr[i,k] <- max(.00001, pbeta( thresh[ k ] , a[i] , b[i]) - pbeta( thresh[k-1] , a[i] , b[i] )) 
    }
    pr[i,nYlevels] <- 1 - pbeta( thresh[nYlevels-1] , a[i] , b[i] )
    }
    mean.y = mean(y)
    mean.sim = mean(y.sim)
    sd.y = sd(y)
    sd.sim = sd(y.sim)
    p.mean = step(mean.sim-mean.y)
    p.sd = step(sd.sim - sd.y)
    
    for ( k in 2:(nYlevels-2) ) {  # 1 and nYlevels-1 are fixed, not stochastic
    thresh0[k] ~ dunif(0,1)
    }
    #assure threholds meet ordering constraint
    thresh[2:(nYlevels-2)] = sort(thresh0[2:(nYlevels-2)])
    }
    ",fill=TRUE)
sink()

jm=jags.model("ordinal_model2.R", data=dataList, n.adapt=1000, n.chains = 3)
update(jm, n.iter=15000)
zc=coda.samples(jm, variable.names = c("thresh","sigma", "beta"), n.iter=15000)
gelman.diag(zc, multivariate = FALSE)
zj=jags.samples(jm,variable.names=c("y.sim", "p.mean", "p.sd"), n.iter=15000)
summary(zc)
par(mfrow=c(2,1))
discrete.histogram(y[,1],freq=FALSE,breaks=10, main = "Data")
discrete.histogram(zj$y.sim,freq=FALSE,breaks=10, main = "Simulated data")
zj$p.mean
zj$p.sd
