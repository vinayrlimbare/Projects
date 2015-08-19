package com.me.sns.dao;

import java.util.logging.Level;

import org.hibernate.HibernateException;
import org.hibernate.Session;

//Create DAO for few transactions 
public abstract class DAO {
     
   public Session getSession(){
	   
	   return HibernateUtil.getSessionFactory().openSession();
   }
	 
   protected DAO() {
   }

   //Begins a transaction
   protected void begin() {
       getSession().beginTransaction();
   }

   //Writes/Saves the changes
   protected void commit() {
       getSession().getTransaction().commit();
   }

   //Rollbacks any changes made
   protected void rollback() {
       try {
           getSession().getTransaction().rollback();
       } catch (HibernateException e) {
          
       }
       try {
           getSession().close();
       } catch (HibernateException e) {
          
       }
      
   }

   //Close the session 
   public  void close() {
       getSession().close();
   }
	
	
}
