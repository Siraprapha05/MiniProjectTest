package org.itsci.vegetable.controller;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.TimeZone;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.itsci.vegetable.model.Logins;
import org.itsci.vegetable.model.Member;
import org.itsci.vegetable.model.Member_shifts;
import org.itsci.vegetable.model.Register;
import org.itsci.vegetable.dao.RegisterManager;
import org.itsci.vegetable.dao.MemberManager;
import org.itsci.vegetable.dao.MembershiftManager;

@Controller
public class MembersController {
	/*add shift*/
	@RequestMapping(value="/goAddshift", method=RequestMethod.GET)
	public String goAddshift(HttpServletRequest request,HttpSession session) {
		
		Logins log = (Logins) session.getAttribute("login");
		MemberManager lmem = new MemberManager();
		System.out.println(log.getMember().getMember_id());
		
		Member listmember = lmem.getMember(log.getMember().getMember_id());
		
		session.setAttribute("member", listmember);
	
		return "addshift";
	
	}
	
	@RequestMapping(value="/insertAddshift", method=RequestMethod.POST)
	public String insertAddshift(HttpServletRequest request,HttpSession session) throws ParseException {
		try {
			request.setCharacterEncoding("UTF-8");
				} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		int rr=-1;
		Calendar cal = new GregorianCalendar();
		Calendar cal_date = new GregorianCalendar();
		
		Calendar cal_e_date = new GregorianCalendar();
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		
		/*auto number*/ 
        long unix = System.currentTimeMillis()/1000;
	        String msid = "s"+Long.toString(unix);
	        
        String task_name = request.getParameter("task_name");
        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
		Date _date = sdf.parse(date);
		sdf.format(_date);
		
		String[] st = startTime.split(":");
		int hour = Integer.parseInt(st[0]);
		int min = Integer.parseInt(st[1]);
		cal.set(Calendar.HOUR_OF_DAY, hour);
		cal.set(Calendar.MINUTE, min);
		String register_id = request.getParameter("register_id");
		String[] new_date = date.split("-");
		cal_date.set(Integer.parseInt(new_date[0])-543, Integer.parseInt(new_date[1])-1, Integer.parseInt(new_date[2]));
	
		String[] et = endTime.split(":");
		int et_hour = Integer.parseInt(et[0]);
		int et_min = Integer.parseInt(et[1]);
		cal_e_date.set(Calendar.HOUR_OF_DAY, et_hour);
		cal_e_date.set(Calendar.MINUTE, et_min);
	
       Register r = new Register();
       r.setRegister_id(register_id);
        
        Member_shifts ms = new Member_shifts(msid,task_name,cal_date,cal,cal_e_date,0,r);
   
        MembershiftManager msm = new MembershiftManager();
		rr=msm.insertShift(ms);
		 if(rr==1) {
			 request.setAttribute("resultAddshift", "บันทึกเวลาทำงานเสร็จสิ้น รอการอนุมัติ");
				return "content";
			}else {
			 request.setAttribute("resultAddshift", "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง !!!");
				return "addshift";
			}
	}
	
	/*end addshift*/
	
	
	/*listShift*/
	@RequestMapping(value="/golistShift", method=RequestMethod.GET)
	public String golistShift(HttpServletRequest request,HttpSession session) {
	return "listShift";
	}
	
	
	@RequestMapping(value="/approveShift", method=RequestMethod.GET)
	public String goapproveShift(HttpServletRequest request,HttpSession session) {
		String mid = request.getParameter("id");
		MemberManager lmem = new MemberManager();
		RegisterManager Regis = new RegisterManager();
		
		Member listmember = Regis.getMember_shift(Regis.getMember_shift(mid).getStudent_code());
		session.setAttribute("ShowMember", listmember);
	return "approveShift";

	}
	/*approveShift*/
	@RequestMapping(value="/updateApproveshift", method=RequestMethod.POST)
	public String updateApproveshift(HttpServletRequest request,HttpSession session) throws ParseException {
		try {
			request.setCharacterEncoding("UTF-8");
				} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();			
		}
		int r=-1;
		Calendar cal = new GregorianCalendar();
		Calendar cal_date = new GregorianCalendar();
		Calendar cal_e_date = new GregorianCalendar();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
	    String msid = request.getParameter("member_shift_id");    
	    System.out.println(msid);
        String task_name = request.getParameter("task_name");
        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
		Date _date = dateFormat.parse(date);
		dateFormat.format(_date);
		cal_date = dateFormat.getCalendar();
		String[] st = startTime.split(":");
		int hour = Integer.parseInt(st[0]);
		int min = Integer.parseInt(st[1]);
		cal.set(Calendar.HOUR_OF_DAY, hour);
		cal.set(Calendar.MINUTE, min);
		String register_id = request.getParameter("register_id");
		
	
		String[] et = endTime.split(":");
		int et_hour = Integer.parseInt(et[0]);
		int et_min = Integer.parseInt(et[1]);
		cal_e_date.set(Calendar.HOUR_OF_DAY, et_hour);
		cal_e_date.set(Calendar.MINUTE, et_min);
	
