<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ page import="java.util.*,org.itsci.vegetable.dao.*,org.itsci.vegetable.model.*,java.text.SimpleDateFormat" %>
    <% RegisterManager rg = new RegisterManager();
    List<Member> m = rg.getMember();
    
    Member member = (Member) session.getAttribute("showmember");
    
   	ProjectsManager pjm = new ProjectsManager();
	List<Projects> pj = pjm.getProjects(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Mitr&family=Roboto+Condensed:wght@300;400;700&display=swap" >

<title>รายนักศึกษาในโครงการ</title>
<link rel="stylesheet" href="css/listMember.css">
</head>
<body>
<jsp:include page="basic/header.jsp" />
	<form class="fit">
	   <div class="container" align="center">
        <h2 >รายชื่อนักศึกษาโครงการ</h2>
        <p>" โครงการปลูกผักเเลกค่าเทอม "</p>  
   	 <div class="container-fluid" >       
        <table class="table table-bordered" >
        <thead  align="center">
            <tr>
            <th>รหัสนักศึกษา</th>
            <th>ชื่อ-นามสกุล</th>
            <th>สาขา</th>
            <th>ตำแหน่ง</th>
            <th></th>
            </tr>
        </thead>
        <tbody align="center">
        <%for(Member mm : m) {%>
            <tr>
            <td><%= mm.getStudent_code() %></td>
            <td><%= mm.getMember_name() %></td>
            <td><%= mm.getStudent_major() %></td> 
            <td><%= mm.getMember_type()  %></td> 
            <td>
                <a href="goSetPermissions?id=<%= mm.getMember_id() %>" class="btn btn-warning" > ดูรายละเอียด</a>
            </td>
            </tr>	
           <%} session.setAttribute("member", member); %>                             
        </tbody>
        </table>
        </div>
        </div>
	</form>     
<jsp:include page="basic/footer.jsp" />
</body>
<style>
.print{
	 width: 30px;
    height: 30px;
}
.buttom_print{
	width: 160px;
    background-color: #43A047;
    padding: 10px;
    border-radius: 4px;
	text-decoration: none;
	margin-bottom:20px;
	margin-left: 900px;
	transition: box-shadow 280ms cubic-bezier(.4, 0, .2, 1),opacity 15ms linear 30ms,transform 270ms cubic-bezier(0, 0, .2, 1) 0ms;
	align-items: center;
}
a {
    color: #000;
    
}
.buttom_print:hover {
  background-color: white;
  color: black;
  border: 2px solid #4CAF50; /* Green */
  text-decoration: none;
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}
 thead{
   
    background-color:#EEEEEE;
}
</style>
</html>