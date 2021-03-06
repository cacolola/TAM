

#********************************************************************
# Function calculates reliability from nonlinear SEM
tam_fa_reliability_nonlinearSEM <- function( facloadings , thresh , cor.factors =NULL )
{
    # INPUT:
    # loadings      ... matrix of factor loadings
    # thresh        ... vector of thresholds
    # cor.factors   ... correlation matrix of factors
    #.............................................
    facloadings <- as.matrix( facloadings )
    NF <- ncol(facloadings ) # number of factor facloadings
    # correlation matrix
    if ( is.null(cor.factors)){ 
        cor.factors <- matrix( 0 , nrow=NF, ncol=NF )
        diag( cor.factors ) <- rep(1,NF) 
    } 
    # number of items
    I <- nrow(facloadings)
    # transform thresholds
    pthresh <- stats::pnorm( thresh )
    # create matrix of multiplied facloadings (expected correlation)
    rho.exp <- matrix( 0 , I , I )
    colnames(rho.exp) <- rownames(rho.exp) <- rownames(facloadings)
    # reliability matrix
    rel.matrix2 <- rel.matrix <- rho.exp       
    for (ii1 in 1:I){
        for (ii2 in 1:ii1){ 
            rho.exp[ii1,ii2] <- as.vector(facloadings[ii1,]) %*% cor.factors  %*% 
											matrix( as.vector(facloadings[ii2,]) , ncol=1 )
            rho.exp[ii2,ii1] <- rho.exp[ii1,ii2] 
            r1 <- rho.exp[ii1,ii2]
            rel.matrix2[ii1,ii2] <- rel.matrix[ii1,ii2] <- mvtnorm::pmvnorm( c(-Inf,-Inf) , pthresh[c(ii1,ii2)] ,
                                         corr = matrix( c( 1 , r1 , r1 , 1) ,2 ,2 ) ) - 
											stats::pnorm( pthresh[ii1] ) * stats::pnorm( pthresh[ii2] )
            rel.matrix2[ii2,ii1] <- rel.matrix[ii2,ii1] <- rel.matrix[ii1,ii2]
            if (ii1 == ii2){
                r1 <- 1
                rel.matrix2[ii1,ii2] <- mvtnorm::pmvnorm( c(-Inf,-Inf) , pthresh[c(ii1,ii2)] ,
                                            corr = matrix( c( 1 , r1 , r1 , 1) ,2 ,2 ) ) - 
												stats::pnorm( pthresh[ii1] ) * stats::pnorm( pthresh[ii2] )
                rel.matrix2[ii2,ii1] <- rel.matrix2[ii1,ii2]
            }                
        }
    }                    
    # calculation of reliability
    omega.rel <- sum( rel.matrix ) / sum( rel.matrix2 )
    # output
    res <- list( "omega.rel" = omega.rel , "NF" = NF , "cor.factors" = cor.factors ,  
                    "pthresh" = pthresh  , "rho.exp" = rho.exp , "rel.matrix" = rel.matrix , 
                    "rel.matrix2" = rel.matrix2)
    return(res)       
}
#********************************************************************
