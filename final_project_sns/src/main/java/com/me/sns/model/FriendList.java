package com.me.sns.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="friendlist")
public class FriendList implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="flkey")
	@GeneratedValue
	private int flkey;
	
	@Column(name="username")
	private String username;
	
	@Column(name="friendname")
	private String friendname;
	
	@Column(name="status")
	private String status;
	
	public int getFlkey() {
		return flkey;
	}
	public void setFlkey(int flkey) {
		this.flkey = flkey;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getFriendname() {
		return friendname;
	}
	public void setFriendname(String friendname) {
		this.friendname = friendname;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

}
