<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*,org.itsci.vegetable.dao.*,org.itsci.vegetable.model.*,java.text.SimpleDateFormat" %>
<%
    RegisterManager rg = new RegisterManager();
    List<Register> registers = rg.getMemberRequestProject();
   	ProjectsManager pjm = new ProjectsManager();
	List<Projects> pj = pjm.getProjects();
	Register register = (Register) session.getAttribute("showReq");
%>
 
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
    <title>รายนักศึกษาที่ขอเข้าร่วมโครงการ</title>
</head>
<body>
	<jsp:include page="basic/header.jsp" /> 
	<form class="fit"> 
    <div class="container" align="center">
        <h2 >รายชื่อนักศึกษาที่ขอเข้าร่วมโครงการ</h2>
        <h3 style="color:#FFDD00; margin-buttom:50px;" >"โครงการปลูกผักเเลกค่าเทอม"</h3>
    <div class="container-fluid" >       
        <table class="table table-bordered" >
        <thead  align="center">
            <tr>
            <th>ลำดับที่</th>
            <th>รหัสนักศึกษา</th>
            <th>ชื่อ-นามสกุล</th>
            <th>คณะ</th>
            <th>สาขา</th>
            <th></th>
            </tr>
           
        </thead>
        <tbody  align="center">
        <% if(registers.size() > 0) { %>
        <%int num = 1; for(Register r : registers) {%>
            <tr>
            <td><%=num %></td>
            <td><%=r.getMember().getStudent_code() %></td>
            <td><%=r.getMember().getMember_name() %></td>
            
            <%for (int i = 0;i<pj.size();i++){ %>
	            <% if(pj.get(i).getProject_id().equals(r.getMember().getStudent_faculty())){ %>
	            	<td><%=pj.get(i).getName() %></td> 
	            <%}%>
	        <%} %>   
            
            <td><%=r.getMember().getStudent_major() %></td>  
            <td>
                <a href="goapproveReq?id=<%=r.getRegister_id() %>">
                    <button type="button" class="btn btn-warning">ตรวจสอบ</button>
                </a>
            </td>
            </tr> 
           <%num++;} %>
           <%}else{ %>
            <tr>
      			<td colspan="6"><h1 align="center">ไม่มีรายการเเสดง</h1></td>
      		</tr>
           <%} %>
                                        
        </tbody>
        </table>
        </div>  
    </div>
    </form>
    <jsp:include page="basic/footer.jsp" />
</body>
<style>
	@charset "UTF-8";
body{
    font-family: 'Mitr', sans-serif;
    position: relative;
}
*{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Mitr', sans-serif;
 }
 
 thead{
    background-color:#EEEEEE;
}
p{
    font-size: 25px;
}
.fit{
	margin-top: 150px;
	margin-bottom: 50px;
}
</style>
</html>