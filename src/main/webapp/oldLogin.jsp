<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="analytic.css">
<link rel="icon" href="src/logo.jpg" type="image/jpg">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Login</title>
</head>
<body id="bid">
<%@ include file="Header.html" %>
<%
/* Declaring Variables for storing values from text box in User Login section*/
String StoreId =((String) request.getParameter("strid"));  
//out.println("StoreId");
String Password =((String) request.getParameter("pswd"));
//out.println("Password");(String)
%>

<form name="login" id="login" method="post">

<div id="div5">
<center>
<table id="table6" >
<tr id="tr6">
<td id="td14"></td>
<td id="td15"></td>
<td id="ALH1"><h2><u>User Login</u></h2></td>
<td id="td16"></td>
<td id="ALH2"><h4>
<%
Date date = new Date();
DateFormat df = new SimpleDateFormat("dd-MM-yyyy ");
df.setTimeZone(TimeZone.getDefault());
out.println(df.format(date)); 
%>
</h4>
</td>
</tr>
</table>
</center>
</div>
<div>
<table id="table7">
<tr id="tr7">
<td id="td17"><label for="usrnm" >Enter UserName</label></td>
<td id="td18"><input id="stridbx" type="text" placeholder="Type Store Id Here" name="strid" autofocus required></td>
</tr>
<tr>
<td id="td19"><label for="pswd">Password</label></td>
<td id="td20"><input id="pswdbx" type="password" name="pswd"  placeholder="Enter Password" required min=></td>
</tr>
<tr id="tr8">
<td id="td21"></td>
<td id="td22"><input type="submit" name="btn" value="SUBMIT" align="middle">
<% 
if(request.getParameter("btn")!=null)
{
try{
	
	String l =((String) request.getParameter("strid")) ;
	session.setAttribute("abc",l); /*setting storeid in l to variable abc for setting the session parameter*/

	//Class.forName("com.ibm.db2.jcc.DB2Driver");
	//create the connection database
	//Connection con = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://52.76.213.43:3306/rs","RS","orbisindia");
	Statement stmt = con.createStatement();
	ResultSet RS = stmt.executeQuery("select Store_Id,Tele from retail_store where Store_Id='"+StoreId+"' and Tele='"+Password+"'");
	if(RS.next()){
		//String Stid =  RS.getString("Store_Id");
		//String Pwd =  RS.getString("Tele");
		//if(StoreId.equals(Stid) && Password.equals(Pwd))
		//{
			%>
			<script>
			window.location.href="Report.jsp";
			</script>
			
		<% 
		//	break;
		//}
		//else{
			//out.println("Not Okay");
		}
		else 
		{
			
		
			
	%>
			<script>
			
			window.location.href="Login.jsp";
		</script>
	<% 
		}
		con.close();	
	
}

	catch(Exception e)
	{
	System.out.println(e);
	
	}

}
%>
</td>
</tr>
</table>
</div>
<div id="div6"> <!--div6 starts here  -->
<table id="table8">
<tr id="tr9">
<td id="td23">
<iframe id="ifrm2"  frameborder="0" name="ck" ></iframe>
</td>
</tr>
</table>
</div> <!--div6 ends here  -->
</form>
<%@ include file="Footer.html" %>
</body>
</html>