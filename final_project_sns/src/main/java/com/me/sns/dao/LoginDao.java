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

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	
	public User queryUserByNameAndPassword(String username, String password)
            throws Exception {
        try {
        	Session session = getSession();
            Query q = session.createQuery("from User where username = :username and password = :password");
            q.setString("username", username);
            q.setString("password", password);
            User user = (User) q.uniqueResult();
            session.close();
            return user;
        } catch (HibernateException e) {
            throw new Exception("Could not get user " + username, e);
        }
	
	}
	
}
