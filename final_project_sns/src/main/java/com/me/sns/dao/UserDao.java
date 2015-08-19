package com.me.sns.dao;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.swing.JOptionPane;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.me.sns.model.FriendList;
import com.me.sns.model.Messages;
import com.me.sns.model.User;
import com.me.sns.model.UserProfile;

public class UserDao extends DAO {

	public UserProfile getUserProfile(String username) {
		Query q = getSession().createQuery(
				"from UserProfile where username = :username");
		q.setString("username", username);
		UserProfile userProfile = (UserProfile) q.uniqueResult();
		return userProfile;
	}

	public List<UserProfile> getFriendNames(String username) {

		List<String> frndNames;
		Query q = getSession()
				.createSQLQuery(
						"select username from friendlist  where friendname = :username and status ='act' union select friendname from friendlist  where username = :username and status = 'act'");
		q.setString("username", username);
		frndNames = q.list();

		List<UserProfile> userProfile = new ArrayList<UserProfile>();
		// Query qq;
		for (String tempName : frndNames) {
			UserProfile up = getUserProfile(tempName);
			userProfile.add(up);
		}
		getSession().close();
		return userProfile;
	}

	public void deleteFriend(String username, String fname) {

		Session session = getSession();
		session.beginTransaction();

		/*
		 * Query q = session.createSQLQuery(
		 * "select * from friendlist  where friendname = :username and username = :fname and status ='act' union select * from friendlist  where username = :username and  friendname = :fname and status = 'act'"
		 * );
		 */

		Query q = session
				.createQuery("from FriendList where status = :status and ((friendname = :username and username = :fname) or (username = :username and friendname = :fname))");
		q.setString("status", "act");
		q.setString("username", username);
		q.setString("fname", fname);
		FriendList res = (FriendList) q.uniqueResult();

		/*
		 * Query qq =
		 * session.createQuery("from FriendList where flkey = :flkey");
		 * qq.setInteger("flkey", res); FriendList fl =
		 * (FriendList)q.uniqueResult();
		 */
		session.delete(res);
		session.getTransaction().commit();

		session.close();
	}

	public List<UserProfile> getUserProfiles(String username) {
		Query q = getSession().createQuery(
				"from UserProfile where username like :username");
		q.setString("username", "%" + username + "%");
		List<UserProfile> userProfile = q.list();
		getSession().close();
		return userProfile;
	}

	public void submitUserRegistration(UserProfile userProfile, String password) {

		Session session = getSession();
		session.beginTransaction();

		User user = new User();
		/* UserProfile up = new UserProfile(); */
		UserProfile up = userProfile;

		user.setUsername(userProfile.getUsername());
		user.setPassword(password);

		if (userProfile.getImage() == null) {
			userProfile.setImage("000");
		}
		user.setRole("USER");
		user.setStatus("N");
		up.setStatus("N");
		
		//generate random number
		
		List<Integer> numbers = new ArrayList<Integer>();
		for (int i = 0; i < 10; i++) {
			numbers.add(i);
		}
		Collections.shuffle(numbers);
		String result = "";
		for (int i = 0; i < 4; i++) {
			result += numbers.get(i).toString();
		}
		
		up.setCode(result);
		
		session.save(user);
		session.save(up);

		session.getTransaction().commit();
		session.close();

		return;
	}

	public void editProfile(String username, UserProfile up) {

		Session session = getSession();
		session.beginTransaction();

		Query q = session
				.createQuery("from UserProfile where username = :username");
		q.setString("username", username);
		UserProfile userProfile = (UserProfile) q.uniqueResult();
		session.close();
		// Session session = getSession();
		// session.beginTransaction();
		//
		// UserProfile userProfile = (UserProfile)session.get(UserProfile.class,
		// up.getUsername());

		userProfile = up;
		Session session2 = getSession();
		session2.beginTransaction();
		session2.update(userProfile);
		session2.getTransaction().commit();
		session2.close();
	}

	public List<UserProfile> getPendingFriendList(String username) {

		Query q = getSession()
				.createSQLQuery(
						"select u.* from friendlist f inner join user_profile u on u.username=f.username where f.friendname= :uname and f.status ='pnd' ");
		q.setString("uname", username);
		List<UserProfile> fList = q.list();
		getSession().close();
		return fList;
	}

	public List<Messages> showMessagesByUserName(String name) throws Exception {
		try {
			Query q = getSession().createQuery(
					"from Messages where userName = :username");
			q.setString("username", name);
			List<Messages> messageList = q.list();
			getSession().close();
			return messageList;

		} catch (HibernateException e) {
			throw new Exception("Could not get user " + name, e);
		}
	}

