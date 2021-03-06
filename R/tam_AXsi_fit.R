
tam_AXsi_fit <- function(A, AXsi)
{
	dim_A <- dim(A)
	NX <- dim_A[3]
	#--- define fit function
	fit_fct <- function(x){
		sum( ( AXsi - tam_AXsi_compute(A=A, xsi=x) )^2 , na.rm=TRUE)       
	}
	# fit
	res0 <- stats::optim(  rep(0,NX) , fit_fct , method="L-BFGS")
	#--- OUTPUT
	return(res0$par)
}