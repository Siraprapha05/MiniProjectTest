package org.itsci.vegetable.controller;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.itsci.vegetable.model.Member;
import org.itsci.vegetable.model.Register;
import org.itsci.vegetable.dao.RegisterManager;
import org.itsci.vegetable.dao.MemberManager;

@Controller
public class OfficerController {
	/*listShift*/
	@RequestMapping(value="/golistRegisterReq", method=RequestMethod.GET)
	public String golistRegisterReq(HttpServletRequest request,HttpSession session) {
	return "listRegisterReq";
	}
	/*approveReq*/
	@RequestMapping(value="/goapproveReq", method=RequestMethod.GET)
	public String goapproveReq(HttpServletRequest request,HttpSession session) {
		String rqid = request.getParameter("id");
		RegisterManager Regis = new RegisterManager();
		Register register = Regis.getRegisterById(rqid);
		
		session.setAttribute("showReq", register);
	return "approveReq";
	}
	/*approveReq*/
	@RequestMapping(value="/approveReq", method=RequestMethod.POST)
	public String approveReq (HttpServletRequest request,HttpSession session) {
		int r = -1;
		Register register = (Register) session.getAttribute("showReq");
		String rid =request.getParameter("id");
		RegisterManager Regis = new RegisterManager();
		r=Regis.approveReq(rid);
		r=Regis.updateLogin_status(register.getMember().getMember_id());
		r=Regis.updateMember_status(register.getMember().getMember_id());
		request.setAttribute("resultApprove", r);

		return "listRegisterReq";
	}
	@RequestMapping(value="/cancelApproveReq",method=RequestMethod.GET)
	public String cancelApproveReq (HttpServletRequest request,HttpSession session) {
		int r = -1;
		String rid =request.getParameter("id");
		Register register = (Register) session.getAttribute("showReq");

		RegisterManager Regis = new RegisterManager();
		r=Regis.deleteLogin(register.getMember().getMember_id());
		r=Regis.cancelApproveReq(rid);
		r=Regis.deleteMember(register.getMember().getMember_id());
		request.setAttribute("resultCancel", r);

		return "listRegisterReq";
	}
	
	/*listMember*/
	@RequestMapping(value="/golistMember", method=RequestMethod.GET)
	public String golistMember(HttpServletRequest request,HttpSession session) {
	return "listMember";
	}
	
	@RequestMapping(value="/goSetPermissions", method=RequestMethod.GET)
	public String goSetPermissions(HttpServletRequest request,HttpSession session) {
		String mid = request.getParameter("id");
		MemberManager mm = new MemberManager();
		Member member = mm.getMember(mid);
		
		session.setAttribute("showmember", member);
	return "setPermissions";
	}
	@RequestMapping(value="/updateSetPermissions", method=RequestMethod.POST)
	public String updateSetPermissions(HttpServletRequest request,HttpSession session) throws ParseException {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
				String member_id = request.getParameter("member_id");     
			 	String name = request.getParameter("name");     
		        String major = request.getParameter("major");
		        String faculty = request.getParameter("faculty");
		        String phone = request.getParameter("phone");
		        String setpermission = request.getParameter("setpermission");
		        
		        RegisterManager Regis = new RegisterManager();
		        Regis.setRegister_status(member_id,Integer.parseInt(setpermission));
		        Regis.setLogin_status(member_id,Integer.parseInt(setpermission));
		        Regis.setMember_status(member_id,Integer.parseInt(setpermission));
		        
				 session.setAttribute("message", "บันทึกข้อมูลนักศึกษาเสร็จสิ้น");
		        
		
		return "listMember";
		
	}
}
