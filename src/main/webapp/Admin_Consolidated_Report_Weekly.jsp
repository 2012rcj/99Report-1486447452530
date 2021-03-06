<%@page import="com.itextpdf.text.Image"%>
<%@ page language="java" import="java.sql.*"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import=" com.sendgrid.*"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.lang.Object"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import=" java.io.FileOutputStream"%>
<%@ page import=" java.io.BufferedReader"%>
<%@ page import=" java.io.DataOutputStream"%>
<%@ page import=" java.io.InputStreamReader"%>
<%@ page import=" java.net.HttpURLConnection"%>
<%@ page import="  java.net.URL"%>
<%@ page import="  java.io.File"%>
<%@ page import="  com.itextpdf.text.Font"%>
<%@ page import=" com.itextpdf.text.Font.FontFamily"%>
<%@ page import="com.itextpdf.text.BaseColor"%>
<%@ page import=" com.itextpdf.text.Document"%>
<%@ page import="com.itextpdf.text.Element"%>
<%@ page import=" com.itextpdf.text.PageSize"%>
<%@ page import=" com.itextpdf.text.Paragraph"%>
<%@ page import=" com.itextpdf.text.Phrase"%>
<%@ page import=" com.itextpdf.text.pdf.PdfPCell"%>
<%@ page import=" com.itextpdf.text.pdf.PdfPTable"%>
<%@ page import=" com.itextpdf.text.pdf.PdfWriter"%>
<%@ page import=" java.io.IOException"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
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

#report li {
	background: #E91E63;
}

li ul {
	display: none;
}

ul li a {
	display: block;
	padding: 5px;
	text-decoration: none;
	white-space: nowrap;
	color: #fff;
}

ul li a:hover {
	background: #2c3e50;
}

li:hover>ul {
	display: block;
	position: absolute;
}

li:hover li {
	float: none;
}

li:hover li a:hover {
	background: orange;
}

.main-navigation li ul li {
	border-top: 0;
}

ul ul ul {
	left: 100%;
	top: 0;
}

ul:before, ul:after {
	content: " "; /* 1 */
	display: table; /* 2 */
}

ul:after {
	clear: both;
}

tr:nth-child(even) {
	background: #C5CAE9
}

