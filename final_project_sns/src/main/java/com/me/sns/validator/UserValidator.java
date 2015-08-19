package com.me.sns.validator;


import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.me.sns.model.User;


public class UserValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		User user = (User)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "validate.name", "Your Name Is Incorrect");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "validate.password", "Your password Is Incorrect");
	}

}
