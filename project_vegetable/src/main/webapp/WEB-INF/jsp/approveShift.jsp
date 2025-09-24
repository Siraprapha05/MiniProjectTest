<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="org.itsci.vegetable.model.*,org.itsci.vegetable.dao.*,java.util.*,java.text.SimpleDateFormat"  %>
   <%	Calendar cd = Calendar.getInstance();
	 	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdtf = new SimpleDateFormat("HH:mm");
	    sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	    String  dateshift =  sdf.format(cd.getTime()); 
	    String  timeshift =  sdtf.format(cd.getTime());  
	    
	    RegisterManager rg = new RegisterManager();
	    MembershiftManager ms = new MembershiftManager();    
	    
	    Member m = (Member) session.getAttribute("ShowMember");
	    Member mb = rg.getMember_shift(m.getStudent_code());
		Register r = rg.getRegisterID(mb.getMember_id());
	   	Member_shifts mbs = ms.getMShifts_byRegis(r.getRegister_id());
		
	   	String resultApproveshift = null;
    	try{
    		resultApproveshift = (String) request.getAttribute("resultApproveshift");
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
    <title>ตรวจสอบเวลาการทำงาน</title>
</head>
     <!--  script type="text/javascript">
  function check(addshift){
    var task_name = /^([ก-์]{2,50})$/;
    var labelAlert1  = document.getElementById("alertTask_name");
   
    if(!addshift.task_name.value.match(task_name)){
        labelAlert1.style.color="#ff5252";
        labelAlert1.innerText="*กรุณากรอกการรับหน้าที่เป็นภาษาไทยเท่านั้น";
        return false;
      }
    var toTime= new Time;
	    end_time.setHours(0,0,0,0);
	    alertend_time= document.getElementById("alertEnddate");
    var end_time = new Date(addshift.endTime.value)

   if(end_date < toTime) {
		alertend_time.innerText="*ต้องไม่ใช่เวลาปัจจุบันหรืออดีต";
	    alertend_time.style.color="#ff5252";
      return false;
    }
    }
    </script>-->
<body>

<jsp:include page="basic/header.jsp"/>
    <form  name="addshift" action="updateApproveshift" method="POST" >
    <div class="fit"  align="center">
    <table>
       <%if( resultApproveshift != null) {%>
			<div>	
				<p class="mb-0 d-inline-block" style="color:red"><%= resultApproveshift %></p>            
			</div>	
       <%} %>
	        <div>
	            <b><label class="alert-label" id="alertEnddate"></label>
	              <label class="alert-label" id="alertTask_name"></label></b>
	        </div>  
			<input type="hidden" value="<%= mbs.getMember_shift_id() %>"  name="member_shift_id" id="member_shift_id" >
	        <tr align="center">
	        	<td colspan="2"><h4>ตรวจสอบการทำงาน</h4></td>
	        	<td></td>
	        </tr>
	        <tr>
	            <td> รหัสนักศึกษา 
	                <input type="text" value="<%= m.getStudent_code() %>"  name="stucode" id="stucode" class="form-control addShift" placeholder="รหัสนักศึกษา"readonly>
	            </td>
	            <td>ชื่อ-นามสกุล
	                <input type="text" value="<%= m.getMember_name() %>" name="name" id="name" class="form-control addShift" placeholder="ชื่อ-นามสกุล"readonly>
	            </td>
	        </tr>
            <tr>
                <td>วันที่ทำงาน
                    <input type="text" value="<%= sdf.format(mbs.getDate().getTime())%>" name="date" id="date" class="form-control addShift"readonly>
                </td>
                <td>รับหน้าที่
                    <input type="text" value="<%= mbs.getTask_name() %>" class="form-control addShift" placeholder="รับหน้าที่" readonly>
                </td>
            </tr>
            <tr>
                <td>เวลาเข้างาน
                    <input type="time" value="<%= sdtf.format(mbs.getStartTime().getTime()) %>" name="startTime" id="startTime" class="form-control addShift"readonly>
                </td>
                <td>เวลาเข้าออกงาน
                    <input type="time" value="<%= sdtf.format(mbs.getEndTime().getTime()) %>" class="form-control addShift"readonly>
                </td>
            </tr>
            <tr>
            	<td><h5>แก้ไขรายละเอียด</h5></td>	
            </tr>
            <tr>
            	<td>รับหน้าที่
            		  <input type="text" value="<%= mbs.getTask_name() %>" name="task_name" id="task_name" class="form-control addShift" placeholder="รับหน้าที่" >
            	</td>
            	 <td>เวลาเข้าออกงาน
                    <input type="time" value="<%= sdtf.format(mbs.getEndTime().getTime()) %>" name="endTime" id="endTime" class="form-control addShift">
                </td>
            </tr>
            
            <tr>
                <td align="right"><input type="submit" name="submit" value="อนุมัติ" class="btn btn-success"  Onclick="return check(addshift)"></td>
                <td><a href="updateApproveCancelshift?msid=<%= mbs.getMember_shift_id()%>&&tn=<%= mbs.getTask_name() %>&&eT=<%= sdtf.format(mbs.getEndTime().getTime()) %>"><input type="button" name="submit" value="ไม่อนุมัติ" class="btn btn-danger" ></a></td>
            </tr>
            
            </table>
       </div>
    </form>
    <jsp:include page="basic/footer.jsp" />
</body>
<style>
body{
    font-family: 'Mitr', sans-serif; 
}
*{
   margin: 0;
   padding: 0;
   box-sizing: border-box;
   font-family: 'Mitr', sans-serif;
   z-index:2;
}
.fit {
	background-color: #ECECEC;
    border-radius: 10px;
    margin-left: 499px;
    margin-right: 464px;
    padding: 54px;
    padding-top: 46px; 
    margin-bottom: 60px;
    margin-top: 150px;
    display: flex;
    justify-items: center;
}

table{
	margin-top: 1px;
	
}
.addShift{
    width:215px;
    margin: 5px;
}
.select{
    padding:5px ;
    width: 250px;
    border-radius: 5px;
    margin-left:10px;
}
textarea{
    height: 150px !important;
}

a.button {
    -webkit-appearance: button;
    -moz-appearance: button;
   	 appearance: button;
    text-decoration: none;
    color: initial;
}
button{
    height: 40px;
    width: 200px;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 10px;
    margin-bottom: 5px; 
}

</style>
</html>