

#************************************************
# print CALL in summary										
tam_print_call <- function(CALL){					
	cat("\n\nCall:\n", paste(deparse(CALL), sep = "\n", collapse = "\n"), 
				"\n\n", sep = "")	
}
#************************************************							
