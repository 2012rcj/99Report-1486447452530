<%@ page import="java.text.SimpleDateFormat" %>
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
<%@ page import=" com.itextpdf.text.DocumentException" %>
<%@ page import=" com.itextpdf.text.Phrase" %>
<%@ page import="com.itextpdf.text.Element" %>
<%@ page import=" com.itextpdf.text.PageSize" %>
<%@ page import=" com.itextpdf.text.Paragraph" %>
<%@ page import=" com.itextpdf.text.Phrase" %>
<%@ page import=" com.itextpdf.text.pdf.PdfPCell" %>
<%@ page import=" com.itextpdf.text.pdf.PdfPTable" %>
<%@ page import=" com.itextpdf.text.pdf.PdfWriter" %>
<%@ page import=" java.io.IOException" %>
<%@ page import=" java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.itextpdf.text.Image"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFFont" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCellStyle" %>
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
<title>Hemas Sales Daily </title>
<%response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
</head>
<body>
<form name="stridpage" ID="" method="POST">
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

<%@ include file="Header.html" %>

<%  String EStid=(String)session.getAttribute("abc");
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
ResultSet RS = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_dstr_prod,retail_str_sales_detail where retail_str_sales_detail.store_id='"+EStid+"'and retail_dstr_prod.prod_id=retail_str_sales_detail.prod_id group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
ResultSet RS1 = stm1.executeQuery("select round(sum(total),2),sale_date from retail_str_sales_detail where store_id='"+EStid+"' group by sale_date order by sale_date desc ");
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
<li><a href="AdminStore.jsp">Home</a></li>
<li><a href="Admin_salesreportdaily.jsp" >Sales Report Daily</a></li>
<li><a href="Admin_datewisebill.jsp">Sales Report Billing </a>
</li>
<li><a href="#">Hemas Sales Report</a>
<ul id="report">
<li><a href="Admin_hemassalesdaily.jsp">Daily Product</a></li>
</ul>
</li>
 <li><a href="#">Market Share</a>
<ul id="report">
<li><a href="Admin_Daymarketshare.jsp">Daily Share</a></li>
<li><a href="AdminMonthShare.jsp">Monthly Share</a></li>
<li><a href="AdminyearShare.jsp">Yearly Share</a></li>
</ul>
</li>
<li><a href="#">Top 15 Products</a>
<ul id="report">
<li><a href="top15productsbyvalue.jsp">By Value</a></li>
<li><a href="top15productsbyqty.jsp">By Quantity</a>
</ul>
</li>
<li><a href="#">Average Sales Report</a>
<ul id="report">
<li><a href="monthlyavg.jsp">Daily</a></li>
<li><a href="admin_monthavg.jsp">Monthly</a></li>
</ul>
</li>
<li><a href="#">Graphical Reports</a>
<ul id="report">
<li><a href="#"> Average</a> 
<ul id="report">
<li><a href="admingraph_daily_avg.jsp">Daily</a></li> 
<li><a href="admingraph_monthly_avg.jsp">Monthly</a></li>
<li><a href="admingraph_yearly_avg.jsp">Yearly</a></li>
</ul>
</li>
<li><a href="admingraph_yearly_share.jsp"> Market Share (Hemas)</a> 
</ul>
</li>
<li><a href="#">Consolidated Reports</a>
<ul id="report">
<li><a href="Admin_Consolidated_Report_Daily.jsp">Daily</a></li>
<li><a href="Admin_Consolidated_Report_Weekly.jsp">Weekly</a>
<li><a href="Admin_Consolidated_Report_Monthly.jsp">Monthly</a>
<li><a href="Admin_Consolidated_Report_Quarterly.jsp">Quarterly</a>
<li><a href="Admin_Consolidated_Report_Yearly.jsp">Yearly</a>
</ul>
</li>
<li><a href="Admin_inventorydaywise.jsp">Inventory Reports</a></li>
<li><a href="therapeutic.jsp">Therapeutic Classes</a></li>
</ul>
</li>
</ul>
 <div style="text-align: center">

