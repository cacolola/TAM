
tam_mml_3pl_calc_ll_est_guessing <- 
	function( n0ij , n1ij , probs, eps )
{
	l1 <- rowSums( n0ij * log( probs[,1,] + eps ) + n1ij * log( probs[,2,] + eps ) )
	return(l1)
}
