package com.me.sns;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import org.hamcrest.core.IsNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.me.sns.dao.AdminDao;
import com.me.sns.dao.GroupDao;
import com.me.sns.dao.LoginDao;
import com.me.sns.dao.UserDao;
import com.me.sns.model.Group;
import com.me.sns.model.GroupMembers;
import com.me.sns.model.GroupMessages;
import com.me.sns.model.Messages;
import com.me.sns.model.ProfilePicture;
import com.me.sns.model.User;
import com.me.sns.model.UserProfile;
import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	HttpSession session;
	
	//Using Autowired Annotations
	@Autowired
	@Qualifier("userValidator")
	private Validator validator;

	//Binding the Validator
	@InitBinder("user")
	private void initBinder(WebDataBinder binder) {
		binder.setValidator(validator);
	}

	@Autowired
	private LoginDao loginDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private AdminDao adminDao;

	@Autowired
	private GroupDao groupDao;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String initUserLoginForm(Model model, HttpServletRequest request) {
		User user = new User();
		
		//Use cookies to retrieve last login information
		Cookie[] cookies = request.getCookies();
		if (cookies != null && cookies.length >= 2) {
			try {
				for (int i = 0; i < cookies.length; i++) {
					User u = loginDao.queryUserByNameAndPassword(
							cookies[i].getValue(), cookies[i + 1].getValue());
					if (u != null && u.getStatus().equals("Y")) {
						session = request.getSession();
						session.setAttribute("user", u);
						model.addAttribute("user", u);
						return "mainPage";
					}
					
					//Checks if the user has not verified his email.
					if (u != null && u.getStatus().equals("N")) {
						return "unverified";
					}
				}
			} catch (Exception e) {
			}
		}

		model.addAttribute("user", user);
		return "home1";
	}

	//Check if the user has clicked the check box to save his login information 
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public String home(Model model, @Validated User user, BindingResult result,
			HttpServletResponse response, HttpServletRequest request) {

		String remember = (request.getParameter("Remember") != null ? "Remember"
				: "No");

		if (result.hasErrors()) {
			return "home1";
		} else {
			try {
				User u = loginDao.queryUserByNameAndPassword(
						user.getUsername(), user.getPassword());
				if (u != null && u.getStatus().equals("Y")) {
					session = request.getSession();
					session.setAttribute("user", u);

					//Check is the user is an admin
					if (u.getRole().equals("ADMIN")) {
						model.addAttribute("user", u);
						return "admin";
					}

					
					//Create cookie if the user wants to remember his session for a week
					if (remember != null
							&& remember.equalsIgnoreCase("Remember")) {
						Cookie userName = new Cookie("userName",
								user.getUsername());
						userName.setMaxAge(3600 * 24 * 7);
						response.addCookie(userName);
						Cookie userPassword = new Cookie("userPassword",
								user.getPassword());
						userPassword.setMaxAge(3600 * 24 * 7);
						response.addCookie(userPassword);
					}

					model.addAttribute("user", u);
					return "mainPage";
				}
				
				//Checks if the user has not verified his email.
				if (u != null && u.getStatus().equals("N")) {
					return "unverified";
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		model.addAttribute("msg","Please enter the correct Username-Password combination");
		return "error";
	}

	//Frame the consists of pages only for admin related work
	@RequestMapping(value = "mainAdminFrame")
	public String mainAdminFrame(Model model, User user) {
		model.addAttribute("user", user);
		return "mainAdminFrame";
	}

	//Main page in a frame for admin
	@RequestMapping(value = "mainAdminPage")
	public String mainAdminPage(Model model, User user) {
		model.addAttribute("user", user);
		return "mainAdminPage";
	}

	//To view the admin profile
	@RequestMapping(value = "adminViewProfile")
	public String adminViewProfile(Model model) {
		List<UserProfile> up = adminDao.getAllUserProfile();
		model.addAttribute("userProfileList", up);
		return "adminViewProfile";
	}

	//To delete a profile of a user usually done by an admin
	@RequestMapping(value = "deleteProfile")
	public String mainAdminPage(Model model,
			@RequestParam("username") String username) {
		adminDao.deleteProfile(username);
		return "mainAdminPage";
	}

	//User's Frame that also loads all the groups of user in the Sidebar
	@RequestMapping(value = "mainPageFrame")
	public String mainPageFrame(Model model) {
		User user = (User) session.getAttribute("user");
		List<GroupMembers> gList = groupDao.getGroupForUser(user.getUsername());
		model.addAttribute("gList", gList);
		return "mainPageFrame";
	}

	@RequestMapping(value = "admin")
	public String admin(Model model, User user) {
		User u = (User) session.getAttribute("user");
		if (u.getRole().equals("ADMIN")) {
			model.addAttribute("user", u);
			return "admin";
		}
		return accessDenied(model);
	}

	//Mapping to return access denied page if anything unusual has encountered
	@RequestMapping(value = "accessDenied")
	public String accessDenied(Model model) {
		return "accessDenied";
	}

	//Mapping to render the header of user's page
	@RequestMapping(value = "mainPageHeader")
	public String mainPageHeader(Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("fname", user.getUserProfile().getFname());
		model.addAttribute("lname", user.getUserProfile().getLname());
		return "mainPageHeader";
	}

	//Retrieves the list of states in US and also the genders 
	@RequestMapping(value = "test")
	public String test(Model model, User user, UserProfile userProfile) {
		model.addAttribute("user", user);
		List<String> genderList = userDao.getGenderList();
		model.addAttribute("genderList", genderList);

		List<String> stateList = userDao.getStateList();
		model.addAttribute("stateList", stateList);
		return "test";
	}

	//Mapping to retrieve the User's profile
	@RequestMapping(value = "userProfile")
	public String userProfile(Model model, User user) {
		User u = (User) session.getAttribute("user");
		UserProfile up = userDao.getUserProfile(u.getUsername());
		model.addAttribute("user", u);
		model.addAttribute("userProfile", up);
		return "userProfile";
	}

	//Mapping to edit user's profile
	@RequestMapping(value = "editProfile")
	public String editProfile(Model model, User user) {
		User u = (User) session.getAttribute("user");
		UserProfile up = userDao.getUserProfile(u.getUsername());
		model.addAttribute("user", u);
		model.addAttribute("userProfile", up);
		return "editProfile";
	}

	//To check the user's public profile
	@RequestMapping(value = "userPublicProfile", method = RequestMethod.GET)
	public String userPublicProfile(Model model, User user,
			@RequestParam("username") String username) {
		UserProfile up = userDao.getUserProfile(username);
		model.addAttribute("userProfile", up);
		return "userPublicProfile";
	}

	//Registration process for new user 
	@RequestMapping(value = "register")
	public String register(Model model) {
		UserProfile userProfile = new UserProfile();

		List<String> genderList = userDao.getGenderList();
		List<String> stateList = userDao.getStateList();
		List<String> monthList = userDao.getMonthList();

		model.addAttribute("genderList", genderList);
		model.addAttribute("stateList", stateList);
		model.addAttribute("monthList", monthList);

		model.addAttribute("userProfile", userProfile);
		return "register";
	}

	//Submitting registration and checks if the user is already registered or not
	@RequestMapping(value = "submitRegistration", method = RequestMethod.POST)
	public String submitRegistration(Model model, UserProfile userProfile,
			@RequestParam("password") String password) {
		userDao.submitUserRegistration(userProfile, password);
		int res = userDao.sendVerification(userProfile);
		if(res==-1) {
			return accessDenied(model);
		}
		return "submitRegistration";
	}
	
	//Verify the user by the link he/she would get on their e-mail
	@RequestMapping(value="verify")
	public String verify(Model model, @RequestParam("username")String username, @RequestParam("code")String code) {
		
		int res = userDao.verify(username, code);
		if(res==1) {
			return "verified";
		}
		else {
			model.addAttribute("msg","Link you have clicked in invalid!!!");
			return "error";
		}
	}

	//Verified page
	@RequestMapping(value="verified")
	public String verified(Model model) {
		return "verified";
	}
	
	//Error to show that the user has not verified his account
	@RequestMapping(value="unverified")
	public String unverified(Model model) {
		return "unverified";
	}
	
	//General error page
	@RequestMapping(value="error")
	public String error(Model model) {
		return "error";
	}
	
	//To edit a user's profile
	@RequestMapping(value = "editProfile", method = RequestMethod.POST)
	public String editProfile(Model model, UserProfile userProfile,
			@RequestParam("username") String username) {
		userDao.editProfile(username, userProfile);
		UserProfile up = userDao.getUserProfile(username);
		User u = (User) session.getAttribute("user");
		model.addAttribute("user", u);
		model.addAttribute("userProfile", up);
		return "userProfile";
	}

	//Mapping to retrieve user's friends and pending friend confirmation
	@RequestMapping(value = "friendList")
	public String friendList(Model model) {
		User user = (User) session.getAttribute("user");
		List<UserProfile> fList = userDao.getFriendNames(user.getUsername());
		List<UserProfile> fpList = userDao.getPendingFriendList(user
				.getUsername());
		model.addAttribute("fList", fList);
		model.addAttribute("fpList", fpList);
		return "friendList";
	}

	//Confirm a friend's request 
	@RequestMapping(value = "confirmRequest")
	public String confirmRequest(Model model,
			@RequestParam("uname") String uname) {
		User user = (User) session.getAttribute("user");
		userDao.confirmRequest(user.getUsername(), uname);
		return friendList(model);
	}

	//Reject a user's friend request
	@RequestMapping(value = "rejectRequest")
	public String rejectRequest(Model model, @RequestParam("uname") String uname) {
		User user = (User) session.getAttribute("user");
		userDao.rejectRequest(user.getUsername(), uname);
		return friendList(model);
	}

	//Delete a friend from friend list
	@RequestMapping(value = "deleteFriend")
	public String deleteFriend(Model model, @RequestParam("fName") String fname) {
		User user = (User) session.getAttribute("user");
		userDao.deleteFriend(user.getUsername(), fname);
		return friendList(model);
	}

	//Mapping to show messages that a user receives 
	@RequestMapping(value = "showMessages")
	public String showMessage(Model model) {
		User user = (User) session.getAttribute("user");
		String returnVal = "showMessages";
		try {
			List<Messages> messageList = userDao.showMessagesByUserName(user.getUsername());
			if (messageList != null) {
				int number = messageList.size();
				model.addAttribute("message", messageList);
				model.addAttribute("number", number);
				return returnVal;
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "showMessages";

	}

	//Mapping to open search page
	@RequestMapping(value = "search")
	public String search(Model model) {
		return "search";
	}

	//To search a particular user by name
	@RequestMapping(value = "search", method = RequestMethod.POST)
	public String search111(Model model, @RequestParam("name") String username) {
		// String username = "a";
		List<UserProfile> userProfile = userDao.getUserProfiles(username);
		model.addAttribute("sList", userProfile);
		return "search";
	}

	//Delete a user's message and update the list
	@RequestMapping(value = "deleteMessage", method = RequestMethod.GET)
	public String deleteMessage(Model model, @RequestParam("mid") int mid) {
		User user = (User) session.getAttribute("user");
		int update = 0;
		List<Messages> messageList;
		try {
			update = userDao.deleteMessage(mid);
			messageList = userDao.showMessagesByUserName(user.getUsername());
			if (messageList != null) {
				int number = messageList.size();
				model.addAttribute("message", messageList);
				model.addAttribute("number", number);
				return "showMessages";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("msg", "Could not delete message");
		return "error";
	}

	//Reply to a user's message 
	@RequestMapping(value = "replyMessage")
	public String replyMessage(Model model,
			@RequestParam("toUser") String toUser, @RequestParam("mid") int mid) {
		model.addAttribute("toUser", toUser);
		User user = (User) session.getAttribute("user");
		model.addAttribute("fromUser", user.getUsername());
		Messages messages = new Messages();
		model.addAttribute("messages", messages);
		try {
			List<Messages> messageList = userDao.showMessagesByMessageId(mid);
			if (messageList != null) {
				model.addAttribute("message", messageList);
				// model.addAttribute("messages", messageList);
				return "showReplyMessage";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("msg","Error is replying");
		return "error";
	}

	//Send a new message to a user
	@RequestMapping(value = "sendNewMessage")
	public String sendNewMessage(Model model,
			@RequestParam("username") String username,
			@RequestParam("msg") String msg) {
		User user = (User) session.getAttribute("user");
		try {
			int res = userDao.replyToMessage(user.getUsername(), username, msg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return friendList(model);
	}

	//Submitting a reply to the user's message
	@RequestMapping(value = "replyToMessage", method = RequestMethod.POST)
	public String replyToMessage(Model model, Messages messages,
			@RequestParam("request") String request) {
		model.addAttribute("messages", messages);
		User user = (User) session.getAttribute("user");
		String receiver = request;
		try {
			int update = userDao.replyToMessage(user.getUsername(), receiver,
					messages.getMessage());
			if (update == 1) {
				return showMessage(model);

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "error";

	}

	//Add a friend to friend list after finding using the search page
	@RequestMapping(value = "addFriend", method = RequestMethod.GET)
	public String addFriend(Model model,
			@RequestParam("friendname") String friendname) {
		User user = (User) session.getAttribute("user");
		int res = 0;
		
		//You cannot add yourself as a friend
		if (user.getUsername().equals(friendname)) {
			model.addAttribute("msg","You cannot add yourself");
			return "error";
		}
		
		//Confirmation on addding a friend
		res = userDao.addFriend(user.getUsername(), friendname);
		if (res == 0) {
			model.addAttribute("msg","Added!!!");
		}
		
		//Check to see if the user is already added to the list
		if (res == 1) {
			model.addAttribute("msg", "Already Friend");
		}
		
		//Message to user saying the friend has already been added but has not accepted the request yet
		if (res == 2) {
			model.addAttribute("msg", "Request Pending");
		}
		return "search";
	}

	//Page to change password
	@RequestMapping(value = "changePassword")
	public String changePassword(Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("password", user.getPassword());
		return "changePassword";
	}

	//Page to submit the change of password
	@RequestMapping(value = "submitPasswordChange")
	public String submitPasswordChange(Model model, @RequestParam("newPassword") String newPassword) {
		User user = (User) session.getAttribute("user");
		User u =userDao.changePassword(user, newPassword);
		session.setAttribute("user", u);
		return changePassword(model);
	}

	//Logout function which also clears the cookie information
	@RequestMapping(value = "logout")
	public String logout(Model model, HttpServletResponse response) {

		Cookie userName = new Cookie("userName", "");
		userName.setMaxAge(0);
		response.addCookie(userName);

		Cookie userPassword = new Cookie("userPassword", "");
		userName.setMaxAge(0);
		response.addCookie(userPassword);

		session.removeAttribute("user");

		model.addAttribute(response);
		return "logout";
	}

	//Check availability of a username
	@RequestMapping(value = "checkAvailability")
	public @ResponseBody String checkAvailability(
			@RequestParam("username") String username) {
		String res = "1";
		UserProfile up = userDao.getUserProfile(username);
		if (up == null) {
			res = "0";
		}
		return res;
	}

	//User search based on age range Eg: 18 - 25
	@RequestMapping(value = "findMatch", method = RequestMethod.POST)
	public String findMatch(Model model, UserProfile userProfile,
			@RequestParam("age1") int age1, @RequestParam("age2") int age2) {
		List<UserProfile> upList = userDao.findMatch(userProfile, age1, age2);

		model.addAttribute("sList", upList);
		return "search";
	}

	//Load the profile picture
	@RequestMapping(value = "pic")
	public String pic(Model model, ProfilePicture ppPic) {
		ProfilePicture pPic = new ProfilePicture();
		model.addAttribute("pPic", pPic);
		return "pic";
	}

	//Mapping to upload the profile picture or change the existing one 
	@RequestMapping(value = "pic2")
	public String pic2(Model model, ProfilePicture pPic) {

		User user = (User) session.getAttribute("user");
		CommonsMultipartFile file = pPic.getProfilePic();

		//Cannot upload empty file
		if (file.isEmpty()) {
			model.addAttribute("msg","File cannot be empty!!!");
			return "error";
		}
		
		//Location of the profile picture
		File localFile = new File(
				"C:\\Users\\Vinay Limbare\\Documents\\workspace-sts-3.6.4.RELEASE\\final_project_sns\\src\\main\\webapp\\resources\\images\\profilepic\\",
				user.getUsername() + ".jpg");

		userDao.setProfilePic(user.getUsername(), user.getUsername());

		try {
			file.transferTo(localFile);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("pPic", pPic);
		model.addAttribute("msg", "File uploaded");
		return "pic";
	}

	//Page to open group search  
	@RequestMapping(value = "searchGroup")
	public String searchGp(Model model) {
		return "searchGroup";
	}

	//Search for groups or community based on the search term given
	@RequestMapping(value = "searchGroup", method = RequestMethod.POST)
	public String searchGroup(Model model, @RequestParam("gname") String gname) {
		
		List<Group> groupList = groupDao.getAllGroup(gname);
		model.addAttribute("gList", groupList);
		return "searchGroup";
	}

	//Join the group which has not been joined earlier
	@RequestMapping(value = "joinGroup")
	public String joinGroup(Model model, @RequestParam("gid") int gid) {
		User user = (User) session.getAttribute("user");
		if (user.getUsername().equals(null)) {
			return accessDenied(model);
		}

		boolean res = groupDao.joinGroup(gid, user.getUsername());
		if (res == false) {
			model.addAttribute("msg","Already joined the group!!!");
			return "error";
		}
		return searchGp(model);
	}

	//Show the list of messages sent in that group
	@RequestMapping(value = "showGroupMessages")
	public String showGroupMessages(Model model, @RequestParam("gid") int gid) {
		User user = (User) session.getAttribute("user");
		GroupMessages gMsg = new GroupMessages();
		List<GroupMessages> gMList = groupDao.getGroupMessages(gid);
		model.addAttribute("gMList", gMList);
		model.addAttribute("gId", gid);
		model.addAttribute("gMsg", gMsg);
		model.addAttribute("sender", user.getUsername());
		return "showGroupMessages";
	}

	//Send a message to the group
	@RequestMapping(value = "sendGroupMessage")
	public String sendGroupMessage(Model model, GroupMessages groupMessages) {
		groupDao.sendGroupMessage(groupMessages);
		int gid = groupMessages.getGroupId();
		return showGroupMessages(model, gid);
	}

	//Create a new group
	@RequestMapping(value = "createGroup")
	public String createGroup(Model model) {
		Group group = new Group();
		model.addAttribute("group", group);
		return "createGroup";
	}

	//Submit the form to create a new group
	@RequestMapping(value = "createGroup", method = RequestMethod.POST)
	public String submitNewGroup(Model model, Group group) {
		groupDao.createGroup(group);
		model.addAttribute("msg", "Group has been created");
		return "createGroup";
	}
}
