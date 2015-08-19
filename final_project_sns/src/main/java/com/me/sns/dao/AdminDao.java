package com.me.sns.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.me.sns.model.User;
import com.me.sns.model.UserProfile;

public class AdminDao extends DAO {

	//Retrieve list if user profile from the database
	public List<UserProfile> getAllUserProfile(){
		
		Session session = getSession().getSessionFactory().openSession();
		Query q =session.createQuery("from UserProfile");
		List<UserProfile> up = q.list();
		session.close();
		return up;
	}
	
	//Delete the profile from the database
	public void deleteProfile(String username) {
		Session session = getSession().getSessionFactory().openSession();
		session.beginTransaction();
		
		Query q = session.createQuery("from UserProfile where username = :username");
		Query qq = session.createQuery("from User where username =:username");
		q.setString("username", username);
		qq.setString("username", username);
		
		UserProfile up = (UserProfile)q.uniqueResult();
		session.delete(up);
		
		User u = (User)qq.uniqueResult();
		session.delete(u);
		
		session.getTransaction().commit();
		session.close();
	}
}
