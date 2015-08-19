package com.me.sns.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="groupmessages")
public class GroupMessages implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="id")
	@GeneratedValue
	private int id;
	
	@Column(name="groupid")
	private int groupId;
	
	@Column(name="sender")
	private String sender;
	
	@Column(name="gmessage")
	private String gMessage;
	
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getgMessage() {
		return gMessage;
	}
	public void setgMessage(String gMessage) {
		this.gMessage = gMessage;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	
	
}
