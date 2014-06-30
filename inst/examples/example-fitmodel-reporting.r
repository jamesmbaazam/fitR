# Create a simple stochastic SIR model with constant population size
#
# This is based on the determinsitc SIR model, which can be created
# using example(SIR)
#

SIR_reporting_name <- "SIR with constant population size and incomplete reporting"
SIR_reporting_theta.names <- SIR_theta.names <- c("R0","D", "RR")

## function to compute the log-likelihood of one data point
SIR_reporting_pointLogLike <- function(data.point, model.point, theta){

        ## the prevalence is observed through a Poisson process with a reporting rate
	return(dpois(x=data.point[["obs"]], lambda=model.point[["I"]]*theta[["RR"]], log=TRUE))
}

## function to generate observation from a model simulation
SIR_reporting_genObsPoint <- function(model.point, theta){

        ## the prevalence is observed through a Poisson process
        obs.point <- rpois(n=1, lambda=model.point[["I"]]*theta[["RR"]])

        return(obs.point)
}

## create deterministic SIR fitmodel
SIR_reporting <- fitmodel(
	name=SIR_reporting_name,
        state.names=SIR_state.names,
	theta.names=SIR_theta.names,
        simulate=SIR_simulateDeterministic,
	genObsPoint=SIR_reporting_genObsPoint,
	logPrior=SIR_logPrior,
	pointLogLike=SIR_reporting_pointLogLike)

## test it
theta <- c(R0=3, D=4, RR=0.7)
state.init <- c(S=99,I=1,R=0)

data(epi)

## SIR_reporting
## testFitmodel(fitmodel=SIR_reporting, theta=theta, state.init=state.init, data= epi2, verbose=TRUE)


