package com.me.sns.model;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class ProfilePicture {

	private CommonsMultipartFile profilePic;

	public CommonsMultipartFile getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(CommonsMultipartFile profilePic) {
		this.profilePic = profilePic;
	}
	
}
