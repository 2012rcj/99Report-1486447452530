<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="com.itextpdf.text.Chunk"%>
<%@page import="com.itextpdf.text.Image"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<title>Hemas Month Share </title>
</head>
<head> <meta http-equiv="refresh" content="60"></head>
<body>
<form name="stridpage" ID="" method="POST">
<%@ include file="Header.html" %>
<%!  String mailid; %>
<%
    
 String usrid=(String)session.getAttribute("usnm");
String psword=(String)session.getAttribute("pswd");
 
  try{
  Class.forName("com.ibm.db2.jcc.DB2Driver");
  Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
  Statement stm = con1.createStatement();
  ResultSet RS = stm.executeQuery("select EMAIL from retail_registration where Name='"+usrid+"' and Password='"+psword+"'");
 while(RS.next()){
  mailid  =(RS.getString(1));


 }
  }catch(Exception e)
{
	out.println(e);
} %>
<%
    String EStid=(String)session.getAttribute("abc");
    String V_Strnm = (String)session.getAttribute("efg");
    //out.println(EStid);
if((EStid !=null))
{
	try{
		Class.forName("com.ibm.db2.jcc.DB2Driver");
		//create the connection database
		Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
		Statement stm = con1.createStatement();
		Statement stm1 = con1.createStatement();
		ResultSet RS = stm.executeQuery("select extract(year from retail_str_sales_detail.sale_date),to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month'),round(sum(retail_str_sales_detail.total),2),DAY(LAST_DAY (retail_str_sales_detail.sale_date)) from retail_str_sales_detail where retail_str_sales_detail.store_id='"+EStid+"' group by extract(year from retail_str_sales_detail.sale_date),extract(month from retail_str_sales_detail.sale_date),( DAY(LAST_DAY (retail_str_sales_detail.sale_date))) order by extract(year from retail_str_sales_detail.sale_date) desc , to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month') asc");
		ResultSet RS1=stm1.executeQuery("select extract(year from retail_str_sales_detail.sale_date),to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month'),round(sum(retail_str_sales_detail.total),2),DAY(LAST_DAY (retail_str_sales_detail.sale_date)) from retail_dstr_prod,retail_str_sales_detail where retail_dstr_prod.prod_id=retail_str_sales_detail.prod_id and retail_str_sales_detail.store_id='"+EStid+"' group by extract(year from retail_str_sales_detail.sale_date),extract(month from retail_str_sales_detail.sale_date),( DAY(LAST_DAY (retail_str_sales_detail.sale_date))) order by extract(year from retail_str_sales_detail.sale_date) desc , to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month') asc");
//RS is used for total sales.
//RS1 is used for hemas sales.
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
<li><a href="#">Hemas Sales Report</a>
<ul id="report">
<li><a href="hemassalesdaily.jsp">Day Wise Product</a></li>
</ul>
</li>
<li><a href="#">Market Share (Hemas)</a>
<ul id="report">
 <li><a href="Marketshare.jsp">Daily</a></li> 
<li><a href="hemasMonthShare.jsp">Monthly</a></li>
<li><a href="HemasyearShare.jsp">Yearly</a></li>
</ul>
</li>
</ul>
</li>
</ul>
</tr>
 <div style="text-align: center">
<div style="color: Indigo;"><h2><u><b>Welcome Hemas</u></b></h2></div> 
<div style="color: Indigo;"><h3><u><b><% out.println(V_Strnm); %></u></b></h3></div>
</div>
</table>
<table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
<tr class="even">
    <th>Month&nbsp&nbsp</th> 
   <th>Total Sales &nbsp&nbsp(In LKR)</th>
   <th>Hemas Sales &nbsp&nbsp(In LKR)</th>
     <th>Market Share &nbsp&nbsp(In %)</th> 
    </tr>
     <%
Document d=new Document(PageSize.A4);
//OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
OutputStream file = new FileOutputStream("PDF/Report.pdf");
PdfWriter.getInstance(d, file);
d.open();
//Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/logo.jpg");
Image image1 = Image.getInstance("src/logo.jpg");
image1.setAlignment(Element.ALIGN_LEFT);       
 d.add(image1);
 Paragraph text =new Paragraph(V_Strnm);
text.setIndentationRight(20);
text.setAlignment(Element.ALIGN_CENTER);

text.setSpacingAfter(30f);
d.add(new Paragraph(text ));
float[] columnWidths = new float[] {30f, 45f,45f,45f};
PdfPTable table = new PdfPTable(columnWidths);
table.setWidths(columnWidths);
table.setWidthPercentage(85f);

PdfPCell cell = new PdfPCell(text);
table.addCell("   Month");
table.addCell("Total Sales(In LKR)");
table.addCell("Hemas Sales(In LKR)");
table.addCell("Market Share(In %)");
 while (RS.next() && RS1.next()) 
 {
	String mont= RS1.getString(2);
   if(mont.equals(RS.getString(2)))
	{
	%>
<tr class="odd">
<td align="left"><%=mont%></td>
<TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="true" value="<%=(RS.getString(3)) %>" /></td>
<TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="true" value="<%=(RS1.getString(3)) %>" /></td>
<td align="RIGHT"><fmt:formatNumber type="number"  minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(((Float.parseFloat(RS1.getString(3)))*100)/(Float.parseFloat(RS.getString(3))))%>"/></td>
</tr>
		<%
 float marketshare = ((Float.parseFloat(RS1.getString(3)))*100)/(Float.parseFloat(RS.getString(3)));
 double s= Math.round(marketshare * 100.0)/100.0;
// /out.println(s);
String t = Double.toString(s);
Float avgsales=((Float.parseFloat(RS.getString(3)))/(Float.parseFloat(RS.getString(4))));
double avg= Math.round(avgsales * 100.0)/100.0;
// /out.println(s);
String avgsale = Double.toString(avg);
cell = new PdfPCell(new Phrase(mont) );
table.addCell(cell);
cell = new PdfPCell(new Phrase(RS.getString(3)));
cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
table.addCell(cell);
cell = new PdfPCell(new Phrase(RS1.getString(3)));
cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
table.addCell(cell);
cell = new PdfPCell(new Phrase(t));
 cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
         table.addCell(cell);
}
}
d.add(table);
try{
            String a[]=new String[1000];//declaration and instantiation
            String z[]=new String[1000];
            int i = 0;
            int j=0;
            float sum = 0 ;
            float sum1 = 0 ;
                Class.forName("com.ibm.db2.jcc.DB2Driver");
		Connection con2 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
		Statement stmt = con2.createStatement();
               ResultSet RS2 = stm.executeQuery("select extract(year from retail_str_sales_detail.sale_date),to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month'),round(sum(retail_str_sales_detail.total),2),DAY(LAST_DAY (retail_str_sales_detail.sale_date)) from retail_str_sales_detail where retail_str_sales_detail.store_id='"+EStid+"' group by extract(year from retail_str_sales_detail.sale_date),extract(month from retail_str_sales_detail.sale_date),( DAY(LAST_DAY (retail_str_sales_detail.sale_date))) order by extract(year from retail_str_sales_detail.sale_date) desc , to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month') asc ");
		ResultSet RS3=stm1.executeQuery("select extract(year from retail_str_sales_detail.sale_date),to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month'),round(sum(retail_str_sales_detail.total),2),DAY(LAST_DAY (retail_str_sales_detail.sale_date)) from retail_dstr_prod,retail_str_sales_detail where retail_dstr_prod.prod_id=retail_str_sales_detail.prod_id and retail_str_sales_detail.store_id='"+EStid+"' group by extract(year from retail_str_sales_detail.sale_date),extract(month from retail_str_sales_detail.sale_date),( DAY(LAST_DAY (retail_str_sales_detail.sale_date))) order by extract(year from retail_str_sales_detail.sale_date) desc , to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month') asc ");

 while (RS2.next() && RS3.next()) 
 {
	String month= RS3.getString(2);
   if(month.equals(RS2.getString(2)))
	{
a[i] = RS2.getString(3);
z[j]= RS3.getString(3);
                    i++;
j++;
}}
for(int b = 0 ; b < i ; b++)
{
     sum = sum + Float.parseFloat(a[b]);
sum1 = sum1 + Float.parseFloat(z[b]);
}
String strAmount=String.valueOf(sum);
String hemastotal=String.valueOf(sum1);
//out.println(strAmount);
Paragraph p= new Paragraph();
p.add(new Chunk ("Total Sales Value (In LKR) :-      "));
p.add(new Chunk(   strAmount));
PdfPCell cell1 = new PdfPCell();

cell1.addElement(p);
p.setAlignment(Element.ALIGN_CENTER);
d.add(p);
Paragraph p1= new Paragraph();
p1.add(new Chunk ("Hemas Sales Value (In LKR) :-      "));
p1.add(new Chunk(   hemastotal));
PdfPCell cell2 = new PdfPCell();

cell2.addElement(p1);
p1.setAlignment(Element.ALIGN_CENTER);
d.add(p1);
}
catch(Exception e)
    {
        out.println(e);
    }


d.close();
//out.println("Pdf created successfully..");
%>
</table>
<%
try
{
String a[] = new String[100];
int i=0;
	
	//FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
	FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");
        ResultSet RS2 = stm.executeQuery("select extract(year from retail_str_sales_detail.sale_date),to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month'),round(sum(retail_str_sales_detail.total),2),DAY(LAST_DAY (retail_str_sales_detail.sale_date)) from retail_str_sales_detail where retail_str_sales_detail.store_id='"+EStid+"' group by extract(year from retail_str_sales_detail.sale_date),extract(month from retail_str_sales_detail.sale_date),( DAY(LAST_DAY (retail_str_sales_detail.sale_date))) order by extract(year from retail_str_sales_detail.sale_date) desc , to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month') asc");
	ResultSet RS3=stm1.executeQuery("select extract(year from retail_str_sales_detail.sale_date),to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month'),round(sum(retail_str_sales_detail.total),2),DAY(LAST_DAY (retail_str_sales_detail.sale_date)) from retail_dstr_prod,retail_str_sales_detail where retail_dstr_prod.prod_id=retail_str_sales_detail.prod_id and retail_str_sales_detail.store_id='"+EStid+"' group by extract(year from retail_str_sales_detail.sale_date),extract(month from retail_str_sales_detail.sale_date),( DAY(LAST_DAY (retail_str_sales_detail.sale_date))) order by extract(year from retail_str_sales_detail.sale_date) desc , to_char(to_date(extract(month from retail_str_sales_detail.sale_date),'MM'),'Month') asc");

      HSSFWorkbook workbook = new HSSFWorkbook();
    HSSFSheet sheet = workbook.createSheet("New Sheet");
    HSSFRow row = sheet.createRow((short)0);
    HSSFFont font = workbook.createFont();
    font.setColor(HSSFFont.COLOR_RED);
    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    HSSFCell cell1 = row.createCell((short) 0 );
    cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
    cell1.setCellValue("Month");
     HSSFCell cell2 = row.createCell((short) 1);
    cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
    cell2.setCellValue("Total Sales(In LKR)");
    
    HSSFCell cell3 = row.createCell((short) 2);
    cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
    cell3.setCellValue("Hemas Sales(In LKR");
    
    HSSFCell cell4 = row.createCell((short) 3);
    cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
    cell4.setCellValue("Market Share(In %)");
int b =1;
  while (RS2.next() && RS3.next()) 
 {
	String month= RS3.getString(2);
        
   if(month.equals(RS2.getString(2)))
	{
float marketshare = ((Float.parseFloat(RS3.getString(3)))*100)/(Float.parseFloat(RS2.getString(3)));
 double s= Math.round(marketshare * 100.0)/100.0;
// /out.println(s);
String t = Double.toString(s);
		   row=sheet.createRow(b);
		   row.createCell((short)0).setCellValue(month);
		   row.createCell((short)1).setCellValue(RS2.getString(3));
		   row.createCell((short)2).setCellValue(RS3.getString(3));
		   row.createCell((short)3).setCellValue(t);
		  
		   b++;
     // out.println("hi");
    }
 }
   workbook.write(fileOut);
  fileOut.close();
  //out.println("Your excel file has been generated");           
     
} catch ( Exception ex ) {
          
        }
    
%>
<% 
if((request.getParameter("mail")!=null) )
{
String str= "helloworld";   
con1.close();
SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com","keyway12");
SendGrid.Email email = new SendGrid.Email();
//email.addAttachment("Report.pdf", new File("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf"));
//email.addAttachment("Abhi.xls", new File("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf"));
email.addAttachment("Report.pdf", new File("PDF/Report.pdf"));
email.addTo(mailid);
email.setFrom("no-reply@99Retail.com");
email.setFromName("99 Retail Solutions Pvt Ltd");
email.setSubject("Reports");
email.setHtml("<html><body><table<tr><td>Dear ,</td></tr><br><tr><td></td> </tr><br><tr> <td>Regards,</td></tr><br><tr><td></td></tr></table></body><html>"); 
String content = "Please find the attachment" ;
email.setHtml(content);
email.setHtml(content);

try {
SendGrid.Response response1 = sendgrid.send(email);
} catch (SendGridException e) {
e.printStackTrace();
}
}

if((request.getParameter("mailXls")!=null) )
{

	String str= "helloworld";   
	con1.close();
	SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com","keyway12");
	SendGrid.Email email = new SendGrid.Email();
	//email.addAttachment("Report.pdf", new File("/home/abhinav/workspace/Admin/WebContent/PDF/Report.pdf"));
	//email.addAttachment("Report.xls", new File("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls"));
	email.addAttachment("Report.xls", new File("PDF/Report.xls"));
	email.addTo(mailid);
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

	} catch (SendGridException e) {
	
	e.printStackTrace();
	}

}

    }
catch(Exception e)
{
	out.println(e);
}	

}
%>
<center>
<input  name="mail"  type="submit"  id="exportButton" value="Email As PDF"> 
<input  name="mailXls"   type="submit"  id="exportButton" value="Email As XLS"> 
</center>
<div id="pageNavPosition" style="padding-top: 20px" align="center">
</div>
<script type="text/javascript">
var pager = new Pager('tablepaging',05);
pager.init();
pager.showPageNav('pager', 'pageNavPosition');
pager.showPage(1);
</script>
<br>
<table align="center" bgcolor="#BDB76B">
<tr bgcolor="#BDB76B">
<td bgcolor="#BDB76B">
<center><button><a href="#" onClick="history.go(-1);return true;">Back</a></button></center>
</table>
<%--
<%@ include file="Footer.html" %>
 --%>
</form>
</body>
</html>