       Register rg = new Register();
       rg.setRegister_id(register_id);
        
        Member_shifts ms = new Member_shifts(msid,task_name,cal_date,cal,cal_e_date,1,rg);
   
        
        MembershiftManager msm = new MembershiftManager();
		r=msm.ApproveShift(ms);
		
		 if(r==1) {
			 request.setAttribute("resultApproveshift", "การตรวจสอบสำเสร็จ");
				return "listShift";
			}else {
			 request.setAttribute("resultApproveshift", "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง !!!");
				return "approveShift";
			}
	}
	/*approvecancelShift*/
	@RequestMapping(value="/updateApproveCancelshift", method=RequestMethod.GET)
	public String updateApproveCancelshift(HttpServletRequest request,HttpSession session) throws ParseException {
		try {
			request.setCharacterEncoding("UTF-8");
				} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();			
		}
		int r=-1;
		Calendar cal_e_date = new GregorianCalendar();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
	    String msid = request.getParameter("msid");    
        String task_name = request.getParameter("tn");  
        String endTime = request.getParameter("eT");		
	
		String[] et = endTime.split(":");
		int et_hour = Integer.parseInt(et[0]);
		int et_min = Integer.parseInt(et[1]);
		cal_e_date.set(Calendar.HOUR_OF_DAY, et_hour);
		cal_e_date.set(Calendar.MINUTE, et_min);
	
       
        
        Member_shifts ms = new Member_shifts(msid,task_name,cal_e_date,3);
   
        
        MembershiftManager msm = new MembershiftManager();
		r=msm.ApproveShift(ms);
		
		 if(r==1) {
			 request.setAttribute("resultApproveshift", "การตรวจสอบสำเสร็จ");
				return "listShift";
			}else {
			 request.setAttribute("resultApproveshift", "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง !!!");
				return "approveShift";
			}
	}
	/*my profile*/
	
	@RequestMapping(value="/goViewprofile", method=RequestMethod.GET )
    public String goViewprofile(){ 
        return"viewprofile";
        }
	
	 @RequestMapping(value="/loadEditprofile", method=RequestMethod.POST )
	 public String loadEditprofile(){ 	  
	    return"editProfile";
	    }  
	 
	 @RequestMapping(value="/submitEdit", method=RequestMethod.POST)
	    public String submitEdit(HttpServletRequest request, Model md, HttpSession session) {
			Calendar birthdate = Calendar.getInstance();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
		 try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        
			String prefix ="";
			int pf =0;
			 if(request.getParameter("prefix").equalsIgnoreCase("prefix")) {
				 prefix = "นาย";
				 pf=0;
			 }else {
				 prefix = "นางสาว";
				 pf=1;
			 }
			 
			 String name = request.getParameter("name");
		
			 String phone = request.getParameter("phone");
			 
			 String birthday = request.getParameter("birthday");
			 
			 String date[] = birthday.split("-");
			 		birthdate.set(Integer.parseInt(date[0]), Integer.parseInt(date[1])-1, Integer.parseInt(date[2]));
		
			 
			 String officer_position =request.getParameter("officer_position") ;

			 String stucode = request.getParameter("stucode");
			 String major = request.getParameter("major");
			 String faculty = request.getParameter("faculty");
			 String member_type = request.getParameter("member_type");
			 String member_id = request.getParameter("member_id");

			 Member mb = new Member(member_id,pf,name,phone,birthdate,"",stucode,major,faculty,"สมาชิก");
			 MemberManager mm = new MemberManager();

	        int r = mm.editProfile(mb);
	        session.setAttribute("member", mb);
	        if(r==1) {
				request.setAttribute("Editresult", "แก้ไขข้อมูลส่วนตัวสำเร็จ");
				return "viewprofile";
			}else {
				request.setAttribute("Editresult", "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง !!!");
				return "editProfile";
			}
	 	}
	 
		 @RequestMapping(value="/search_status_membershift", method=RequestMethod.POST)
		    public String search_status_membershift(HttpServletRequest request, Model md, HttpSession session) {
			 	List<Member_shifts> ms = new Vector<>(); 
			 	String status = request.getParameter("status");
			 
			 	MembershiftManager mm = new MembershiftManager();
			 
			 	ms = mm.SearchListShifts(status);
			 	request.setAttribute("ListMemberShift", ms);
			 	request.setAttribute("status", status);
		        return "listShift";
		 	}
}
