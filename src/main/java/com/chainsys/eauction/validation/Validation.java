package com.chainsys.eauction.validation;

import org.springframework.stereotype.Component;

@Component
public class Validation {
	public boolean validateEmail(String email) {
	       
	    return  email.matches("^[a-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[a-zA-Z]{2,}$");

	        
	    }
	public boolean validateUsername(String username) {
	       return username.matches("[A-Za-z]{2,}");
	    }

	   

    public boolean validateMobile(String mobileNumber) {
       
      return  mobileNumber.matches("^[0-9]{10}$");
      
    }

	    public boolean validatePassword(String password) {
	      
	     return   password.matches("(?=.*[A-Z])(?=.*[a-z])(?=.*[&^%$#@])(?=.*\\d).{5,}");
	      
	    }
	    public boolean amount(String amount)
	    {
	    	return amount.matches("^[0-9]{16}");
	    }
}
