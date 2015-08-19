package com.me.sns.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="grouplist")
public class Group implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	@Column(name="gid")
	private int gId;
	
	@Column(name="gname")
	private String gName;
	
	@Column(name="gdesc")
	private String gDesc;
	
	@OneToMany(mappedBy="group")
	private List<GroupMembers> gMembers = new ArrayList<GroupMembers>();

	public int getgId() {
		return gId;
	}

	public void setgId(int gId) {
		this.gId = gId;
	}

	public String getgName() {
		return gName;
	}

	public void setgName(String gName) {
		this.gName = gName;
	}

	public String getgDesc() {
		return gDesc;
	}

	public void setgDesc(String gDesc) {
		this.gDesc = gDesc;
	}

	public List<GroupMembers> getgMembers() {
		return gMembers;
	}

	public void setgMembers(List<GroupMembers> gMembers) {
		this.gMembers = gMembers;
	}
	
}