tr:nth-child(odd) {
	background: #00BCD4
}

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
}
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
<title>Consolidated Report Weekly</title>
</head>
<head> <meta http-equiv="refresh" content="60"></head>
<body>
	<form name="stridpage" ID="" method="POST">
		<%@ include file="Header.html"%>
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
			String EStid = (String) session.getAttribute("abc");
			String V_Strnm = (String) session.getAttribute("efg");
			//out.println(EStid);
			if ((EStid != null)) {
				try {
					Class.forName("com.ibm.db2.jcc.DB2Driver");
					//create the connection database
					Connection con1 = DriverManager.getConnection(
							"jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
					Statement stm = con1.createStatement();
					Statement stm1 = con1.createStatement();
					ResultSet RS = stm.executeQuery(
							"select prod_nm,prod_id,qty,(round(total,2)) from retail_str_sales_detail where store_id='"
									+ EStid
									+ "' and sale_date Between ((select current_date from sysibm.sysdummy1)-7) and  (select current_date from sysibm.sysdummy1)");
		%>
		<table align="right">
			<tr>
				<td>
					<button>
						<a href="Login.jsp" style="text-decoration: none">Logout</a>
					</button>
				</td>
			</tr>
		</table>
		<table style="width: 100%">
			<tr>
				<ul class="main-navigation">
					<li><a href="#">Manufacturers Reports</a>
						<ul>
							<li><a href="AdminStore.jsp">Home</a></li>
<li><a href="Admin_salesreportdaily.jsp" >Sales Report Daily</a></li>
<li><a href="Admin_datewisebill.jsp">Sales Report Billing </a>
</li>
<li><a href="#">Hemas Sales Report</a>
<ul id="report">
<li><a href="Admin_hemassalesdaily.jsp">Daily Product</a></li>
								</ul></li>
							<li><a href="#">Market Share</a>
								<ul id="report">
									<li><a href="Admin_Daymarketshare.jsp">Daily Share</a></li>
									<li><a href="AdminMonthShare.jsp">Monthly Share</a></li>
									<li><a href="AdminyearShare.jsp">Yearly Share</a></li>
								</ul></li>
							<li><a href="#">Top 15 Products</a>
								<ul id="report">
									<li><a href="top15productsbyvalue.jsp">By Value</a></li>
									<li><a href="top15productsbyqty.jsp">By Quantity</a>
								</ul></li>
							<li><a href="#">Average Sales Report</a>
								<ul id="report">
									<li><a href="monthlyavg.jsp">Daily</a></li>
								<li><a href="admin_monthavg.jsp">Monthly</a></li>
                                                                </ul></li>
							<li><a href="#">Graphical Reports</a>
								<ul id="report">
									<li><a href="#"> Average</a>
										<ul id="report">
											<li><a href="admingraph_daily_avg.jsp">Daily</a></li>
											<li><a href="admingraph_monthly_avg.jsp">Monthly</a></li>
											<li><a href="admingraph_yearly_avg.jsp">Yearly</a></li>
										</ul></li>
									<li><a href="admingraph_yearly_share.jsp"> Market
											Share (Hemas)</a>
								</ul></li>
							<li><a href="#">Consolidated Reports</a>
								<ul id="report">
									<li><a href="Admin_Consolidated_Report_Daily.jsp">Daily</a></li>
									<li><a href="Admin_Consolidated_Report_Weekly.jsp">Weekly</a>
									<li><a href="Admin_Consolidated_Report_Monthly.jsp">Monthly</a>
									<li><a href="Admin_Consolidated_Report_Quarterly.jsp">Quarterly</a>
									<li><a href="Admin_Consolidated_Report_Yearly.jsp">Yearly</a>
								</ul></li>
							<li><a href="Admin_inventorydaywise.jsp">Inventory Reports</a></li>
							<li><a href="therapeutic.jsp">Therapeutic Classes</a></li>
						</ul></li>
				</ul>
			</tr>
			<div style="text-align: center">
				<!--<div style="color: Indigo;"><h2><u><b>Welcome Hemas</u></b></h2></div> -->
				<div style="color: Indigo;">
					<h3>
						<u><b>
								<%
									out.println(V_Strnm);
								%>
						</u></b>
					</h3>
				</div>
			</div>
		</table>
		<center>
			<table border="0" cellspacing="0">

				<tr>
					<td align='center'>


						</center> </select>
					</td>


					<br>
					<table style="white-space: nowrap;" border="1" align="center"
						id="tablepaging">
						<tr class="even">
							<th>Product Name&nbsp&nbsp</th>
							<th>Product Id&nbsp&nbsp</th>
							<th>Qty &nbsp&nbsp</th>
							<th>Sale Value &nbsp&nbsp(In LKR)</th>
							<!--  <th>Market Share &nbsp&nbsp(In %)</th> -->
							<!-- <th>No. of Transaction &nbsp&nbsp(In Unit)</th>
    <th>Monthly Average Sales/Day (In LKR) </th>-->
						</tr>
						<%
							Document d = new Document(PageSize.A4);
									//   OutputStream file = new FileOutputStream("/home/abhinav/workspace/99ARHEMAS/WebContent/PDF/Report.pdf");
									OutputStream file = new FileOutputStream("PDF/Report.pdf");
									PdfWriter.getInstance(d, file);
									d.open();
									//Image image1 = Image.getInstance("/home/abhinav/workspace/99ARHEMAS/WebContent/src/logo.jpg");
									Image image1 = Image.getInstance("src/logo.jpg");
									image1.setAlignment(Element.ALIGN_LEFT);
									d.add(image1);
									Paragraph text = new Paragraph(V_Strnm);
									text.setIndentationRight(20);
									text.setAlignment(Element.ALIGN_CENTER);

									text.setSpacingAfter(30f);
									d.add(new Paragraph(text));
									float[] columnWidths = new float[] { 45f, 45f, 45f, 45f };
									PdfPTable table = new PdfPTable(columnWidths);
									table.setWidths(columnWidths);
									table.setWidthPercentage(85f);

									PdfPCell cell = new PdfPCell(text);
									table.addCell("Product Name");
									table.addCell("Product Id");
									table.addCell("Qty");
									table.addCell(" Sale  Value(In LKR)");
									int count = 0;
									//table.addCell("Market Share(In %)");
									//table.addCell("No. of Transaction(In Unit)");
									//table.addCell("Monthly Average Sales/Day(In LKR)");
									while (RS.next()) {
						%>
						<tr class="odd">

							<td align="left"><%=RS.getString(1)%></td>
							<td align="right"><%=RS.getString(2)%></td>
							<td align="right"><%=RS.getString(3)%></td>
							<TD align="right"><fmt:formatNumber type="number"
									minFractionDigits="2" maxFractionDigits="2" groupingUsed="true"
									value="<%=(RS.getString(4))%>" /></td>

						</tr>
						<%
							cell = new PdfPCell(new Phrase(RS.getString(1)));
										table.addCell(cell);
										cell = new PdfPCell(new Phrase(RS.getString(2)));
										cell.setHorizontalAlignment(Element.ALIGN_LEFT);
										table.addCell(cell);
										cell = new PdfPCell(new Phrase(RS.getString(3)));
										cell.setHorizontalAlignment(Element.ALIGN_LEFT);
										table.addCell(cell);
										cell = new PdfPCell(new Phrase(RS.getString(4)));
										cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										table.addCell(cell);
										++count;
									}
									d.add(table);

									d.close();
									//out.println("Pdf created successfully..");
						%>
					</table>
					<%
						if (count < 1) {
					%>
					<br>
					<table align="center">
						<tr align="center">
							<td>&nbsp&nbsp No Data available for Selected Store :&nbsp <%=(V_Strnm)%>
								&nbsp &nbsp
							</td>
						<tr>
					</table>
					<br>
					<%
						}
					%>
					<%
						try {
									String a[] = new String[10];
									int i = 0;
									/* String Abhi = "/home/abhinav/workspace/Admin/WebContent/PDF/Abhi.xls"; */
									//FileOutputStream fileOut = new FileOutputStream("/home/abhinav/workspace/99ARHEMAS/WebContent/PDF/Abhi.xls");
									FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");

									ResultSet RS1 = stm.executeQuery(
											"select prod_nm,prod_id,qty,(round(total,2)) from retail_str_sales_detail where store_id='"
													+ EStid
													+ "' and sale_date Between ((select current_date from sysibm.sysdummy1)-7) and  (select current_date from sysibm.sysdummy1)");
									HSSFWorkbook workbook = new HSSFWorkbook();
									HSSFSheet sheet = workbook.createSheet("New Sheet");
									HSSFRow row = sheet.createRow((short) 0);
									HSSFFont font = workbook.createFont();
									font.setColor(HSSFFont.COLOR_RED);
									font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
									HSSFCell cell1 = row.createCell((short) 0);
									cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
									cell1.setCellValue("Product Name");

									HSSFCell cell2 = row.createCell((short) 1);
									cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
									cell2.setCellValue("Product Id");

									HSSFCell cell3 = row.createCell((short) 2);
									cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
									cell3.setCellValue("Qty");

									HSSFCell cell4 = row.createCell((short) 3);
									cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
									cell4.setCellValue("Sale Value  (In LKR)");
									int b = 2;
									{
										while (RS1.next()) {
											row = sheet.createRow(b);
											row.createCell((short) 0).setCellValue(RS1.getString(1));
											row.createCell((short) 1).setCellValue(RS1.getString(2));
											row.createCell((short) 2).setCellValue(RS1.getString(3));
											row.createCell((short) 3).setCellValue(RS1.getString(4));
											b++;
											// out.println("hi");
										}
										workbook.write(fileOut);
										fileOut.close();
										//out.println("Your excel file has been generated");           

									}
								} catch (Exception ex) {

								}
					%>

					<%
						if ((request.getParameter("mail") != null)) {
									String str = "helloworld";
									con1.close();
									SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com", "keyway12");
									SendGrid.Email email = new SendGrid.Email();
									//email.addAttachment("Report.pdf", new File("/home/abhinav/workspace/99ARHEMAS/WebContent/PDF/Report.pdf"));
									//email.addAttachment("Abhi.xls", new File("/home/abhinav/workspace/Admin/WebContent/PDF/Abhi.xls"));
									email.addAttachment("Report.pdf", new File("PDF/Report.pdf"));
									email.addTo(mailid);
									email.setFrom("no-reply@99Retail.com");
									email.setFromName("99 Retail Solutions Pvt Ltd");
									email.setSubject("Reports");
									email.setHtml(
											"<html><body><table<tr><td>Dear ,</td></tr><br><tr><td></td> </tr><br><tr> <td>Regards,</td></tr><br><tr><td></td></tr></table></body><html>");
									String content = "Please find the attachment";
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

								if ((request.getParameter("mailXls") != null)) {

									String str = "helloworld";
									con1.close();
									SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com", "keyway12");
									SendGrid.Email email = new SendGrid.Email();
									//email.addAttachment("Report.pdf", new File("/home/abhinav/workspace/Admin/WebContent/PDF/Report.pdf"));
									//email.addAttachment("Abhi.xls", new File("/home/abhinav/workspace/99ARHEMAS/WebContent/PDF/Abhi.xls"));
									email.addAttachment("Report.xls", new File("PDF/Report.xls"));
									email.addTo(mailid);
									email.setFrom("no-reply@99Retail.com");
									email.setFromName("99 Retail Solutions Pvt Ltd");
									email.setSubject("Reports");
									email.setHtml(
											"<html><body><table<tr><td>Dear ,</td></tr><br><tr><td></td> </tr><br><tr> <td>Regards,</td></tr><br><tr><td></td></tr></table></body><html>");
									String content = "Please find the attachment";
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

							} catch (Exception e) {
								out.println(e);
							}

						}
					%>
					<center>
						<input name="mail" type="submit" id="exportButton"
							value="Email As PDF"> <input name="mailXls" type="submit"
							id="exportButton" value="Email As XLS">
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

								<center>
									<button>
										<a href="#" onClick="history.go(-1);return true;">Back</a>
									</button>
								</center>
							</td>
						</tr>
					</table>
					<%--
<%@ include file="Footer.html" %>
 --%>
					</form>
</body>
</html>
