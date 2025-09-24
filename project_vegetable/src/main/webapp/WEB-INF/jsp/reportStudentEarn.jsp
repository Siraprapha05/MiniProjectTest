<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="java.util.*,org.itsci.vegetable.dao.*,org.itsci.vegetable.model.*,java.text.*" %>
	    <%
		    ReportManager rpm = new ReportManager(); 
		    List<Member_shifts> listwork = (List<Member_shifts>) request.getAttribute("listwork");
		    String sid = (String) request.getAttribute("stuCode");
		   //List<Member_shifts> work_id = rpm.getWorkStatisticsByID(sid);
		    TransactionManager tm = new TransactionManager(); 
			List<Transaction_details> ts = (List<Transaction_details>) request.getAttribute("list_details");
		    List<String> ty = rpm.options_term_year();
		    String term_year = (String) request.getAttribute("term_year");
		    System.out.println(term_year);
		    
		    String[] last_ty = ty.get(ty.size()-1).split("-");
		    String last_term = last_ty[0];
		    
		    
		    String last_year = last_ty[1];
		    
		    Member_shifts statistic  = (Member_shifts) request.getAttribute("statistic");
		    
		    MemberManager mbm = new MemberManager();
			Logins log = (Logins)session.getAttribute("login");
			Member mb = mbm.getMember(log.getMember().getMember_id());	
		    
			double expenses=0.0;
			double income=0.0;
			double summary=0.0;
 	    	
		    if(ts == null){
		    	ts = rpm.report_student_earn_by_search(Integer.parseInt(last_term), Integer.parseInt(last_year));
		    	listwork = rpm.search_WorkStatistics(Integer.parseInt(last_term), Integer.parseInt(last_year));
		    	term_year = last_term+"-"+last_year;
		    	
		    	statistic =  rpm.getStatistics(mb.getStudent_code(),Integer.parseInt(last_term), Integer.parseInt(last_year));	
		    }else{
		    	for(int i = 0; i < ts.size(); i++) {
            	   if(ts.get(i).getType().equals("สินค้า")){
            		   income += ts.get(i).getTransaction().getTotal_price();
            	   }else{
            		   expenses += ts.get(i).getTransaction().getTotal_price();
            	   }
		    	}
		    	summary = income-ts.get(0).getAssets().getProjects().getCost_amount()-expenses;
		    }
   
	    %>
	    <%
	    SimpleDateFormat sdfy = new SimpleDateFormat("yyyy");
	 	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sdtf = new SimpleDateFormat("HH:mm");
		SimpleDateFormat hour = new SimpleDateFormat("H");
		SimpleDateFormat min = new SimpleDateFormat("m");
	    sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));

	    DecimalFormat df = new DecimalFormat("###,###,###.00");
	    DecimalFormat df2 = new DecimalFormat("###,###,###.000");
	  %> 
	  <% 
		String member_type = null;
		try{
				log = (Logins)session.getAttribute("login");
				mb = mbm.getMember(log.getMember().getMember_id());		
		}catch (Exception e) {	
		}
		
		session.setAttribute("login", log);

 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Mitr&family=Roboto+Condensed:wght@300;400;700&display=swap" >
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>
  
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- css.gg -->
<link href='https://css.gg/css' rel='stylesheet'>

<!-- UNPKG -->
<link href='https://unpkg.com/css.gg/icons/all.css' rel='stylesheet'>

<!-- JSDelivr -->
<link href='https://cdn.jsdelivr.net/npm/css.gg/icons/all.css' rel='stylesheet'>
    <title>รายงานรายได้นักศึกษา</title>