<div style="color: Indigo;"><h3><u><b><% out.println(V_Strnm); %></u></b></h3></div>
</div>
</table>
<table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
<tr class="even">
    
   <th>Sale Date</th>
   <th>Hemas Sales &nbsp&nbsp(In LKR)</th>
   <th>Total Sales &nbsp&nbsp(In LKR)</th>
      <th>Market Share &nbsp&nbsp(In %)</th>
     </tr>
     <%
     Document d=new Document(PageSize.A4);
   // OutputStream file = new FileOutputStream("/home/abhinav/workspace/99AR_dashdb/WebContent/PDF/Report.pdf");
    OutputStream file = new FileOutputStream("PDF/Report.pdf");
     PdfWriter.getInstance(d, file);
     d.open();
  //Image image1 = Image.getInstance("/home/abhinav/workspace/99AR_dashdb/WebContent/src/logo.jpg");
   Image image1 = Image.getInstance("src/logo.jpg");
   image1.setAlignment(Element.ALIGN_LEFT);       
   d.add(image1);
     Paragraph text =new Paragraph(V_Strnm);
     text.setIndentationRight(20);
     text.setAlignment(Element.ALIGN_CENTER);
text.setSpacingAfter(30f);
d.add(new Paragraph(text ));
float[] columnWidths = new float[] {40f, 45f,40f,40f};
PdfPTable table = new PdfPTable(columnWidths);
table.setWidths(columnWidths);
table.setWidthPercentage(100f);;
PdfPCell cell = new PdfPCell(text);
table.addCell("         Sale Date");
table.setTotalWidth(0f);
table.addCell(" Hemas Sales (In LKR)");

table.setTotalWidth(20f);
table.addCell(" Total Sales (In LKR)");
table.setTotalWidth(20f);
table.addCell("    Market Share (In %)");
table.setTotalWidth(20f);
String a[]=new String[1000];
String b[] = new String[1000];
String z[] = new String[1000];
String y[] = new String[1000];
int i = 0;
int j = 0;
int f =  0;
int l=0;
int k=0;
int hemas = 0;
int total=0;
int count=0;
 while(RS.next())
    {
         b[i] = RS.getString(1);
         // out.println(b[i]);
         i++;
         z[hemas]=RS.getString(2);
         hemas++;
   
    }
        while(RS1.next())
        {
           a[j] = RS1.getString(2);
         //out.println(a[j]);
           j++;
  
           y[total]= RS1.getString(1);
           total++;
        }
         for( l = 0 ; l < j ; l++)
         {
            for(k =0 ; k < i ; k++)
            {
               if(a[l].equals(b[k]))
                {
                     String vars = a[l];
                   //out.println(vars);
                      //out.println(a[k]);
                     String hemassales= (z[k]);
                       //out.println(hemassales);
                     String totalsales= (y[l]);
                    
                       //out.println(totalsales);
float x = ((Float.parseFloat(hemassales))*100)/(Float.parseFloat(totalsales));
 
double s= Math.round(x * 100.0)/100.0;
// /out.println(s);
String t = Double.toString(s);
%>
<tr class="odd">
<TD align="left"><%=vars%></td>
<TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="true" value="<%=hemassales %>" /></td>
<TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="true" value="<%=totalsales%>" /></td>
 <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" groupingUsed="true" value= "<%=t%>" /></td>
</tr>
<%
cell = new PdfPCell(new Phrase(vars));
cell.setHorizontalAlignment(Element.ALIGN_LEFT);
table.addCell(cell);
cell = new PdfPCell(new Phrase(hemassales)); 
cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
table.addCell(cell);
cell = new PdfPCell(new Phrase(totalsales)); 
cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
table.addCell(cell);
cell = new PdfPCell(new Phrase(t));  
cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
table.addCell(cell);
++count;
}
       }
}
d.add(table);
d.close();
%>   
</table>
<%if(count<1){ %>
<br>
<table align="center" ><tr align="center" > <td>&nbsp&nbsp No Data available for Selected Store :&nbsp <%=(V_Strnm)%> &nbsp &nbsp </td><tr>  </table>  
<br>
     <% 
     }%>
     <%
 //FileOutputStream fileOut = new FileOutputStream("/home/abhinav/workspace/99AR_dashdb/WebContent/PDF/Report.xls");
      FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");
 ResultSet RS2 = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_dstr_prod,retail_str_sales_detail where retail_str_sales_detail.store_id='"+EStid+"'and retail_dstr_prod.prod_id=retail_str_sales_detail.prod_id group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
