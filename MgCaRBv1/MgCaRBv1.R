# welcome to MgCaRBv1!

#the package 'seacarb' must be installed. To install run the line below (this only needs to be done once):
#install.packages('seacarb', repos='https://cloud.r-project.org', dependencies=TRUE)

#load up the two functions
load('MgCaRB.pCO2.Rdata') #load the pCO2 function 
load('MgCaRB.d11B.Rdata') #load the d11B function 

#you're now ready to go!

#heres an example with pCO2
#for one data point
MgCaRB.pCO2(species='grbw', age=20, age_err=0.3, mgca=4, mgca_err=0.02, DpCO2=0, ALK=2350, S=35)

#and using the test data (this is artifical data)
dat<- read.csv('testdata_pCO2.csv') #import the test data 

MgCaRB.pCO2(species='grbw', age=dat$age, age_err=0.3, mgca=dat$mgca, mgca_err=0.01*dat$mgca, DpCO2=0, ALK=2350, S=35)


#heres an example with d11B
#for one data point
MgCaRB.d11B(species='grbw', age=20, age_err=0.3, mgca=4, mgca_err=0.01, d11BOH4=21.5,d11BOH4_err=0.11, S=35)

#and using the test data (this is artifical data)
dat<- read.csv('testdata_d11B.csv') #import the test data 
MgCaRB.d11B(species='grbw', age=dat$age, age_err=0.3, mgca=dat$mgca, 0.01*dat$mgca, d11BOH4=dat$d11BOH4, d11BOH4_err=0.11,  S=35)