</head>
<body>
<jsp:include page="basic/header.jsp" /> 
    <div class="container" align="center">
	      <h2>รายงานรายได้นักศึกษา</h2>
	      <h3 style="color:#FFDD00;">" โครงการปลูกผักเเลกค่าเทอม "</h3>  
      <form action="search_report_student_earn"  method="POST">
		  <table>	
		      <tr>
		       <%if(log.getStatus()==1||log.getStatus()==2){ %>
		      <td>
		      	 <div class="fitB">
		      		<label class="tr2">ชั่วโมงการทำงานตัวเอง : </label> <br>
		      		<label><%= hour.format(statistic.getEndTime().getTime())+"ชั่วโมง "+min.format(statistic.getEndTime().getTime())+"นาที" %></label>
		         </div>
		      </td>
		      <%} %>  
		      <td><label class="tr2">เทอมปีการศึกษา :</label> 
		          <div class="form-floating">
		              <select name="term_year" class="custom-select" style="width:200px;">
			                <% for(String i : ty){ %>
			                	<% if(term_year.equals(i)){ %>
			                     	<option value="<%= i %>" selected><%= i %></option>
			                     <% }else{ %>
			                     	<option value="<%= i %>"><%= i %></option>
			                     <% } %>
			                <% } %>
		              </select>                 
		          </div> 
		      </td> 
		           <td><button type="submit" class="form-control  button-search" role="button" >ค้นหา 
		               &nbsp;<i class="gg-search"></i>
		               </button>
		           </td>
		      <%if(log.getStatus()==3){ %>
		           <td><a href="reportSummary">
		        	   <button type="submit" class="form-control  button-print" role="button" onclick="PrintTable()">รายงานรายได้ของนักศึกษา
		                    &nbsp;<img class="img_print" src="img/print.png">
		               </button>
		               </a>
		           </td>
		      <%} %>
		        </tr>
		    </table>
   		</form>
   		<div id="dvContents" >
        <table class="table table-bordered" id="dvContents" border="1">
            <thead>
              <tr>
                <th>ลำดับ</th>
                <th>รหัสนักศึกษา</th>
                <th>ชื่อ-นามสกุล</th>
                <th>สาขา</th>
                <th>ชั่วโมงการทำงาน</th>
                <%if(log.getStatus()==3){ %>
                <th>ค่าตอบเเทน (ต่อ ชม.)</th>
                <%} %>
              </tr>
            </thead>
            <tbody>
             <% 
             	double total = 0;
             	int all_hour = 0;
             	int all_minute = 0;
             	double all_income = 0;
             	double all_expense = 0;
             	
             	int sum_hour = 0;
             	int sum_minute = 0;
             	
             	double sum_Compensation=0;
             %>
             <% for(int i = 0; i < listwork.size(); i++){ %>
	          	<% 
	          		all_hour += Integer.parseInt(hour.format(listwork.get(i).getEndTime().getTime())); 
	          		all_minute += Integer.parseInt(min.format(listwork.get(i).getEndTime().getTime()));
	          	%>
             <% } %>
             <% for(int i = 0; i < ts.size(); i++){ %>
             	<% 
	             	if(ts.get(i).getType().equals("สินค้า")){
	             		all_income += (ts.get(i).getTransaction().getTotal_price());
	            	}else{
	            		all_expense += (ts.get(i).getTransaction().getTotal_price());
	            	}
             	%>
             <% } %>
             <% 
             	all_hour = all_hour + (all_minute/60);
             	total = all_income/all_hour;
             %>
             <%int num = 1; for(int i = 0; i < listwork.size(); i++){ %>
              <tr <% if(listwork.get(i).getRegister().getMember().getStudent_code().equals(mb.getStudent_code()) ) { %> style="background-color:#FFCDD2" <% } %>>
                <td><%= num %></td>
                <td><%= listwork.get(i).getRegister().getMember().getStudent_code() %></td>
                <td><%= listwork.get(i).getRegister().getMember().getMember_name() %></td>
                <td><%= listwork.get(i).getRegister().getMember().getStudent_major() %></td>
                <td><%= hour.format(listwork.get(i).getEndTime().getTime())+"ชั่วโมง "+min.format(listwork.get(i).getEndTime().getTime())+"นาที" %></td>
              	 <% 
	              	all_hour = 0;
	              	all_minute = 0;
	              	for(int j = 0; j < listwork.size(); j++){ %>
			          	<% if(listwork.get(i).getRegister().getMember().getMember_name().equals(listwork.get(j).getRegister().getMember().getMember_name())){
			          		all_hour += Integer.parseInt(hour.format(listwork.get(j).getEndTime().getTime())); 
			          		all_minute += Integer.parseInt(min.format(listwork.get(j).getEndTime().getTime()));
			          	} %>
	             <% } all_hour += (all_minute/60); 
	             sum_hour += all_hour;
	             sum_minute += all_minute ;
	             %>
             	<%if(log.getStatus()==3){ %>
             		<% if(summary > 0){ 
             			sum_Compensation += (total*all_hour); %>
              			<td><%= df.format(total*all_hour) + " (" + df2.format(total) + ")" %></td>
              		<% }else{ %>
              		    <td><label style="color: red;"><%= "ยังไม่สามารถนำจ่ายได้"  %></label></td>
              		<% } %>
              	<%} %>
              	
              </tr>
            <% num++;} %>
    		<tr>
    			
    			<td colspan="4" align="right" style="background-color: #BDBDBD;" >รวมทั้งหมด</td>
    			<td><%= sum_hour+ (sum_minute/60) %> ชั่วโมง <%= sum_minute%60 %> นาที</td>
    			<%if(log.getStatus()==3){ %>
    			<% if(summary > 0){ %>	 
              			<td><%= df.format(sum_Compensation) %></td>
              	<% }else{ %>
              		    <td><label style="color: red;"><%= "ยังไม่สามารถสรุปยอดรวมได้"  %></label></td>
              	<% } }%>
    		</tr>
            </tbody>
          </table>
          </div>
     
    </div>
    <jsp:include page="basic/footer.jsp" />
