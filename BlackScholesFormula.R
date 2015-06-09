 BlackScholesFormula  <- function (spot,timetomat,strike,r, q=0, sigma, opttype=1, greektype=1)
{ 

d1<-(log(spot/strike)+ ((r-q)+0.5*sigma^2)*timetomat)/(sigma*sqrt(timetomat))
d2<-d1-sigma*sqrt(timetomat)

if (opttype==1 && greektype==1) result<-spot*exp(-q*timetomat)*pnorm(d1)-strike*exp(-r*timetomat)*pnorm(d2)
if (opttype==2 && greektype==1) result<-spot*exp(-q*timetomat)*pnorm(d1)-strike*exp(-r*timetomat)*pnorm(d2)-spot*exp(-q*timetomat)+strike*exp(-r*timetomat)


if (opttype==4 && greektype==1) result<-(spot^2)*exp((r+sigma^2)*timetomat)
if (opttype==4 && greektype==2) result<-2*spot*exp((r+sigma^2)*timetomat)

  'Delta'
if (opttype==1 && greektype==2) result<-exp(-q*timetomat)*pnorm(d1)
if (opttype==2 && greektype==2) result<-exp(-q*timetomat)*(pnorm(d1)-1)

  'Gamma'
if (greektype==3) result<-exp(-q*timetomat)*dnorm(d1)/(spot*sigma*sqrt(timetomat))

  'Vega'
if (greektype==4) result<-exp(-q*timetomat)*spot*dnorm(d1)*sqrt(timetomat)

  'Theta'
if (opttype==1 && greektype==5) result<- q*spot*exp(-q*timetomat)*pnorm(d1)-spot*exp(-q*timetomat)*sigma/(2*sqrt(timetomat))*dnorm(d1)-r*strike*exp(-r*timetomat)*(1-pnorm(d2))
if (opttype==2 && greektype==5) result<- r*strike*exp(-r*timetomat)*(1-pnorm(d2))-q*spot*exp(-q*timetomat)*(1-pnorm(d1))-spot*exp(-q*timetomat)*sigma/(2*sqrt(timetomat))*dnorm(d1)

  'Rho'
if (opttype==1 && greektype==6) result<-strike*timetomat*exp(-r*timetomat)*pnorm(d2)
if (opttype==2 && greektype==6) result<--strike*timetomat*exp(-r*timetomat)*(1-pnorm(d2))

BlackScholesFormula<-result

}

BlackScholesImpVol  <- function (obsprice,spot,timetomat,strike,r, q=0, opttype=1)

  { difference<- function(sigBS, obsprice,spot,timetomat,strike,r,q,opttype)
      {BlackScholesFormula (spot,timetomat,strike,r,q,sigBS, opttype,1)-obsprice
     }

    uniroot(difference, c(10^-6,10),obsprice=obsprice,spot=spot,timetomat=timetomat,strike=strike,r=r,q=q,opttype=opttype)$root

  }
