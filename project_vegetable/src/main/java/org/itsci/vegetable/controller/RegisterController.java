package org.itsci.vegetable.controller;


import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.itsci.vegetable.model.Logins;
import org.itsci.vegetable.model.Member;
import org.itsci.vegetable.model.Projects;
import org.itsci.vegetable.model.Register;
import org.itsci.vegetable.dao.MemberManager;
import org.itsci.vegetable.dao.ProjectsManager;
import org.itsci.vegetable.dao.RegisterManager;

@Controller
public class RegisterController {
	@RequestMapping(value="/goRegister", method=RequestMethod.GET )
    public String goRegister(){ 
        return"register";
        }
	/*insertRegister*/
	@RequestMapping(value="/insertRegister", method=RequestMethod.POST)
	public String insertRegister(HttpServletRequest request,HttpSession session) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		Calendar birthdate = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
        int r=-1;
       /*ไอดี*/ 
        long unix = System.currentTimeMillis()/1000;
	        String mid = "m"+Long.toString(unix);
	        /*String pjid = "p"+Long.toString(unix);*/
	        String regid = "r"+Long.toString(unix);
	        
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
		 Calendar bd = Calendar.getInstance();
		 String reason = request.getParameter("reason");
		 
		 Calendar rd = Calendar.getInstance();
		 String term ;
			if( rd.get(Calendar.MONTH)+1 >= 7 && rd.get(Calendar.MONTH)+1 <= 10 ) {
				term = "1";
			}else{
				term = "2";
			}
		 	
		 String stucode = request.getParameter("stucode");
		 String major = request.getParameter("major");
		 String faculty = request.getParameter("faculty");
		 String email = request.getParameter("email");
		 String password = request.getParameter("password");
		 	 	 
		 ProjectsManager pm = new ProjectsManager();
		 Projects pj;
		 
		 for(int i=0;i<pm.getProjects().size();i++) {
			 if(pm.getProjects().get(i).getProject_id().equals(faculty)){
			 pj = new Projects(faculty,pm.getProjects().get(i).getName(),pm.getProjects().get(i).getCost_amount());
			 
			 Member mb = new Member(mid,pf,name,phone,bd,"",stucode,major,faculty,"รอการอนุม้ติ");
			 Logins log = new Logins(email,password,0,mb);
			 Register reg = new Register (regid,reason,rd,term,0,mb,pj);
			 
			 MemberManager mm = new MemberManager();
			 RegisterManager rm =new RegisterManager();
			 
			r=  mm.insertMembers(mb);
			r=  rm.insertRegister(reg);
			r= mm.insertLogins(log, mb);
			 if(r==1) {
					request.setAttribute("resultRegis", "สมัครสมาชิกสำเร็จ รอการอนุมัติ");
					return "login";
				}else {
					request.setAttribute("resultRegis", "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง !!!");
					return "register";
				} 
			 }
		 }
		return "content";
	}
	
}
