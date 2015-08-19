package com.me.sns.dao;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JOptionPane;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.me.sns.model.User;

public class LoginDao extends DAO {
	
	private SessionFactory sessionFactory;

/*	@SuppressWarnings("unchecked")
	public User findByUserName(String username) {

		List<User> users = new ArrayList<User>();

		users = getSessionFactory().getCurrentSession().createQuery("from User where username=?")
				.setParameter(0, username).list();

		if (users.size() > 0) {
			return users.get(0);
		} else {
			return null;
		}

	}*/

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	
	public User queryUserByNameAndPassword(String username, String password)
            throws Exception {
        try {
      //      begin();
        	Session session = getSession();
            Query q = session.createQuery("from User where username = :username and password = :password");
            q.setString("username", username);
            q.setString("password", password);
            User user = (User) q.uniqueResult();
     //       commit();
            session.close();
            return user;
        } catch (HibernateException e) {
     //       rollback();
            throw new Exception("Could not get user " + username, e);
        }
	
	}
	
}
