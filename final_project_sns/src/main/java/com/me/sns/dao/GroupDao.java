package com.me.sns.dao;

import java.util.List;

import javax.swing.JOptionPane;

import org.hibernate.Query;
import org.hibernate.Session;

import com.me.sns.model.Group;
import com.me.sns.model.GroupMembers;
import com.me.sns.model.GroupMessages;

public class GroupDao extends DAO {

	//Retrieve the list of groups from database using a keyword
	public List<Group> getAllGroup(String gname){
		
		Session session = getSession().getSessionFactory().openSession();
		session.beginTransaction();
		Query q;
		if(gname.equals("0")) {
			
			q=session.createQuery("from Group");
		}
		else {
			q=session.createQuery("from Group where gName like :gName");
			q.setString("gName", "%"+gname+"%");
		}
		
		List<Group> gList = q.list();
		session.getTransaction();
		session.close();
		return  gList;
	}
	
	//Adding  a user to the list of members in a group in the database
	public boolean joinGroup(int gid,String username) {
		
		boolean res=false;
		
		Session session = getSession().getSessionFactory().openSession();
		session.beginTransaction();
		
		Query q = session.createQuery("from GroupMembers where username = :username and gid = :gid");
		q.setString("username", username);
		q.setInteger("gid", gid);
		GroupMembers g = (GroupMembers)q.uniqueResult();
		
		if(g!=null) {
			res=false;
			//JOptionPane.showMessageDialog(null, "Already added");
		}
		else {
		Group group = (Group)session.get(Group.class, gid);
		
		GroupMembers groupMembers = new GroupMembers();
		groupMembers.setUsername(username);
		groupMembers.setGroup(group);
		group.getgMembers().add(groupMembers);
		session.save(groupMembers);
		session.getTransaction().commit();
		res = true;
		JOptionPane.showMessageDialog(null, "Added Now");
		}
		
		session.close();
		
		return res;
	}
	
	//Retrieves from the database the list of groups a user has registered for
	public List<GroupMembers> getGroupForUser(String username) {
		
		Session session = getSession().getSessionFactory().openSession();
		session.beginTransaction();
		
		Query q = session.createQuery("from GroupMembers where username = :username"); 
		q.setString("username", username);
		List<GroupMembers> gList = q.list();
		
		session.close();
		return gList;
		
	}
	
	//Retrieves from the database the messages of a particular group
	public List<GroupMessages> getGroupMessages(int gid) {
		
		Session session = getSession().getSessionFactory().openSession();
		session.beginTransaction();
		
		Query q = session.createQuery("from GroupMessages where groupId = :gid");
		q.setInteger("gid", gid);
		List<GroupMessages> gm = q.list();
		session.close();
		return gm;
		
	}
	
	//Message sent to a group is saved in the database
	public void sendGroupMessage(GroupMessages groupMessages) {
		
		Session session = getSession().getSessionFactory().openSession();
		session.beginTransaction();
		
		GroupMessages gm = groupMessages;
		session.save(gm);
		session.getTransaction().commit();
		session.close();
	}
	
	//Creating a group in the database
	public void createGroup(Group group) {
		Session session = getSession().getSessionFactory().openSession();
		session.beginTransaction();
		Group gp = group;
		session.save(gp);
		session.getTransaction().commit();
		session.close();
		
	}
}