ResultSet RS3 = stm1.executeQuery("select round(sum(total),2),sale_date from retail_str_sales_detail where store_id='"+EStid+"' group by sale_date order by sale_date desc ");
    HSSFWorkbook workbook = new HSSFWorkbook();
    HSSFSheet sheet = workbook.createSheet("New Sheet");
    HSSFRow row = sheet.createRow((short)0);
    HSSFFont font = workbook.createFont();
    font.setColor(HSSFFont.COLOR_RED);
    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    HSSFCell cell1 = row.createCell((short) 0 );
    cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
    cell1.setCellValue("Sale Date");
    HSSFCell cell2 = row.createCell((short) 1);
    cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
    cell2.setCellValue("Hemas Sales Value (In LKR)");
    HSSFCell cell3 = row.createCell((short) 2);
    cell3.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
    cell3.setCellValue("Total Sales Value (In LKR)");
    HSSFCell cell4 = row.createCell((short) 3);
    cell4.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
    cell4.setCellValue("Market Share(In %)");
   int c =1;
   String a1[]=new String[1000];
   String b1[] = new String[1000];
  String z1[] = new String[1000];
  String y1[] = new String[1000];
   int i1 = 0;
   int j1 = 0;
   int f1 =  0;
   int l1=0;
   int k1=0;
   int hemas1 = 0;
   int total1=0;
   int count1=0;
   
   while(RS2.next())
   {
        b1[i1] = RS2.getString(1);
        // out.println(b[i]);
        i1++;
        z1[hemas1]=RS2.getString(2);
        hemas1++;
  
   }
       while(RS3.next())
       {
          a1[j1] = RS3.getString(2);
        //out.println(a[j]);
          j1++;
 
          y1[total1]= RS3.getString(1);
          total1++;
       }
       for( l1 = 0 ; l1 < j1 ; l1++)
        {
           for(k1 =0 ; k1 < i1 ; k1++)
           {
              if(a1[l1].equals(b1[k1]))
               {
                    String vars = a1[l1];
                 // out.println(vars);
                     //out.println(a[k]);
                    String hemassales= (z1[k1]);
                  //    out.println(hemassales);
                    String totalsales= (y1[l1]);
                   
                      //out.println(totalsales);
float x = ((Float.parseFloat(hemassales))*100)/(Float.parseFloat(totalsales));

double s= Math.round(x * 100.0)/100.0;
///out.println(s);
String t = Double.toString(s);
///out.println(t);
row=sheet.createRow(c);
row.createCell((short)0).setCellValue(vars);
row.createCell((short)1).setCellValue(hemassales);
row.createCell((short)2).setCellValue(totalsales);
row.createCell((short)3).setCellValue(t);
c++;

               }}}
   workbook.write(fileOut);
  fileOut.close();
  //out.println("Your excel file has been generated");           
 
   
   con1.close();
} 
catch(Exception e)
{
	out.println(e);
}
   

%>
<center>
<input  name="mail"  type="submit"  value="Email As PDF"> 
<input  name="mailXls"   type="submit"  value="Email As XLS"> 
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
</td>
</tr>
</table>
<%}
   if((request.getParameter("mail")!=null) )
{
String str= "helloworld";   

SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com","keyway12");
SendGrid.Email email = new SendGrid.Email();
//email.addAttachment("Report.pdf", new File("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf"));
//email.addAttachment("Report.pdf", new File("/home/abhinav/workspace/99AR_dashdb/WebContent/PDF/Report.pdf"));
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

//out.println(response1.getMessage() + "Hi Kunal How r u ?" );
} catch (SendGridException e) {
// TODO Auto-generated catch block
e.printStackTrace();
}
}
%>
<%

if((request.getParameter("mailXls")!=null) )
{

	String str= "helloworld";   
	
	SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com","keyway12");
	SendGrid.Email email = new SendGrid.Email();
	//email.addAttachment("Report.xls", new File("/home/abhinav/workspace/99AR_dashdb/WebContent/PDF/Report.xls"));
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

	//out.println(response1.getMessage() + "Hi Kunal How r u ?" );
	} catch (SendGridException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	}

}%>

<%--
<%@ include file="Footer.html" %>
 --%>
</form>
</body>
</html>