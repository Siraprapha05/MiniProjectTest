<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="org.itsci.vegetable.model.*,org.itsci.vegetable.dao.*,java.util.*,java.text.SimpleDateFormat"%>
    <% 
	    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	    sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	    
	    MemberManager mbm = new MemberManager();
		Logins log = new Logins();
		Member mb = new Member();	
		try{
				log = (Logins)session.getAttribute("login");
				mb = mbm.getMember(log.getMember().getMember_id());		
		}catch (Exception e) {	
			
		} 
    	RegisterManager rm = new RegisterManager();
    	Register r = rm.getRegister(mb.getMember_id());
    	
    	ProjectsManager pjm = new ProjectsManager();
    	Projects pj = pjm.getprojectName(r.getProjects().getProject_id());
    	
    	String edit_profile = null;
    	try{
    		edit_profile= (String) request.getAttribute("Editresult");
    	}catch(Exception e){
    		
    	}
   	%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>   
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>
<title>ข้อมูลส่วนตัว</title>

	<script>  
   				
				 <%if( edit_profile != null) {%>
					 $(document).ready(function(){
						  alert('แก้ไขข้อมูลส่วนตัวสำเร็จ');
					
			  		});  
				 <%}%>
  		</script>
</head>
<body>
<jsp:include page="basic/header.jsp" />   
<form name="fm1" class="fit" method="post" action="loadEditprofile" >
    <div align="center"  >
        <p>ข้อมูลส่วนตัว</p>
        
    
    <table>                
        <tr>
            <td>
                <div class="form-floating">
                    <input type="text" name="name" id="name" class="form-control registered" placeholder="ชื่อ-นามสกกุล" Onblur="from(fm1)" value="<%= mb.getMember_name() %>" readonly>
                    <label for="floating">ชื่อ-นามสกุล</label>
                  </div>
            </td>
            <td>
                <div class="form-floating">
                    <input type="text" name="stucode" id="stucode" class="form-control registered" placeholder="รหัสนักศึกษา" Onblur="from(fm1)" value="<%= mb.getStudent_code() %>" readonly>
                    <label for="floating">รหัสนักศึกษา</label>
                  </div>
            </td>
        </tr>
       
        <tr>
            <td>
                <div class="form-floating">
                    <input type="text" name="phone" id="phone" class="form-control registered" placeholder="เบอร์โทรศัพท์" Onblur="from(fm1)" value="<%= mb.getMember_phone() %>" readonly>
                    <label for="floating">เบอร์โทรศัพท์</label>
                  </div>
            </td>
            <td>
                    <div class="form-floating">
                    <input type="text" name="major" id="major" class="form-control registered" value="<%= mb.getStudent_major() %>"  placeholder="สาขา" readonly>
                    <label for="floating">สาขา</label>
                </div>
            </td>
        </tr>
     
        <tr>
            <td>
                <div class="form-floating">
                    <input type="text" name="birthday" id="birthday" class="form-control registered" placeholder="วันเกิด" value="<%= sdf.format(mb.getMember_birthday().getTime()) %>" readonly>
                    <label for="floating">วันเกิด</label>
                  </div>
            </td>
            <td>
                <div class="form-floating">
                    <input type="text" name="faculty" id="faculty" class="form-control registered" placeholder="สังกัดคณะ/โครงการ" value="<%= pj.getName() %>" readonly >
                    <label for="floating">สังกัดคณะ/โครงการ</label>
                  </div>
            </td>
        </tr>
    </table>
       <input type="submit" value="แก้ไขข้อมูลส่วนตัว"  class="btnsubmit btnSite">    
</div>
		
</form>
<jsp:include page="basic/footer.jsp" />
</body>
<style>

*{
   margin: 0;
   padding: 0;
   box-sizing: border-box;
   font-family: 'Mitr', sans-serif;
   z-index:2;
}
p{
    font-size: 30px;
    color:#353b48; 
}

.fit {
	
    background-color: #f5f4f4;
    border-radius: 2px;
    margin-left: 480px;
    margin-right: 457px;
    margin-top: 155px;
    margin-bottom: 150px;
    padding: 64px;
    padding-top: 44px;
    display: flex;
    justify-items: center;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.registered{
    width:215px;
    margin: 5px;
}

.btnSite{
    height: 40px;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 10px;
    margin-bottom: 5;
    background-color: #9E9E9E;
    border: 0;
    color: #9E9E9E;
    margin: 0;
    margin-top:20px;
}

.btnSite:hover{
    background-color: #9E9E9E;
}

.btnSelect:hover{
    background-color: #BDBDBD;
    color: white;
}

.btnsubmit{
    background-color: rgb(#BDBDBD); 
    color: white;
}

.btnsubmit:hover{
    background-color: #BDBDBD;
}

</style>
</html>