	public List<Messages> showMessagesByMessageId(int mid) throws Exception {
		try {
			Query q = getSession().createQuery(
					"from Messages where messageId = :mid");
			q.setInteger("mid", mid);
			List<Messages> messageList = q.list();
			getSession().close();
			return messageList;

		} catch (HibernateException e) {
			throw new Exception("Could not get M-ID " + mid, e);
		}
	}

	public int deleteMessage(int messageId) throws Exception {
		try {
			int update = 0;

			Query q = getSession().createSQLQuery(
					"delete from Messages where messageID = :id");
			q.setInteger("id", messageId);

			update = q.executeUpdate();
			getSession().close();
			return update;

		} catch (HibernateException e) {
			throw new Exception("Could not get user " + messageId, e);
		}
	}

	public int replyToMessage(String sender, String receiver, String message)
			throws Exception {
		try {
			DateFormat df = new SimpleDateFormat("MM/dd/yy");
			Date dateobj = new Date();
			String currDate = (String) df.format(dateobj);
			int update = 1;

			Session session = getSession().getSessionFactory().openSession();
			session.beginTransaction();
			Messages messages = new Messages();
			messages.setFromUser(sender);
			messages.setMessage(message);
			messages.setMessageDate(currDate);
			messages.setUserName(receiver);

			session.save(messages);
			session.getTransaction().commit();
			session.close();

			return update;

		} catch (HibernateException e) {
			throw new Exception("Could not get user " + sender, e);
		}
	}

	public int addFriend(String username, String friendname) {
		FriendList fl;

		Query q = getSession()
				.createQuery(
						"from FriendList where (username = :username and friendname = :friendname) or ( username =:friendname and friendname =:username)");
		q.setString("username", username);
		q.setString("friendname", friendname);
		fl = (FriendList) q.uniqueResult();
		getSession().close();
		if (fl == null) {
			// / send friend request
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			FriendList frnd = new FriendList();
			frnd.setUsername(username);
			frnd.setFriendname(friendname);
			frnd.setStatus("pnd");
			session.save(frnd);
			session.getTransaction().commit();
			session.close();
			return 0;
		} else {
			if (fl.getStatus().equals("act")) {
				return 1;
			}
			if (fl.getStatus().equals("pnd")) {
				return 2;
			}
		}
		return 0;
	}

	public void confirmRequest(String username, String uname) {

		Session session = getSession();
		session.beginTransaction();
		Query q = getSession()
				.createQuery(
						"from FriendList where friendname = :friendname and username = :username");
		q.setString("friendname", username);
		q.setString("username", uname);
		FriendList fl = (FriendList) q.uniqueResult();
		fl.setStatus("act");
		session.update(fl);
		session.getTransaction().commit();
		session.close();

	}

	public void rejectRequest(String username, String uname) {

		Session session = getSession();
		session.beginTransaction();
		Query q = getSession()
				.createQuery(
						"from FriendList where friendname = :friendname and username = :username");
		q.setString("friendname", username);
		q.setString("username", uname);
		FriendList fl = (FriendList) q.uniqueResult();
		session.delete(fl);
		session.getTransaction().commit();
		session.close();

	}

	public List<String> getGenderList() {

		List<String> gender = new ArrayList<String>();
		gender.add("Male");
		gender.add("Female");
		return gender;
	}

	public List<String> getStateList() {
		List<String> state = new ArrayList<String>();
		state.add("---");
		state.add("Alabama");
		state.add("Alaska");
		state.add("Arizona");
		state.add("Arkansas");
		state.add("California");
		state.add("Colorado");
		state.add("Connecticut");
		state.add("Delaware");
		state.add("District Of Columbia");
		state.add("Florida");
		state.add("Georgia");
		state.add("Hawaii");
		state.add("Idaho");
		state.add("Illinois");
		state.add("Indiana");
		state.add("Iowa");
		state.add("Kansas");
		state.add("Kentucky");
		state.add("Louisiana");
		state.add("Maine");
		state.add("Maryland");
		state.add("Massachusetts");
		state.add("Michigan");
		state.add("Minnesota");
		state.add("Mississippi");
		state.add("Missouri");
		state.add("Montana");
		state.add("Nebraska");
		state.add("Nevada");
		state.add("New Hampshire");
		state.add("New Jersey");
		state.add("New Mexico");
		state.add("New York");
		state.add("North Carolina");
		state.add("North Dakota");
		state.add("Ohio");
		state.add("Oklahoma");
		state.add("Oregon");
		state.add("Pennsylvania");
		state.add("Rhode Island");
		state.add("South Carolina");
		state.add("South Dakota");
		state.add("Tennessee");
		state.add("Texas");
		state.add("Utah");
		state.add("Vermont");
		state.add("Virginia");
		state.add("Washington");
		state.add("West Virginia");
		state.add("Wisconsin");
		state.add("Wyoming");
		return state;
	}

