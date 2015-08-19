package com.me.sns.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="messages")
public class Messages {

	@Id
	@Column(name="messageid")
	@GeneratedValue
	private int messageId;
	
	@Column(name="username")
	private String userName;
	
	@Column(name="fromuser")
	private String fromUser;
	
	@Column(name="message")
	private String message;
	
	@Column(name="messagedate")
	private String messageDate;
	
/*	@ManyToOne
	@JoinColumn(name="username")
	private User user1;*/
	
	
	public int getMessageId() {
		return messageId;
	}
	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getMessageDate() {
		return messageDate;
	}
	public void setMessageDate(String messageDate) {
		this.messageDate = messageDate;
	}
/*	public User getUser1() {
		return user1;
	}
	public void setUser1(User user1) {
		this.user1 = user1;
	}*/

		
}
