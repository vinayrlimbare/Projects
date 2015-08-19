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

	@Autowired
	@Qualifier("userValidator")
	private Validator validator;

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
				//JOptionPane.showMessageDialog(null, u.getStatus());
				if (u != null && u.getStatus().equals("Y")) {
					session = request.getSession();
					session.setAttribute("user", u);

					if (u.getRole().equals("ADMIN")) {
						model.addAttribute("user", u);
						return "admin";
					}

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

	@RequestMapping(value = "mainAdminFrame")
	public String mainAdminFrame(Model model, User user) {
		model.addAttribute("user", user);
		return "mainAdminFrame";
	}

	@RequestMapping(value = "mainAdminPage")
	public String mainAdminPage(Model model, User user) {
		model.addAttribute("user", user);
		return "mainAdminPage";
	}

	@RequestMapping(value = "adminViewProfile")
	public String adminViewProfile(Model model) {
		List<UserProfile> up = adminDao.getAllUserProfile();
		model.addAttribute("userProfileList", up);
		return "adminViewProfile";
	}

	@RequestMapping(value = "deleteProfile")
	public String mainAdminPage(Model model,
			@RequestParam("username") String username) {
		adminDao.deleteProfile(username);
		return "mainAdminPage";
	}

	@RequestMapping(value = "mainPageFrame")
	public String mainPageFrame(Model model) {
		// model.addAttribute("user", user);
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

	@RequestMapping(value = "accessDenied")
	public String accessDenied(Model model) {
		return "accessDenied";
	}

	@RequestMapping(value = "mainPageHeader")
	public String mainPageHeader(Model model) {
		// model.addAttribute("user", user);
		User user = (User) session.getAttribute("user");
		model.addAttribute("fname", user.getUserProfile().getFname());
		model.addAttribute("lname", user.getUserProfile().getLname());
		return "mainPageHeader";
	}

	@RequestMapping(value = "test")
	public String test(Model model, User user, UserProfile userProfile) {
		model.addAttribute("user", user);
		/* model.addAttribute("") */
		List<String> genderList = userDao.getGenderList();
		model.addAttribute("genderList", genderList);

		List<String> stateList = userDao.getStateList();
		model.addAttribute("stateList", stateList);
		return "test";
	}

	@RequestMapping(value = "userProfile")
	public String userProfile(Model model, User user) {
		User u = (User) session.getAttribute("user");
		UserProfile up = userDao.getUserProfile(u.getUsername());
		model.addAttribute("user", u);
		model.addAttribute("userProfile", up);
		return "userProfile";
	}

	@RequestMapping(value = "editProfile")
	public String editProfile(Model model, User user) {
		User u = (User) session.getAttribute("user");
		UserProfile up = userDao.getUserProfile(u.getUsername());
		model.addAttribute("user", u);
		model.addAttribute("userProfile", up);
		return "editProfile";
	}

	@RequestMapping(value = "userPublicProfile", method = RequestMethod.GET)
	public String userPublicProfile(Model model, User user,
			@RequestParam("username") String username) {
		// User u = (User)session.getAttribute("user");
		UserProfile up = userDao.getUserProfile(username);
		// model.addAttribute("user", u);
		model.addAttribute("userProfile", up);
		return "userPublicProfile";
	}

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

	@RequestMapping(value = "submitRegistration", method = RequestMethod.POST)
	public String submitRegistration(Model model, UserProfile userProfile,
			@RequestParam("password") String password) {
		userDao.submitUserRegistration(userProfile, password);
		int res = userDao.sendVerification(userProfile);
		// model.addAttribute("userProfile", userProfile);
		if(res==-1) {
			return accessDenied(model);
		}
		return "submitRegistration";
	}
	
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

	@RequestMapping(value="verified")
	public String verified(Model model) {
		return "verified";
	}
	
	@RequestMapping(value="unverified")
	public String unverified(Model model) {
		return "unverified";
	}
	
	@RequestMapping(value="error")
	public String error(Model model) {
		return "error";
	}
	
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

	@RequestMapping(value = "confirmRequest")
	public String confirmRequest(Model model,
			@RequestParam("uname") String uname) {
		User user = (User) session.getAttribute("user");
		userDao.confirmRequest(user.getUsername(), uname);
		return friendList(model);
	}

	@RequestMapping(value = "rejectRequest")
	public String rejectRequest(Model model, @RequestParam("uname") String uname) {
		User user = (User) session.getAttribute("user");
		userDao.rejectRequest(user.getUsername(), uname);
		return friendList(model);
	}

	@RequestMapping(value = "deleteFriend")
	public String deleteFriend(Model model, @RequestParam("fName") String fname) {
		User user = (User) session.getAttribute("user");
		userDao.deleteFriend(user.getUsername(), fname);
		return friendList(model);
	}

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

	@RequestMapping(value = "search")
	public String search(Model model) {
		// String username = "a";
		// List<UserProfile> userProfile = userDao.getUserProfiles("");
		// model.addAttribute("sList", userProfile);
		return "search";
	}

	@RequestMapping(value = "search", method = RequestMethod.POST)
	public String search111(Model model, @RequestParam("name") String username) {
		// String username = "a";
		List<UserProfile> userProfile = userDao.getUserProfiles(username);
		model.addAttribute("sList", userProfile);
		return "search";
	}

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

	@RequestMapping(value = "sendNewMessage")
	public String sendNewMessage(Model model,
			@RequestParam("username") String username,
			@RequestParam("msg") String msg) {
		/*
		 * JOptionPane.showMessageDialog(null, msg);
		 * JOptionPane.showMessageDialog(null, username);
		 */
		User user = (User) session.getAttribute("user");
		try {
			int res = userDao.replyToMessage(user.getUsername(), username, msg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return friendList(model);
	}

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

	@RequestMapping(value = "addFriend", method = RequestMethod.GET)
	public String addFriend(Model model,
			@RequestParam("friendname") String friendname) {
		User user = (User) session.getAttribute("user");
		int res = 0;
		if (user.getUsername().equals(friendname)) {
			model.addAttribute("msg","You cannot add yourself");
			return "error";
		}
		res = userDao.addFriend(user.getUsername(), friendname);
		if (res == 0) {
			model.addAttribute("msg","Added!!!");
		}
		if (res == 1) {
			model.addAttribute("msg", "Already Friend");
		}
		if (res == 2) {
			model.addAttribute("msg", "Request Pending");
		}
		return "search";
	}

	@RequestMapping(value = "changePassword")
	public String changePassword(Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("password", user.getPassword());
		return "changePassword";
	}

	@RequestMapping(value = "submitPasswordChange")
	public String submitPasswordChange(Model model, @RequestParam("newPassword") String newPassword) {
		//JOptionPane.showMessageDialog(null, "Password Chnged!!!");
		User user = (User) session.getAttribute("user");
		User u =userDao.changePassword(user, newPassword);
		session.setAttribute("user", u);
		return changePassword(model);
	}

	@RequestMapping(value = "logout")
	public String logout(Model model, HttpServletResponse response) {
		// model.addAttribute("response", response);

		Cookie userName = new Cookie("userName", "");
		userName.setMaxAge(0);
		response.addCookie(userName);

		Cookie userPassword = new Cookie("userPassword", "");
		userName.setMaxAge(0);
		response.addCookie(userPassword);

		// session.invalidate();
		session.removeAttribute("user");
		// session.setAttribute("user",null);

		model.addAttribute(response);
		return "logout";
	}

	@RequestMapping(value = "checkAvailability")
	public @ResponseBody String checkAvailability(
			@RequestParam("username") String username) {
		String res = "1";
		UserProfile up = userDao.getUserProfile(username);
		/* JOptionPane.showMessageDialog(null,username); */
		if (up == null) {
			res = "0";
		}
		return res;
	}

	@RequestMapping(value = "findMatch", method = RequestMethod.POST)
	public String findMatch(Model model, UserProfile userProfile,
			@RequestParam("age1") int age1, @RequestParam("age2") int age2) {
		List<UserProfile> upList = userDao.findMatch(userProfile, age1, age2);

		model.addAttribute("sList", upList);
		return "search";
	}

	@RequestMapping(value = "pic")
	public String pic(Model model, ProfilePicture ppPic) {
		ProfilePicture pPic = new ProfilePicture();
		model.addAttribute("pPic", pPic);
		return "pic";
	}

	@RequestMapping(value = "pic2")
	public String pic2(Model model, ProfilePicture pPic) {

		User user = (User) session.getAttribute("user");
		CommonsMultipartFile file = pPic.getProfilePic();

		if (file.isEmpty()) {
			model.addAttribute("msg","File cannot be empty!!!");
			return "error";
		}
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

	/*
	 * @RequestMapping(value="searchGroup") public String searchAllGroup(Model
	 * model) { User user = (User) session.getAttribute("user"); List<Group>
	 * groupList = groupDao.getAllGroup(0);
	 * model.addAttribute("gList",groupList); return "searchGroup"; }
	 */

	@RequestMapping(value = "searchGroup")
	public String searchGp(Model model) {
		return "searchGroup";
	}

	@RequestMapping(value = "searchGroup", method = RequestMethod.POST)
	public String searchGroup(Model model, @RequestParam("gname") String gname) {
		// User user = (User) session.getAttribute("user");
		List<Group> groupList = groupDao.getAllGroup(gname);
		/*for (Group group : groupList) {
			JOptionPane.showMessageDialog(null, group.getgName());
		}*/
		model.addAttribute("gList", groupList);
		return "searchGroup";
	}

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

	@RequestMapping(value = "sendGroupMessage")
	public String sendGroupMessage(Model model, GroupMessages groupMessages) {
		groupDao.sendGroupMessage(groupMessages);
		int gid = groupMessages.getGroupId();
		return showGroupMessages(model, gid);
	}

	@RequestMapping(value = "createGroup")
	public String createGroup(Model model) {
		Group group = new Group();
		model.addAttribute("group", group);
		return "createGroup";
	}

	@RequestMapping(value = "createGroup", method = RequestMethod.POST)
	public String submitNewGroup(Model model, Group group) {
		// model.addAttribute("group",group);
		// JOptionPane.showMessageDialog(null, group.getgName());
		groupDao.createGroup(group);
		model.addAttribute("msg", "Group has been created");
		return "createGroup";
	}
}