	public List<String> getMonthList() {
		List<String> month = new ArrayList<String>();
		month.add("January");
		month.add("February");
		month.add("March");
		month.add("April");
		month.add("May");
		month.add("June");
		month.add("July");
		month.add("August");
		month.add("September");
		month.add("October");
		month.add("November");
		month.add("December");
		return month;
	}

	public List<UserProfile> findMatch(UserProfile up, int age1, int age2) {
		List<UserProfile> userProfile;

		Session session = getSession();
		/* session.getSessionFactory().openSession(); */

		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("YYYY");

		int aze = Integer.parseInt(dateFormat.format(date));
		String year = dateFormat.format(date);
		int newyear1 = aze - age1;
		int newyear2 = aze - age2;

		StringBuilder qry = new StringBuilder(
				"from UserProfile where gender = :gender");

		if (!up.getState().equals("---")) {
			qry.append(" and state = :state");
		}
		if (newyear1 == 0) {
			qry.append(" and year <= :newyear1");
		}
		if (newyear2 == 0) {
			qry.append(" and year >= :newyear2");
		}
		if (!up.getSmoking().equals("---")) {
			qry.append(" and smoking = :smoking");
		}
		if (!up.getDrinking().equals("---")) {
			qry.append(" and drinking = :drinking");
		}

		Query q = session.createQuery(qry.toString());
		q.setString("gender", up.getGender());

		if (!up.getState().equals("---")) {
			q.setString("state", up.getState());
		}
		if (newyear1 == 0) {
			q.setParameter("newyear1", String.valueOf(newyear1));
		}
		if (newyear2 == 0) {
			q.setParameter("newyear2", String.valueOf(newyear2));
		}
		if (!up.getSmoking().equals("---")) {
			q.setString("smoking", up.getSmoking());
		}
		if (!up.getDrinking().equals("---")) {
			q.setString("drinking", up.getDrinking());
		}
		userProfile = q.list();

		/*
		 * for (UserProfile userProfile2 : userProfile) {
		 * JOptionPane.showMessageDialog(null, userProfile2.getFname()); }
		 */

		session.close();
		return userProfile;
	}

	public void setProfilePic(String username, String imageName) {

		Session session = getSession().getSessionFactory().openSession();
		session.beginTransaction();

		Query q = session
				.createQuery("from UserProfile where username =:username");
		q.setString("username", username);
		UserProfile userProfile = (UserProfile) q.uniqueResult();
		userProfile.setImage(imageName);
		session.update(userProfile);
		session.getTransaction().commit();
		session.close();

	}
	
	public int sendVerification(UserProfile user) {
		final String gmailu = "northeastern.dating@gmail.com";
		final String gmailp = "@Vinay1234";
		//User user = moneyTransaction.getUser();
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		javax.mail.Session session = javax.mail.Session.getDefaultInstance(
				props, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(gmailu, gmailp);
					}
				});
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("northeastern.dating@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(user.getEmail()));
			message.setSubject("Account Verification - Northeastern Dating Site");
			message.setText("Hi " + user.getFname() + " "
					+ user.getLname() + ", Click on the link to verify your account: http://localhost:8080/sns/verify?username="
					+ user.getUsername() + "&code="
					+ user.getCode());
			Transport.send(message);
			return 1;
		} catch (MessagingException e) {
			// throw new RuntimeException(e);
			//JOptionPane.showMessageDialog(null, "cant process the request");
			return -1;
		}
	}
	
	public int verify(String username, String code) {
		
		
		Session session = getSession().getSessionFactory().openSession();
		//Session session = getSession();
		session.beginTransaction();
		
		Query q = session.createQuery("from UserProfile where username = :username and code = :code");
		q.setString("username", username);
		q.setString("code", code);
		
		UserProfile up = (UserProfile)q.uniqueResult();
		
		Query qq = session.createQuery("from User where username = :username");
		qq.setString("username", username);
		User u = (User)qq.uniqueResult();
		
		if(up==null) {
			session.close();
			return 0;
		}
		else {
			up.setStatus("Y");
			u.setStatus("Y");
			
			session.update(u);
			session.update(up);
			
			session.getTransaction().commit();
			session.close();
			return 1;
		}
	}
	
	public User changePassword(User user, String newPassword) {
		
		Session session = getSession().getSessionFactory().openSession();
		session.beginTransaction();
		
		Criteria cr =session.createCriteria(User.class);
		cr.add(Restrictions.eq("username", user.getUsername()));
		User u = (User)cr.uniqueResult();
		u.setPassword(newPassword);
		session.update(u);
		session.getTransaction().commit();
		session.close();
		return u;
	}
}
