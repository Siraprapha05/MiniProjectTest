
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="org.itsci.vegetable.model.*,org.itsci.vegetable.dao.*,java.util.*,java.text.SimpleDateFormat"  %>
    <%	Calendar cd = Calendar.getInstance();
	 	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdtf = new SimpleDateFormat("HH:mm");
	    sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	    sdtf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	    String  dateshift =  sdf.format(cd.getTime()); 
	    String  timeshift =  sdtf.format(cd.getTime());  
	  %>  
	   <% 
	   
	   
	 	RegisterManager rgm = new RegisterManager();
	   	Member mb = (Member)session.getAttribute("member"); 
		Register rg = rgm.getRegisterID(mb.getMember_id());
		
		String resultAddshift = null;
    	try{
    		resultAddshift = (String) request.getAttribute("resultAddshift");
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
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Mitr&family=Roboto+Condensed:wght@300;400;700&display=swap" >
    <title>บันทึกเวลาการทำงาน</title>
    <link rel="stylesheet" href="css/addshift.css">
     <script type="text/javascript">
  function check(addshift){
    var task_name = /^([ก-์]{2,50})([\s]{1,2})([ก-์]{2,50})$/;
    var labelAlert1  = document.getElementById("alertTask_name");
    labelAlert1.innerText="";
    if(addshift.task_name.value==("")){
      labelAlert1.innerText="กรุณากรอกการรับหน้าที่";
      labelAlert1.style.color="#ff5252";
      return false;
      }
    if(!addshift.task_name.value.match(Name)){
        labelAlert1.style.color="#ff5252";
        labelAlert1.innerText="กรุณากรอกการรับหน้าที่เป็นภาษาไทยเท่านั้น";
        addshift.task_name.value = "";
        return false;
      }
    var toTime= new Time;
	    end_time.setHours(0,0,0,0);
	    alertend_time= document.getElementById("alertEnddate");
	    alertend_time.innerText="";
    var end_time = new Date(addshift.endTime.value)
    if(addshift.endTime.value==""){
    	alertend_time.innerText="กรุณากรอกเวลาออกงาน";
    	alertend_time.style.color="#ff5252";
      return false;
    }
   if(end_date < toTime) {
		alertend_time.innerText="ต้องไม่ใช่เวลาปัจจุบันหรืออดีต";
		addshift.endTime.value= ""
	    alertend_time.style.color="#ff5252";
      return false;
    }
    }
    </script>
</head>
<body>
<jsp:include page="basic/header.jsp"/>
    <form class="fit" name="addshift" action="insertAddshift" method="POST" >
        <div align="center">
        			<h3 class="ptext">บันทึกเวลาการทำงาน</h3>
            <table>
                   <%if( resultAddshift != null) {%>
		              <div class="col-md-12">
			            <div class="bg-light rounded p-3">	    		
							<p class="mb-0 d-inline-block" style="color:red"><span class="icon-exclamation-circle text-warning"></span> <%= resultAddshift %></p>            
			            </div> <br> 
		          	</div> 
              	   <%} %>
              	   <div><b><label class="alert-label" id="alertEnddate"></label>
              	   <label class="alert-label" id="alertTask_name"></label></b></div>  
	            <tr>
	                <td> รหัสนักศึกษา <br>
	                    <input type="text" value="<%=mb.getStudent_code() %>"  name="stucode" id="stucode" class="form-control addShift" placeholder="รหัสนักศึกษา"readonly>
	                </td>
	                <td>ชื่อ-นามสกุล <br>
	                    <input type="text" value="<%=mb.getMember_name() %>" name="name" id="name" class="form-control addShift" placeholder="ชื่อ-นามสกุล"readonly>
	                </td>
	            </tr>
            <tr>
                <td>วันที่ทำงาน <br>
                    <input type="date" value="<%= dateshift %>" name="date" id="date" class="form-control addShift">
                	
                </td>
                <td>รับหน้าที่ <br>
                    <input type="text" name="task_name" id="task_name" class="form-control addShift" placeholder="รับหน้าที่">  
                </td>
            </tr>
            <tr>
                <td>เวลาเข้างาน <br>
                    <input type="time" value="<%= timeshift %>" name="startTime" id="startTime" class="form-control addShift"  required >
                </td>
                <td>เวลาออกงาน <br>
                    <input type="time" name="endTime" id="endTime"  class="form-control addShift" required>
                </td>
            </tr>
            <tr>
                <td align="right"><input type="submit" name="submit" value="บันทึก" class="btn btn-success" Onclick="return check(addshift)"></td>
                <td><input type="reset" name="reset" value="ยกเลิก" class="btn btn-danger" ></td>
            </tr>
            <tr>
            	<td>
            		<input type="hidden" name="register_id" id="register_id" value="<%= rg.getRegister_id()%>">
            	</td>
            </tr>
            </table>
        </div>
    </form>
    <jsp:include page="basic/footer.jsp" />
    </body>
    <style>
    @charset "UTF-8";
body{
    font-family: 'Mitr', sans-serif;
    
}
*{
   margin: 0;
   padding: 0;
   box-sizing: border-box;
   font-family: 'Mitr', sans-serif;
}
.img1{
    width: 120px;
    height: 120px; 
}
.alert-label{
    font-size: 18px;
}
.ptext{
	font-size: 26px;
}
.addShift{
    width:215px;
    margin: 5px;
}
.fit {
	background-color: #f5f4f4;
    border-radius: 8px;
    margin-left: 486px;
    margin-right: 479px;
    margin-bottom: 100px;
    margin-top: 180px;
    padding: 54px;
    padding-top: 46px;
    display: flex;
    justify-items: center;
    box-shadow: 0 4px 8px 0 rgb(0 0 0 / 20%), 0 6px 20px 0 rgb(0 0 0 / 19%);
}
table{
margin-top: 1px;
}
</style>
</html>