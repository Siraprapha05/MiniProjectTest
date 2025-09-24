
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="org.itsci.vegetable.model.*,org.itsci.vegetable.dao.*,java.util.*"  %>
    <%
	Logins log = new Logins();
    String err_login = null;
    
	try{
			log = (Logins)session.getAttribute("login");
			err_login = (String) request.getAttribute("result");			
	}catch (Exception e) {	
	}
	String resultRegis = null;
	try{
		resultRegis = (String) request.getAttribute("resultRegis");
	}catch(Exception e){
	
	}
    %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Mitr&family=Roboto+Condensed:wght@300;400;700&display=swap" >
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<meta charset="UTF-8">
<title>เข้าสู่ระบบ</title>
</head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
<script src="js/login.js"></script>
   		<script>  
   				<%if (log != null) {%>
		           	<% if(log.getStatus()==0){ %>
	
				    	 $(document).ready(function(){
					    alert('ท่านยังไม่ได้รับการอนุมัติ');
					  		});  
				    	 <%  session.removeAttribute("login");%>
				   		<%}%>
				 <%}%>
				 <%if( resultRegis != null) {%>
					 $(document).ready(function(){
						  alert('สมัครสมาชิกสำเร็จ รอการอนุมัติ');
					
			  		});  
				 <%}%>
  		</script>
<body>
<jsp:include page="basic/header.jsp"/>
      <div class="container">
      <div class="wrapper">
        <div class="title"><span>เข้าสู่ระบบ</span></div>  
        <form action="isMemberLogin" method="POST">       	
          <div class="row">
            <i class="fas fa-user"></i>
            <input type="email" name="email" id="email" placeholder="Email" required>
          </div>
          <div class="row">
            <i class="fas fa-lock"></i>
            <input type="password" name="pwd" id="pwd" placeholder="Password" required>
          </div>        
          <div class="row button">
            <input type="submit" value="Login">
          </div>
            <%if( err_login != null) {%>
          	<div class="col-md-12">
	            <div class="bg-light rounded p-3">
	            <img src="img/warning.png" class="img-warning">	    		
					<b><p class="mb-0 d-inline-block" style="color:red"><span class="icon-exclamation-circle text-warning"></span>
					 <%=err_login %></p></b>            
	            </div>
	        </div>
	        <%} %>
          <div class="signup-link">คุณยังไม่เป็นสมาชิกใช่หรือไม่? <a href="goRegister">สมัครสมาชิก</a></div>
        </form>
      </div>
    </div>
     
<jsp:include page="basic/footer.jsp"/>
</body>
<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Mitr', sans-serif;
}
body{

  overflow: hidden;
}
.img-warning{
	width: 20px;
	margin-left: -19px;
    margin-right: 4px;
}
.mb-0{
	font-size:14px;
	margin-right: -30px;
}
.bg-light {
    background-color: #fff!important;
    margin-top: -15px;
}
.container{
  max-width: 440px;
  padding: 0 20px;
  margin: 170px auto;
}
.wrapper{
  width: 100%;
  background: #fff;
  border-radius: 5px;
  box-shadow: 0px 4px 10px 1px rgba(0,0,0,0.1);
}
.wrapper .title{
  height: 90px;
  background: #00AE3B;
  border-radius: 5px 5px 0 0;
  color: #fff;
  font-size: 30px;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
}
.wrapper form{
  padding: 30px 25px 25px 25px;
}
.wrapper form .row{
  height: 45px;
  margin-bottom: 15px;
  position: relative;
}
.wrapper form .row input{
  height: 100%;
  width: 100%;
  outline: none;
  padding-left: 60px;
  border-radius: 5px;
  border: 1px solid lightgrey;
  font-size: 16px;
  transition: all 0.3s ease;
}
form .row input:focus{
  border-color: #00AE3B;
  box-shadow: inset 0px 0px 2px 2px rgba(26,188,156,0.25);
}
form .row input::placeholder{
  color: #999;
}
.wrapper form .row i{
  position: absolute;
  width: 47px;
  height: 100%;
  color: #fff;
  font-size: 18px;
  background: #00AE3B;
  border: 1px solid #00AE3B;
  border-radius: 5px 0 0 5px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.wrapper form .pass{
  margin: -8px 0 20px 0;
}
.wrapper form .pass a{
  color:#00AE3B;
  font-size: 17px;
  text-decoration: none;
}
.wrapper form .pass a:hover{
  text-decoration: underline;
}
.wrapper form .button input{
  color: #fff;
  font-size: 20px;
  font-weight: 500;
  padding-left: 0px;
  background: #00AE3B;
  border: 1px solid #00AE3B;
  cursor: pointer;
}
form .button input:hover{
  background: #00892f;
}
.wrapper form .signup-link{
  text-align: center;
  font-size: 17px;
}
.wrapper form .signup-link a{
  color: #DD2C00;
  text-decoration: none;
}
form .signup-link a:hover{
  text-decoration: underline;
}
</style>
</html>