</body>
<script type="text/javascript">
    function PrintTable() {
    	/*
    	var divToPrint=document.getElementById("dvContents");
        newWin= window.open("");
        newWin.document.write(divToPrint.outerHTML);
        newWin.print();
        newWin.close();
    	*/
        var printWindow = window.open('', '','height=700,width=1200');
        printWindow.document.write('<html><head><title>.</title></head>');
 
        
        //Print the DIV contents i.e. the HTML Table.
        printWindow.document.write('<body> <div align="center"> <h3>รายงานรายได้นักศึกษา</h3> <h4> โครงการปลูกผักเเลกค่าเทอม </h4>  ');
        var divContents = document.getElementById("dvContents").innerHTML;
        
        printWindow.document.write(divContents);
        printWindow.document.write('</div> </body>');
 
        printWindow.document.write('</html>');
        printWindow.document.close();
        printWindow.print();
        
    }
    
</script>

<style  id="table_style" >
body{
    font-family: 'Mitr', sans-serif;  
}
*{
   margin: 0;
   padding: 0;
   box-sizing: border-box;
   font-family: 'Mitr', sans-serif;
   z-index: 2;
}
td{
  align-items: center;
  margin-top: 29px;
  padding: 10px;
}
table{
    margin-top: 30px;
        
}
thead{
  background-color:#EEEEEE;
}
.form-control{
  width: 200px;
}
.container{
  margin-top: 150px;
  margin-bottom: 150px;
}
.fitB{
  background-color:#FFCDD2;
  border-radius: 10px;
  align-items: center;
  height: 90px;
  padding: 15px;
}

    /*button search*/
.button-search{
  align-items: center;
  appearance: none;
  background-color: #BDBDBD;
  border-radius: 10px;
  border-style: none;
  box-shadow: rgba(0, 0, 0, .2) 0 3px 5px -1px,rgba(0, 0, 0, .14) 0 6px 10px 0,rgba(0, 0, 0, .12) 0 1px 18px 0;
  box-sizing: border-box;
  color: #000;
  cursor: pointer;
  display: inline-flex;
  fill: currentcolor;
  font-size: 14px;
  font-weight: 500;
  height: 34px;
  justify-content: center;
  letter-spacing: .25px;
  line-height: normal;
  max-width: 100%;
  overflow: visible;
  padding: 2px 24px;
  position: relative;
  text-align: center;
  text-transform: none;
  transition: box-shadow 280ms cubic-bezier(.4, 0, .2, 1),opacity 15ms linear 30ms,transform 270ms cubic-bezier(0, 0, .2, 1) 0ms;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: auto;
  will-change: transform,opacity;
  z-index: 0;
  margin-top:31px;
}

.button-search:hover {
  background: #F6F9FE;
  color: #174ea6;
}

.button-search:active {
  box-shadow: 0 4px 4px 0 rgb(60 64 67 / 30%), 0 8px 12px 6px rgb(60 64 67 / 15%);
  outline: none;
}

.button-search:focus {
  outline: none;
  border: 2px solid #4285f4;
}

.button-search:not(:disabled) {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-search:not(:disabled):hover {
  box-shadow: rgba(60, 64, 67, .3) 0 2px 3px 0, rgba(60, 64, 67, .15) 0 6px 10px 4px;
}

.button-search:not(:disabled):focus {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-search:not(:disabled):active {
  box-shadow: rgba(60, 64, 67, .3) 0 4px 4px 0, rgba(60, 64, 67, .15) 0 8px 12px 6px;
}

.button-search:disabled {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}
  /*button print*/
.button-print{
  align-items: center;
  appearance: none;
  background-color: #FFE082;
  border-radius: 10px;
  border-style: none;
  box-shadow: rgba(0, 0, 0, .2) 0 3px 5px -1px,rgba(0, 0, 0, .14) 0 6px 10px 0,rgba(0, 0, 0, .12) 0 1px 18px 0;
  box-sizing: border-box;
  color: #000;
  cursor: pointer;
  display: inline-flex;
  fill: currentcolor;
  font-size: 14px;
  font-weight: 500;
  height: 34px;
  justify-content: center;
  letter-spacing: .25px;
  line-height: normal;
  max-width: 100%;
  overflow: visible;
  padding: 2px 24px;
  position: relative;
  text-align: center;
  text-transform: none;
  transition: box-shadow 280ms cubic-bezier(.4, 0, .2, 1),opacity 15ms linear 30ms,transform 270ms cubic-bezier(0, 0, .2, 1) 0ms;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: auto;
  will-change: transform,opacity;
  z-index: 0;
  margin-top:31px;
}

.button-print:focus {
  outline: none;
  border: 2px solid #4285f4;
}

.button-print:not(:disabled) {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-print:not(:disabled):hover {
  box-shadow: rgba(60, 64, 67, .3) 0 2px 3px 0, rgba(60, 64, 67, .15) 0 6px 10px 4px;
}

.button-print:not(:disabled):focus {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-print:not(:disabled):active {
  box-shadow: rgba(60, 64, 67, .3) 0 4px 4px 0, rgba(60, 64, 67, .15) 0 8px 12px 6px;
}

.button-print:disabled {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}
.img_print{
	width:25px;

}
</style>
</html>