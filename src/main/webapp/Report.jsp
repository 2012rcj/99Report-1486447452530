<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="javax.servlet.*"%>  
<%@page import="javax.servlet.http.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
<style>
ul {
  list-style: none;
  padding: 0;
  margin: 0;
 }
ul li {
  display: block;
  position: relative;
  float: left;
  background: #1bc2a2; /* This color is for main menu item list */
}

#report li {background: #E91E63;
}
li ul { display: none; }
ul li a {
  display: block;
   padding: 5px;
  text-decoration: none;
  white-space: nowrap;
  color: #fff;
}
ul li a:hover { background: #2c3e50; }
li:hover > ul {
  display: block;
  position: absolute;
}
li:hover li { float: none; }
li:hover li a:hover { background: orange; }
.main-navigation li ul li { border-top: 0; }
ul ul ul {
  left: 100%;
  top: 0;
}
ul:before,
ul:after {
  content: " "; /* 1 */
  display: table; /* 2 */
}
ul:after { clear: both; }

</style>

<script type="text/javascript">

function Pager(tableName, itemsPerPage) {

this.tableName = tableName;

this.itemsPerPage = itemsPerPage;

this.currentPage = 1;
http://localhost:8080/99ARDashDB/Report2.jsp?Value1=1472207051&Value2=Pano%20Pharmacy#
this.pages = 0;

this.inited = false;

this.showRecords = function(from, to) {

var rows = document.getElementById(tableName).rows;

// i starts from 1 to skip table header row

for (var i = 1; i < rows.length; i++) {

if (i < from || i > to)

rows[i].style.display = 'none';

else

rows[i].style.display = '';

}

}

this.showPage = function(pageNumber) {

if (! this.inited) {

alert("not inited");

return;

}

var oldPageAnchor = document.getElementById('pg'+this.currentPage);

oldPageAnchor.className = 'pg-normal';

this.currentPage = pageNumber;

var newPageAnchor = document.getElementById('pg'+this.currentPage);

newPageAnchor.className = 'pg-selected';

var from = (pageNumber - 1) * itemsPerPage + 1;

var to = from + itemsPerPage - 1;

this.showRecords(from, to);

}

this.prev = function() {

if (this.currentPage > 1)

this.showPage(this.currentPage - 1);

}

this.next = function() {

if (this.currentPage < this.pages) {

this.showPage(this.currentPage + 1);

}

}

this.init = function() {

var rows = document.getElementById(tableName).rows;

var records = (rows.length - 1);

this.pages = Math.ceil(records / itemsPerPage);

this.inited = true;

}

this.showPageNav = function(pagerName, positionId) {

if (! this.inited) {

alert("not inited");

return;

}

var element = document.getElementById(positionId);

var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal">PREV </span> ';

for (var page = 1; page <= this.pages; page++)

pagerHtml += '<style id="pg' + page + '" class="pg-normal;"></style> ';

pagerHtml += '<span onclick="'+pagerName+'.next();" class="pg-normal"> NEXT</span>';

element.innerHTML = pagerHtml;

}

}
</script>
<script type="text/javascript" src="JS/DisableBack.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manufacturer Report</title>
<%response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
</head>
<link rel="stylesheet" type="text/css" href="analytic.css">
<link rel="icon" href="src/logo.jpg" type="image/jpg">
</head>
<body>
<form>
<%@ include file="Header.html" %>
<%
String s = (String) request.getParameter("Value1");
request.getSession().setAttribute("abc",s);
String strnm = (String) request.getParameter("Value2");
session.setAttribute("efg",strnm);
String V_Strnm = (String)session.getAttribute("efg");
//request.getSession().setAttribute("efg",n);
//request.getSession().getAttribute("efg");
//String Strnm = (String)session.getAttribute("efg");
String EStid=(String)session.getAttribute("abc");
%>
<table align="right">
		<tr>
		<td>
		<button><a href="Login.jsp" style="text-decoration:none" >Logout</a></button>
		</td>
	   </tr>
		</table>

<table style="width:100%" >
		<tr>
<ul class="main-navigation"><li><a href="#">Manufacturers Reports</a>
<ul>
<li><a href="storevaluelist.jsp">Home</a></li>
<!-- <li><a href="#">Sales Report</a>
<ul id="report">
<li><a href="SalesReportYearly.jsp">Year Wise</a></li>
<li><a href="salesreportmonthly.jsp">Month Wise</a></li>
<li><a href="salesreportdaily.jsp">Day Wise</a></li>
<li><a href="customsalesreport1.jsp">Custom Report</a></li>
<li><a href="Billwisetotalsale.jsp">Bill Wise Total Sale</a>
</ul>
</li> -->
<li><a href="#">Hemas Sales Report</a>
<ul id="report">
<!-- <li><a href="hemassalesyearly.jsp">Year Wise</a></li>
<li><a href="hemassalesmonthly.jsp">Month Wise</a></li> -->
<li><a href="hemassalesdaily.jsp">Day Wise Product</a></li>
<!-- <li><a href="HemasProduct.jsp">Product Wise</a> -->
<!-- <li><a href="hsrcustom1.jsp">Custom Report</a></li> -->
</ul>
</li>
<li><a href="#">Market Share (Hemas)</a>
<ul id="report">
 <li><a href="Marketshare.jsp">Daily</a></li> 
<li><a href="hemasMonthShare.jsp">Monthly</a></li>
<li><a href="HemasyearShare.jsp">Yearly</a></li>
<!-- <li><a href="hsrcustom1.jsp">Custom Report</a></li> -->
</ul>
</li>
</ul>
</li>
</ul>
 <div style="text-align: center">
<div style="color: Indigo;"><h2><u><b>Welcome Hemas</u></b></h2></div>
<div style="color: Indigo;"><h3><u><b><% out.println(V_Strnm); %></u></b></h3></div>
</div>

		</table>
<div id="div7">
<table id="table9">
<tr id="tr10">
<td id="td24"><div>

<td id="td25">

</td>
<td  width="20%"></td>
<td  width="20%"></td>
<td  width="20%"><h4>
<%--
Date date = new Date();
DateFormat df = new SimpleDateFormat("dd-MM-yyyy ");
df.setTimeZone(TimeZone.getDefault());
out.println(df.format(date)); 
--%>
</h4></td>
</tr>
</table>
</div>

<div id="div4"> <!--div4 starts here  -->
<table id="table4">
<tr id="tr4">
<td id="td12">
<iframe id="ifrm3"  frameborder="0" name="ck" >

</iframe>
</td>
</tr>
</table>
</div> <!--div4 ends here  -->
<% 



%>
<%--
<%@ include file="Footer.html" %>
 --%>
</form>
</body>
</html>