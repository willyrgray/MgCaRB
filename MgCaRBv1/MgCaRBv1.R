# welcome to MgCaRBv1!

#the package 'seacarb' must be installed. To install run the line commented out below (this only needs to be done once):
#install.packages('seacarb', repos='https://cloud.r-project.org', dependencies=TRUE)

#load up the two MgCaRB functions
load('MgCaRB.pCO2.Rdata') #load the pCO2 function 
load('MgCaRB.d11B.Rdata') #load the d11B function 

#you're now ready to go!

#heres an example with pCO2
#for one data point
MgCaRB.pCO2(species='grbw', age=20, age_err=0.3, mgca=4, mgca_err=0.02, DpCO2=0, ALK=2350, S=35)

#and using the test dataset (this is artifical data)
dat<- read.csv('testdata_pCO2.csv') #import the test data 

results<- MgCaRB.pCO2(species='grbw', age=dat$age, age_err=0.3, mgca=dat$mgca, mgca_err=0.01*dat$mgca, DpCO2=0, ALK=2350, S=35) # run the function passing the age and mg/ca from the imported data
print(results) #print the results

write.table(data.frame(age=dat$age, results), 'testdata_pCO2_results.csv', sep=',', row.names=FALSE) #export the results


#heres an example with d11B
#for one data point
MgCaRB.d11B(species='grbw', age=20, age_err=0.3, mgca=4, mgca_err=0.01, d11BOH4=21.5,d11BOH4_err=0.11, S=35)

#and using the test dataset (this is artifical data)
dat<- read.csv('testdata_d11B.csv') #import the test data 

results<- MgCaRB.d11B(species='grbw', age=dat$age, age_err=0.3, mgca=dat$mgca, 0.01*dat$mgca, d11BOH4=dat$d11BOH4, d11BOH4_err=0.11,  S=35) #run the function passing the age, mg/ca, and d11B from the imported data
print(results) #print the results

write.table(data.frame(age=dat$age, results), 'testdata_d11B_results.csv', sep=',', row.names=FALSE) #export the results