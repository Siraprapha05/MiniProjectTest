<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="org.itsci.vegetable.model.*,org.itsci.vegetable.dao.*,java.util.*,java.text.SimpleDateFormat"%>
        <% 
    	String edit_profile = null;
    	try{
    		edit_profile= (String) request.getAttribute("Editresult");
    	}catch(Exception e){
    		
    	}
    %>
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
    	
    	ProjectsManager pjm = new ProjectsManager ();
    	Projects pj = pjm.getprojectName(r.getProjects().getProject_id());
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

<title>แก้ไขข้อมมูลส่วนตัว</title>
</head>
<script type="text/javascript">
	function check(edit){
		//ชื่อ-นามสกุล//
	      var Name = /^([ก-์]{2,50})([\s]{1}([ก-์]{2,50}))?$/;
	      var labelAlert1  = document.getElementById("alertName");
	      labelAlert1.innerText="";
	      if(edit.name.value==("")){
	        labelAlert1.innerText="กรุณากรอกชื่อ";
	        labelAlert1.style.color="#ff5252";
	        return false;
	        }
	      if(edit.name.value.length < 2 || edit.name.value.length > 50){
	    	    labelAlert1.style.color="#ff5252";
	    	    labelAlert1.innerText="ต้องมีความยาวตั้งแต่ 2 - 50 ตัวอักษรเท่านั้น";
	    	    return false;
	    	}
	      if(!edit.name.value.match(Name)){
	          labelAlert1.style.color="#ff5252";
	          labelAlert1.innerText="กรุณากรอกชื่อเป็นภาษาไทยเท่านั้น";
	          edit.name.value = "";
	          return false;
	        }
	      
	   // เบอร์โทรศัพท์ //
	      var Phone = /^(06|08|09)[0-9]{8}$/;
	      var labelAlert2  = document.getElementById("alertPhone");
	      labelAlert2.innerText="";
	      if(edit.phone.value==""){
	          labelAlert2.innerText="กรุณากรอกเบอร์โทรศัพท์";
	          labelAlert2.style.color="#ff5252";
	          return false;
	      }
	      if(!edit.phone.value.match(Phone)){
	          labelAlert2.style.color="#ff5252";
	          labelAlert2.innerText="กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง (ขึ้นต้นด้วย 06, 08, 09 และมี 10 หลัก)";
	          edit.phone.value = "";
	          return false;
	      }

	 }
</script>
<body>
<jsp:include page="basic/header.jsp" />   
<form name="edit" class="fit" method="post" action="submitEdit" >
    <div align="center"  >
        <p>แก้ไขข้อมูลส่วนตัว</p>
   
    <table>  
      <%if( edit_profile != null) {%>
              <div class="col-md-12">
	            <div class="bg-light rounded p-3">	    		
					<p class="mb-0 d-inline-block" style="color:red"><span class="icon-exclamation-circle text-warning"></span><%= edit_profile %></p>            
	            </div> <br> 
          	</div> 
      <%} %>
				<div><b><label style="color:red" id="alertName"></label>
					<label style="color:red" id="alertPhone"></label></b></div>                    
        <tr>
            <td>ชื่อ-นามสกุล<br> 
                <input type="text" name="name" id="name" class="form-control registered" placeholder="ชื่อ-นามสกกุล"  value="<%= mb.getMember_name() %>">
            </td>
            <td>รหัสนักศึกษา<br>
                <input type="text" name="stucode" id="stucode" class="form-control registered" placeholder="รหัสนักศึกษา" value="<%= mb.getStudent_code() %>"readonly>	
            </td>
        </tr>
        <tr>
            <td>เบอร์โทรศัพท์<br>
      			<input type="text" name="phone" id="phone" placeholder="เบอร์โทรศัพท์" maxlength="10" value="<%= mb.getMember_phone() %>" class="form-control registered" >
            	
            </td>
            <td>สาขา<br>
                    <input type="text" name="major" id="major" class="form-control registered" value="<%= mb.getStudent_major() %>"  placeholder="สาขา" readonly>  
            </td>
        </tr>
     
        <tr>
            <td>วันเกิด<br>
               <input type="text" name="birthday" id="birthday" class="form-control registered" placeholder="วันเกิด" value="<%= sdf.format(mb.getMember_birthday().getTime()) %>" readonly>
           <label></label>
            </td>
            <td>สังกัดคณะ/โครงการ<br>
                <input type="text" name="faculty" id="faculty" class="form-control registered" placeholder="สังกัดคณะ/โครงการ" value="<%= pj.getName() %>" readonly >
            <label></label>
            </td>
        </tr>
         <tr>
                <td align="right"><input type="submit" name="submit" value="บันทึก" class="btn btn-success" Onclick="return check(edit)"></td>
                <td><input type="reset" name="reset" value="ยกเลิก" class="btn btn-danger" ></td>
            </tr>
    </table>    
       <input type="hidden" name="member_id" value="<%= mb.getMember_id() %>">
       <input type="hidden" name="prefix" value="<%= mb.getMember_prefix() %>">
       <input type="hidden" name="officer_position" value="<%= mb.getOfficer_position() %>"> 		
	   <input type="hidden" name="member_type" value="<%= mb.getMember_type() %>"> 
      
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
}
p{
    font-size: 30px;
    color:#353b48; 
}
label{
font-size: 16px;
}

.fit {
    background-color: #f5f4f4;
    border-radius: 2px;
    margin-left: 480px;
    margin-right: 457px;
    margin-top: 130px;
    margin-bottom: 150px;
    padding: 64px;
    padding-top: 44px;
    display: flex;
    justify-items: center;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.registered{
    width:215px;
    margin: 8px;
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
.bg-light {
    background-color: #F2F2F2!important;
}
</style>
</html>