<%@ page language="java" import="java.sql.*" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import=" com.sendgrid.*" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.lang.Object" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import=" java.io.FileOutputStream" %>
<%@ page import=" java.io.BufferedReader" %>
<%@ page import=" java.io.DataOutputStream" %>
<%@ page import=" java.io.InputStreamReader" %>
<%@ page import=" java.net.HttpURLConnection" %>
<%@ page import="  java.net.URL" %>
<%@ page import="  java.io.File" %>
<%@ page import="  com.itextpdf.text.Font" %>
<%@ page import=" com.itextpdf.text.Font.FontFamily" %>
<%@ page import="com.itextpdf.text.BaseColor" %>
<%@ page import=" com.itextpdf.text.Document" %>
<%@ page import="com.itextpdf.text.Element" %>
<%@ page import=" com.itextpdf.text.PageSize" %>
<%@ page import=" com.itextpdf.text.Paragraph" %>
<%@ page import=" com.itextpdf.text.Phrase" %>
<%@ page import=" com.itextpdf.text.pdf.PdfPCell" %>
<%@ page import=" com.itextpdf.text.pdf.PdfPTable" %>
<%@ page import=" com.itextpdf.text.pdf.PdfWriter" %>
<%@ page import=" java.io.IOException" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.itextpdf.text.Image"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
tr:nth-child(even) {background: #C5CAE9}
tr:nth-child(odd) {background: #00BCD4}
.pg-normal { 
color: #000000; 
font-size: 15px; 
cursor: pointer; 
background: #FF6600; 
padding: 2px 4px 2px 4px; 
}

.pg-selected { 
color: #fff; 
font-size: 15px; 
background: #FF6600; 
padding: 2px 4px 2px 4px; 
</style>
<script type="text/javascript">

function Pager(tableName, itemsPerPage) {

this.tableName = tableName;

this.itemsPerPage = itemsPerPage;

this.currentPage = 1;

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
<title>Store Report </title>
<%response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
</head>
<body>
<%! /* This sign makes the variable Global */
String storeid;
%>
<form name="stridpage" ID="" method="POST">
<%@ include file="Header.html" %>

<%
	
//String EStid =((String) session.getAttribute("abc"));
//out.println(EStid);
//session.setAttribute("abc",(String)request.getParameter("Value1"));
String StrId=(String)session.getAttribute("storid"); //This contains StoreId of the store which is used at the time of login.
	//out.println(StrId);


	try{
		Class.forName("com.ibm.db2.jcc.DB2Driver");
		//create the connection database
		Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
		Statement stm = con1.createStatement();
		ResultSet RS = stm.executeQuery("select retail_store.Store_Id,retail_store.Str_Nm,round(sum(retail_str_sales_master.Grand_Total),2) from retail_store,retail_str_sales_master where retail_store.store_id = '"+StrId+"' and retail_str_sales_master.store_id = '"+StrId+"' group by retail_store.str_nm,retail_store.Store_id");
		
		
	
%>
<table align="right">
		<tr>
		<td>
		<button><a href="Login.jsp" style="text-decoration:none" >Logout</a></button>
		</td>
	   </tr>
		</table>
<table >
		<tr>
	<%--<td width="20%" style="font-size: large;text-align: left;background-color: fuchsia;richness:inherit;"><a href="Pallet.jsp" ><img  width="20" height="20" id="homeimg" alt="homeimg" src="src/home3.jpeg">Home</a></td>
		--%>
		<td width="20%"></td>
		<td width="20%"></td>
		<td width="20%"></td>
		<td width="20%"></td>
		</tr>
		</table>
		<br>
		<br>
		<br>
		<table align="right">
		<tr>
		<td>
		<button><a href="Logout.jsp" style="text-decoration:none" >Logout</a></button>
		</td>
	   </tr>
		</table>
		
<table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
<tr class="even">
<th >Store Id</th>
<th >Store Name</th>
<th >Sales Value (In LKR)</th>
</tr>
<%
Document d=new Document(PageSize.A4);
//OutputStream file = new FileOutputStream("/home/naman/workspace/Admin/WebContent/PDF/Report.pdf");
OutputStream file = new FileOutputStream("PDF/Report.pdf");
PdfWriter.getInstance(d, file);
d.open();
//Image image1 = Image.getInstance("/home/naman/workspace/Admin/WebContent/src/logo.jpg");
Image image1 = Image.getInstance("src/logo.jpg");
image1.setAlignment(Element.ALIGN_LEFT);       
d.add(image1);
//Paragraph text =new Paragraph(V_Strnm);
//text.setIndentationRight(20);

//d.add(new Paragraph(text ));
float[] columnWidths = new float[] {40f, 40f, 40f};
PdfPTable table = new PdfPTable(columnWidths);
table.setWidths(columnWidths);
table.setWidthPercentage(90f);

PdfPCell cell = new PdfPCell();
table.addCell("              Store Id");
table.addCell("            Store Name");
table.addCell("      Sales Value (In LKR)");
while (RS.next()){ 
	%>
<tr class="odd">

 <td align="left"><a href="PiersonsReport.jsp?Value1='<%=(RS.getString(1))%>'&Value2=<%=( RS.getString(2))%>" style="color:#00FFF" style="text-decoration: none" ><%=(RS.getString(1))%></a></td>
<TD align="left"><%=(RS.getString(2))%></td>
<TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(3))%>" /> </td>
</tr>
<%
cell = new PdfPCell(new Phrase(RS.getString(1)));
table.addCell(cell);
cell = new PdfPCell(new Phrase(RS.getString(2)));  
table.addCell(cell);  
cell = new PdfPCell(new Phrase(RS.getString(3)));
cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
table.addCell(cell);


}
d.add(table);
d.close();
//out.println("Pdf created successfully..");
%>
</table>
<% 
if(request.getParameter("mail")!=null)
{
String str= "helloworld";   
con1.close();
SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com","keyway12");
SendGrid.Email email = new SendGrid.Email();
//email.addAttachment("Report.pdf", new File("/home/naman/workspace/Admin/WebContent/PDF/Report.pdf"));
email.addAttachment("Report.pdf", new File("PDF/Report.pdf"));
//email.addTo("alok.jayant@99rstreet.com");
email.addTo("malaydixit0412@gmail.com");
email.addTo("namanmse@gmail.com");
email.addTo("gazal.jain@99rstreet.com");
	email.addTo("abhinav.shukla@99rstreet.com");
        email.addTo("laxmee.chandola@99rstreet.com");
email.addTo("tiwarymanis@gmail.com ");
email.setFrom("no-reply@99Retail.com");
email.setFromName("99 Retail Solutions Pvt Ltd");
email.setSubject("Reports");
email.setHtml("<html><body><table<tr><td>Dear ,</td></tr><br><tr><td></td> </tr><br><tr> <td>Regards,</td></tr><br><tr><td></td></tr></table></body><html>"); 
String content = "Please find the attachment" ;
email.setHtml(content);
email.setHtml(content);
 
//email.setText("This is Demo Mail created using Java to show demo of Bluemix SendGrid service to 99 Retail Please ignore<br/><br/>To,<br/><br/>Store Register<br/><br/>Mumbai India <br/><br/>Dear Sir/Madam<br/><br/>Regards<br/>Nilu<br/><br/>99 Retails.<br/><br/>qneha.singh@gmail.com");
try {
SendGrid.Response response1 = sendgrid.send(email);

//out.println(response1.getMessage() + "Hi Kunal How r u ?" );
} catch (SendGridException e) {
// TODO Auto-generated catch block
e.printStackTrace();
}
} 
    }
catch(Exception e)
{
	out.println(e);
}	


%>
<center>
<input  name="mail"  type="submit"  id="exportButton" value="Email As PDF"> 
</center>
<%-- <div id="pageNavPosition" style="padding-top: 20px" align="center">
</div>
<script type="text/javascript">
var pager = new Pager('tablepaging',10);
pager.init();
pager.showPageNav('pager', 'pageNavPosition');
pager.showPage(1);
</script> --%>

<%-- <table align="center" bgcolor="#BDB76B">
<tr bgcolor="#BDB76B">
<td bgcolor="#BDB76B">
 
<button onclick="goBack()">Back</button>

<script>
function goBack() {
    window.history.back();
}
</script>
--%>
</td>
</tr>
</table>
<%--
<%@ include file="Footer.html" %>
 --%>
</form>
</body>
</html>