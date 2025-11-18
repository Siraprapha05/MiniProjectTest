package org.itsci.vegetable.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.itsci.vegetable.model.Logins;
import org.itsci.vegetable.dao.LoginManager;

@Controller
public class LoginController {
	@RequestMapping(value = "/goHomepage", method = RequestMethod.GET)
	public String goHomepage() {
		return "content";
	}

	@RequestMapping(value = "/goLogin", method = RequestMethod.GET)
	public String goLogin() {
		return "login";
	}

	@RequestMapping(value = "/isMemberLogin", method = RequestMethod.POST)
	public String memberLogin(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String email = request.getParameter("email");
		String password = request.getParameter("pwd");
		LoginManager lm = new LoginManager();
		Logins log = lm.verifyLogin(email, password);
		session.setMaxInactiveInterval(60 * 60);

		if (log == null) {
			request.setAttribute("result", "Email หรือ Passwordไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง");
			return "login";
		} else {
			if (log.getStatus() == 0) {
				session.setAttribute("login", log);
				return "login";
			} else {
				session.setAttribute("login", log);
				return "content";
			}
			/* login pass */

		}
	}

	@RequestMapping(value = "/dologout", method = RequestMethod.GET)
	public String dologout(HttpServletRequest request, HttpSession session) {
		session.removeAttribute("login");
		session.removeAttribute("ListTran");
		return "content";
	}
}
