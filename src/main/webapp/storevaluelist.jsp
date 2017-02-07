<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
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
<%response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
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
<title>Store List Report </title>
<%response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
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
}
  // out.println(mailid);
 try{

  Class.forName("com.ibm.db2.jcc.DB2Driver");
  //create the connection database
  Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
  Statement stm = con1.createStatement();
  Statement stm1 = con1.createStatement();
  ResultSet RS = stm.executeQuery("select retail_store.Store_Id,retail_store.Str_Nm,round(sum(retail_str_sales_detail.total),2) from retail_store,retail_str_sales_detail,retail_dstr_prod where retail_store.store_id=retail_str_sales_detail.store_id and retail_dstr_prod.prod_id=retail_str_sales_detail.prod_id group by retail_str_sales_detail.store_id,retail_store.store_id ,retail_store.Str_Nm");
ResultSet RS1 = stm1.executeQuery("select retail_store.Store_Id,retail_store.Str_Nm,round(sum(retail_str_sales_master.Grand_total),2) from retail_store,retail_str_sales_master where retail_store.store_id=retail_str_sales_master.store_id group by retail_str_sales_master.store_id,retail_store.store_id ,retail_store.Str_Nm");
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
  </tr>
  </table>
  <br>
  <br>
  <br>
  
<table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
<tr class="even">
<th >Store Id</th>
<th >Store Name</th>
<th >Hemas Sales Value (In LKR)</th>
<th >Total Sales Value (In LKR)</th>
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
//Paragraph text =new Paragraph(V_Strnm);
//text.setIndentationRight(20);

//d.add(new Paragraph(text ));
float[] columnWidths = new float[] {40f, 40f, 40f,40f};
PdfPTable table = new PdfPTable(columnWidths);
table.setWidths(columnWidths);
table.setWidthPercentage(90f);

PdfPCell cell = new PdfPCell();
table.addCell("         Store Id");
table.addCell("         Store Name");
table.addCell("Hemas  Sales Value (In LKR)");
table.addCell("Total Sales Value (In LKR)");
String hemasstoreid[]=new String[50];
String totalstoreid[] = new String[50];
String z[] = new String[100];
String y[] = new String[100];
String m[] = new String[100];
String n[] = new String[100];
        int i = 0;
        int j = 0;
        int f =  0;
        int hemas = 0;
        int total=0;
        int storename=0;
        int totalstorename=0;
while(RS.next())
    {
         hemasstoreid[i] = RS.getString(1);
         //out.println(hemasstoreid[i]);
         i++;
          m[storename]=RS.getString(2);
   storename++;
         z[hemas]=RS.getString(3);
         hemas++;
  
   
    }
        while(RS1.next())
        {
           totalstoreid[j] = RS1.getString(1);
        // out.println(totalstoreid[j]);
           j++;
            n[totalstorename]=RS1.getString(2);
             totalstorename++ ;
  
           y[total]= RS1.getString(3);
           total++;
            
        }
        for(int l = 0 ; l < i ; l++)
         {
            for(int k =0 ; k < j ; k++)
            {
               if(( hemasstoreid[l].equals(totalstoreid[k])) && (m[l].equals(n[k])))
                {
                     String vars =hemasstoreid[l]; //hemasstoreid
                    // String totalstrname= z[l]; 
                     String strnm =m[l]; //hemasstorename
                 //  out.println(totalstrname);
                      //out.println(  hemasstoreid[k]);
                     String hemassales= (z[l]); //hemassales
                      String hemassales1= (z[j]);
                       String hemassales2= (z[k]);
                       
                      // out.println(hemassales);
                        // out.println(hemassales1);
                          // out.println(hemassales2);
                       String strid = totalstoreid[l]; //totalstoreid
                     String totalsales= (y[k]); //totalsales
                    //out.println(totalsales);
                       String strname = (n[k]);//totalstorename 
                      // out.println(strname);
%>
<tr class="odd">
<td align="left"><a href="Report.jsp?Value1=<%=vars%>&Value2=<%=strname%>" style="color :#00FFF" style="text-decoration:none"><%=vars%></a></td>
<TD align="left"><%=strnm%></td>
<TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=hemassales%>" /> </td>
<TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=totalsales%>" /> </td>

</tr>
<%
cell = new PdfPCell(new Phrase(vars));
table.addCell(cell);
cell = new PdfPCell(new Phrase(strnm));
table.addCell(cell);
cell = new PdfPCell(new Phrase(hemassales));  
cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
table.addCell(cell);  
cell = new PdfPCell(new Phrase(totalsales));
cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
table.addCell(cell);
} //closing if condition for equal statement
} //closing for loop

} //closing for loop
d.add(table);
d.close();
//out.println("Pdf created successfully..");
%>
</table>
<%
try{
String a[] = new String[10];
	//FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
	FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");
	ResultSet RS2 = stm.executeQuery("select retail_store.Store_Id,retail_store.Str_Nm,round(sum(retail_str_sales_detail.total),2) from retail_store,retail_str_sales_detail,retail_dstr_prod where retail_store.store_id=retail_str_sales_detail.store_id and retail_dstr_prod.prod_id=retail_str_sales_detail.prod_id group by retail_str_sales_detail.store_id,retail_store.store_id ,retail_store.Str_Nm");
        ResultSet RS3 = stm1.executeQuery("select retail_store.Store_Id,retail_store.Str_Nm,round(sum(retail_str_sales_master.Grand_total),2) from retail_store,retail_str_sales_master where retail_store.store_id=retail_str_sales_master.store_id group by retail_str_sales_master.store_id,retail_store.store_id ,retail_store.Str_Nm");
    HSSFWorkbook workbook = new HSSFWorkbook();
    HSSFSheet sheet = workbook.createSheet("New Sheet");
    HSSFRow row = sheet.createRow((short)0);
    HSSFFont font = workbook.createFont();
    font.setColor(HSSFFont.COLOR_RED);
    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    HSSFCell cell1 = row.createCell((short) 0 );
    cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
    cell1.setCellValue("Store Id");
    HSSFCell cell2 = row.createCell((short) 1);
    cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
    cell2.setCellValue("Store Name");
    HSSFCell cell3 = row.createCell((short) 2);
    cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
    cell3.setCellValue("Hemas Sales Value (In LKR)");
    HSSFCell cell4 = row.createCell((short) 3);
    cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
    cell4.setCellValue("Total Sales Value (In LKR)");
int b =1;
   {
	   for(int l = 0 ; l < i ; l++)
         {
            for(int k =0 ; k < j ; k++)
            {
               if(( hemasstoreid[l].equals(totalstoreid[k])) && (m[l].equals(n[k])))
                {
                     String vars =hemasstoreid[l]; //hemasstoreid
                    // String totalstrname= z[l]; 
                     String strnm =m[l]; //hemasstorename
                 //  out.println(totalstrname);
                      //out.println(  hemasstoreid[k]);
                     String hemassales= (z[l]); //hemassales
                      String hemassales1= (z[j]);
                       String hemassales2= (z[k]);
                       
                      // out.println(hemassales);
                        // out.println(hemassales1);
                          // out.println(hemassales2);
                       String strid = totalstoreid[l]; //totalstoreid
                     String totalsales= (y[k]); //totalsales
                    //out.println(totalsales);
                       String strname = (n[k]);//totalstorename 
                   row=sheet.createRow(b);
		   row.createCell((short)0).setCellValue(vars);
		   row.createCell((short)1).setCellValue(strnm);
		   row.createCell((short)2).setCellValue(hemassales);
                    row.createCell((short)3).setCellValue(totalsales);
                b++;        
                }}}
          
   workbook.write(fileOut);
  fileOut.close();
  //out.println("Your excel file has been generated");           
   
   } 
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
//email.addAttachment("Abhi.xls", new File("/home/abhinav/workspace/Admin/WebContent/PDF/Abhi.xls"));
email.addAttachment("Report.pdf", new File("PDF/Report.pdf"));
//email.addAttachment("Abhi.xls", new File("PDF/Abhi.xls"));
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

if((request.getParameter("mailXls")!=null) )
{
	
	String str= "helloworld";   
	con1.close();
	SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com","keyway12");
	SendGrid.Email email = new SendGrid.Email();
	//email.addAttachment("Report.pdf", new File("/home/abhinav/workspace/99ARHEMAS/WebContent/PDF/Report.pdf"));
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

}

    }
catch(Exception e)
{
	out.println(e);
}	


%>
<center>
<input  name="mail"  type="submit"  id="exportButton" value="Email As PDF"> 
<input  name="mailXls"   type="submit"  id="exportButton" value="Email As XLS"> 
</center>
</form>
</body>
</html>