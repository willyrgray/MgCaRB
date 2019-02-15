#MaCaRBv1 d11B function
MgCaRB.d11B<- function(species, age, age_err, mgca, mgca_err, d11BOH4, d11BOH4_err, S){ 
require(seacarb)
if(min(age) < -0.05 | max(age) > 798) {print('check age range/units!')} else
if(mean(age_err) > 99) {print('check age error units!')} else {

	#import S data
	esl_dat<- read.csv(paste(getwd(),'/spratt2016_esl.csv', sep='')) #use sprat2016
	esl_dat<- rbind(c(-0.05, esl_dat$esl[1]), esl_dat)
	Desl_total<- min(esl_dat$esl)-max(esl_dat$esl)
	esl_dat$DS_sl<-  esl_dat$esl*(0.7/Desl_total) #0.7 is mean surface change in S from model


	#settings
	pHambient<- 8.1
	pH_threshold<- 0.0001
	T_threshold<- 0.001

	#boron constants
	d11B_sw <- 39.61
	alpha_b <- 1.0272
	epsilon_b <- 1000*(alpha_b-1)
	
	#mgca constants
	#tsens, ssens, pHsens
	generic<-c(0.061249, 0.036136, -0.73150)
	grbw_gray2018<-c(0.059759, 0.03313, -0.83263)
	grbw_spc<-c(0.06388, 0.03538, -0.87005)
	tsac_spc<-c(0.062413, 0.053976, 0)
	gbul_spc<-c(0.06411, 0.032966, -0.87527)
	ouni_spc<-c(0.07461, 0.04004,-0.49577)
	grbw<-c(0.061249, 0.036136, -0.87309)
	tsac<-c(0.061249, 0.036136, 0)
	gbul<-c(0.061249, 0.036136, -0.87738)
	ouni<-c(0.061249, 0.036136, -0.50927)
	
	#mgca constants error 
	#tsens_err, ssens_err, pHsens_err
	generic_err<-c(0.005239, 0.006176, 0.07245)
	grbw_gray2018_err<-c(0.003763642, 0.011180065, 0.16933)
	grbw_spc_err<-c(0.01785, 0.01318, 0.11844)
	tsac_spc_err<-c(0.017841, 0.009464, 0.084416)
	gbul_spc_err<-c(0.03110, 0.006176, 0.13025)
	ouni_spc_err<-c(0.01210, 0.01427,0.12053)
	grbw_err<-c(0.005239, 0.006176,  0.10969)
	tsac_err<-c(0.005239, 0.006176,  0.084416)
	gbul_err<-c(0.005239, 0.006176,  0.12103)
	ouni_err<-c(0.005239, 0.006176, 0.11786)


	#mcmc loop		
	mcmc_iterations<-999
	r1<-matrix(, nrow = length(mgca), ncol = mcmc_iterations)
	r2<-matrix(, nrow = length(mgca), ncol = mcmc_iterations)

	for(j in 1:mcmc_iterations){
		tryCatch({
		tsens<- rnorm(1,
				if(species == 'generic'){generic[1]} else 
				if (species== 'grbw_gray2018' ){grbw_gray2018[1]} else 
				if (species== 'grbw' ){grbw[1]} else
				if (species== 'tsac' ){tsac[1]} else
				if (species== 'gbul' ){gbul[1]} else
				if (species== 'ouni' ){ouni[1]} else
				if (species== 'grbw_spc' ){grbw_spc[1]} else
				if (species== 'tsac_spc' ){tsac_spc[1]} else
				if (species== 'gbul_spc' ){gbul_spc[1]} else
				if (species== 'ouni_spc' ){ouni_spc[1]}
				,
				if(species == 'generic'){generic_err[1]} else 
				if (species== 'grbw_gray2018' ){grbw_gray2018_err[1]} else 
				if (species== 'grbw' ){grbw_err[1]} else
				if (species== 'tsac' ){tsac_err[1]} else
				if (species== 'gbul' ){gbul_err[1]} else
				if (species== 'ouni' ){ouni_err[1]} else 
				if (species== 'grbw_spc' ){grbw_spc_err[1]} else
				if (species== 'tsac_spc' ){tsac_spc_err[1]} else
				if (species== 'gbul_spc' ){gbul_spc_err[1]} else
				if (species== 'ouni_spc' ){ouni_spc_err[1]} 
				)
			
		ssens<- rnorm(1,
				if(species == 'generic'){generic[2]} else 
				if (species== 'grbw_gray2018' ){grbw_gray2018[2]} else 
				if (species== 'grbw' ){grbw[2]} else
				if (species== 'tsac' ){tsac[2]} else
				if (species== 'gbul' ){gbul[2]} else
				if (species== 'ouni' ){ouni[2]} else
				if (species== 'grbw_spc' ){grbw_spc[2]} else
				if (species== 'tsac_spc' ){tsac_spc[2]} else
				if (species== 'gbul_spc' ){gbul_spc[2]} else
				if (species== 'ouni_spc' ){ouni_spc[2]} 
				,
				if(species == 'generic'){generic_err[2]} else 
				if (species== 'grbw_gray2018' ){grbw_gray2018_err[2]} else 
				if (species== 'grbw' ){grbw_err[2]} else
				if (species== 'tsac' ){tsac_err[2]} else
				if (species== 'gbul' ){gbul_err[2]} else
				if (species== 'ouni' ){ouni_err[2]} else
				if (species== 'grbw_spc' ){grbw_spc_err[2]} else
				if (species== 'tsac_spc' ){tsac_spc_err[2]} else
				if (species== 'gbul_spc' ){gbul_spc_err[2]} else
				if (species== 'ouni_spc' ){ouni_spc_err[2]} 
				)
			
		pHsens<-rnorm(1,
				if(species == 'generic'){generic[3]} else 
				if (species== 'grbw_gray2018' ){grbw_gray2018[3]} else 
				if (species== 'grbw' ){grbw[3]} else
				if (species== 'tsac' ){tsac[3]} else
				if (species== 'gbul' ){gbul[3]} else
				if (species== 'ouni' ){ouni[3]} else
				if (species== 'grbw_spc' ){grbw_spc[3]} else
				if (species== 'tsac_spc' ){tsac_spc[3]} else
				if (species== 'gbul_spc' ){gbul_spc[3]} else
				if (species== 'ouni_spc' ){ouni_spc[3]} 				
				,
				if(species == 'generic'){generic_err[3]} else 
				if (species== 'grbw_gray2018' ){grbw_gray2018_err[3]} else 
				if (species== 'grbw' ){grbw_err[3]} else
				if (species== 'tsac' ){tsac_err[3]} else
				if (species== 'gbul' ){gbul_err[3]} else
				if (species== 'ouni' ){ouni_err[3]} else
				if (species== 'grbw_spc' ){grbw_spc_err[3]} else
				if (species== 'tsac_spc' ){tsac_spc_err[3]} else
				if (species== 'gbul_spc' ){gbul_spc_err[3]} else
				if (species== 'ouni_spc' ){ouni_spc_err[3]}
				)
		
		#from fit error covariance	
		intercept<- if(species == 'generic'){1.5+tsens*-25} else 
					if (species== 'grbw_gray2018' ) {rnorm(1, 1.83279+tsens*-29.18481, 0.0001141005)} else 
					if (species== 'grbw_spc' ){rnorm(1, 1.563359 +tsens*-25.016445, 0.0002490649)} else
					if (species== 'tsac_spc' ){rnorm(1, 1.365102+tsens*-25.704721, 0.0001442152)} else
					if (species== 'gbul_spc' ){rnorm(1, 1.564222+tsens*-22.053373, 0.0002023524)} else
					if (species== 'ouni_spc' ){rnorm(1, 2.091911+tsens*-21.679394, 0.0001874262)} else
					if (species== 'grbw' ){rnorm(1, 1.623660+tsens*-25.960728, 0.000197117)} else
			        if (species== 'tsac' ){rnorm(1, 1.39803+tsens*-25.90757, 0.0001313673)} else
					if (species== 'gbul' ){rnorm(1, 1.525943+tsens*-21.442429 , 0.0002160964)} else
					if (species== 'ouni' ){rnorm(1,2.136308+tsens*-22.297933, 0.000200698)}
			
					
		#variable uncertainty
		agej<- rnorm(length(age), age, age_err)
		agej<- ifelse(agej >= -0.05, agej, -0.05) #min age limit for sea level/ice core data
		agej<- ifelse(agej <= 798, agej, 798) #max age limit for sea level data
			
		DS_esl<- approx(x=esl_dat$age, y=esl_dat$DS_sl, xout=agej)$y
		Sj<- rnorm(length(age), (S + DS_esl), 0.5) #S uncertainty from model

		mgcaj<- rnorm(length(mgca), mgca, mgca_err)
		d11BOH4j<- rnorm(length(d11BOH4), d11BOH4, d11BOH4_err)

		#calculate T0
		T0<- (1/tsens)*log(mgcaj/exp(ssens*(Sj-35)+pHsens*(pHambient-8) + intercept))
		i<- 0

		#iterative loop
		repeat{
			#1
			i<- i+1
			#calculate pH1
			pkb<- -log(Kb(	S=Sj,
					 		T=T0,
							P=0, warn='n'),
					base=10)	
	
			pH1 <- pkb-log(-((d11B_sw-d11BOH4j)/(d11B_sw-(alpha_b*d11BOH4j)-1000*(alpha_b-1))),base=10)
	
			#calculate T1
			T1<- (1/tsens)*log(mgcaj/exp(ssens*(Sj-35)+pHsens*(pH1-8) + intercept))
	
	
			#2
			i<- i+1
			#calculate pH2
			pkb<- -log(Kb(	S=Sj,
						 	T=T1,
							P=0, warn='n'),
					base=10)
	
			pH2 <- pkb-log(-((d11B_sw-d11BOH4j)/(d11B_sw-(alpha_b*d11BOH4j)-1000*(alpha_b-1))),base=10)
	
			#calculate T2
			T2<- (1/tsens)*log(mgcaj/exp(ssens*(Sj-35)+pHsens*(pH2-8) + intercept))
			T0<-T2
			
			pHdiff<- abs(pH2 - pH1)
			Tdiff<- abs(T2-T1)
			ifelse(pHdiff < pH_threshold & Tdiff < T_threshold, break, NA)
		}
	#print(paste(i,'iterations to solve'))
	r1[,j] <- T2
	r2[,j] <- pH2
	#s<- cbind(s,T2)
	#s1<- cbind(s1,pH2)
	#if (length(s[1,]) >= mcmc_iterations){break}
	},
	error=function(e){})
	}

t<-apply(r1, 1, function(x) { mean(x, na.rm=TRUE)})
t_sigma<-apply(r1, 1, function(x) { sd(x, na.rm=TRUE)})
pH<-apply(r2, 1, function(x) { mean(x, na.rm=TRUE)})
pH_sigma<-apply(r2, 1, function(x) { sd(x, na.rm=TRUE)}) 
results<- data.frame(t=t, t_sigma=t_sigma,pH=pH,pH_sigma=pH_sigma)

return(results)	
}
}

save('MgCaRB.d11B',file='MgCaRB.d11B.Rdata')
load('MgCaRB.d11B.Rdata')