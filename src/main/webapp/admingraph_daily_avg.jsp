<%@page import="org.jfree.chart.labels.StandardPieSectionLabelGenerator"%>
<%@page import="org.jfree.chart.plot.PiePlot"%>
<%@page import="com.sendgrid.SendGridException"%>
<%@page import="java.io.File"%>
<%@page import="com.sendgrid.SendGrid"%>
<%@page import="java.awt.geom.Rectangle2D"%>
<%@page import="com.itextpdf.text.pdf.DefaultFontMapper"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="com.itextpdf.text.pdf.PdfTemplate"%>
<%@page import="com.itextpdf.text.pdf.PdfContentByte"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.data.general.DefaultPieDataset"%>
<%@page import="org.jfree.chart.JFreeChart"%>
<%@ page language="java" import="java.sql.*" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
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
<title>Hemas Sales Daily Detail</title>
</head>
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
   String perdaysalevalue ;
String totalbill;
String averagesale;
String Sale_date=(String)session.getAttribute("pm");
//out.println(Sale_date);
    String EStid=(String)session.getAttribute("abc");
    String V_Strnm = (String)session.getAttribute("efg");
  //out.println(EStid);
	

               //out.println(r2.getString(3));
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
<li><a href="Admin_salesreportdaily.jsp" >Daily Sales Report </a></li>
<li><a href="Admin_datewisebill.jsp">Sales Bill Report </a>
</li>
<li><a href="#">Hemas Sales Report</a>
<ul id="report">
<li><a href="Admin_hemassalesdaily.jsp">Day Wise Product</a></li>
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
</tr>
</table>
 <div style="text-align: center">
<!--<div style="color: Indigo;"><h2><u><b>Welcome Hemas</u></b></h2></div> -->
<div style="color: Indigo;"><h3><u><b><% out.println(V_Strnm); %></u></b></h3></div>
</div>
</table>
 
<%
if(EStid !=null)
      {
      String selectedmonth = request.getParameter("month");
      //  out.println(selectedmonth);
String selectedyear = request.getParameter("year");
 try{
     Class.forName("com.ibm.db2.jcc.DB2Driver");
	Connection conn = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
        Statement stm = conn.createStatement();
      ResultSet r2= stm.executeQuery("select day(sale_date),round(sum(total),2),count(TRI_ID) from retail_str_sales_detail where store_id='"+EStid+"' AND  month(sale_date)=extract(month from  current date ) group by sale_date");
	
%>
<script type="text/javascript">
window.onload = function a() {
	var chart1 = new CanvasJS.Chart("chartContainer",
	{
title:{
			text: "Daily Average Sales ",
			 fontFamily: "arial",
                         fontColor: "BLACK",
                         fontStyle: "NORMAL",
			

		},
               axisX:{
                            title: "Dates of Current Month",
				interval: 1,
				gridThickness: 0,
				labelFontSize: 15,
				labelFontStyle: "normal",
				labelFontWeight: "normal",
				labelFontFamily: "ARIAL",
                                labelFontColour:"black",
                                labelAngle: -30

			},
			axisY:{
                          
				title: "Average Sales",
				interlacedColor: "rgba(1,77,101,.2)",
				gridColor: "rgba(1,77,101,.1)"

			},
data: [
		{        
			type: "column", 
                        axisXType: "secondary",
			indexLabelFontFamily: "arial",       
			indexLabelFontSize: 20,
			//indexLabel: "(Date:{m})      (TotalSales:{y4})   (AverageSales:{y}) ",
                        indexLabelPlacement: "outside",  
                        showInLegend: true,
			toolTipContent: "Total Sale(In LKR)  :   {y4} <br> </br>Sales/Day :  {y1} <br> </br> Average Sale (In LKR)  :  {y}  ",
			legendText: "{indexLabel}",
			dataPoints: [
			<%
                            
while (r2.next())
{ 
  Float avgsales=((Float.parseFloat(r2.getString(2)))/(Float.parseFloat(r2.getString(3))));
double avg= Math.round(avgsales * 100.0)/100.0;
// /out.println(s);
String avgsale = Double.toString(avg);

                                %>
                        
{
    y4: <%=(r2.getString(2)) %> , y1: <%=(r2.getString(3)) %> ,  y:<%=avg%>, label : "<%=(r2.getString(1)) %> " , indexLabelPlacement: "inside" },
   	<% }
 %>         
		] //closing datapoints
                }] //closing data.
	});
chart1.render();

} //closing the loop of function() starts
</script>
<script type="text/javascript" src="canvasjs.min.js"></script> 
<center>
<div id="chartContainer" style="height: 300px; width: 35%;"></div>
</center>




<%! public static JFreeChart generatePieChart(String storeid) {
     DefaultPieDataset dataSet = new DefaultPieDataset(); 
 //JFreeChart chart = null;
   try
       {
           Class.forName("com.ibm.db2.jcc.DB2Driver");
        	Connection conn = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
		Statement stm =   conn.createStatement();
                ResultSet rs= stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2),count(retail_str_sales_detail.TRI_ID) from retail_str_sales_detail where retail_str_sales_detail.store_id='"+storeid+"' AND month(sale_date)=extract(month from  current date) group by retail_str_sales_detail.sale_date");
	while (rs.next())

                                { 
               //dataSet.setValue("Month", Integer.parseInt(rs.getString(1)));
                dataSet.setValue("Total Sales", Float.parseFloat(rs.getString(2)));
                dataSet.setValue("Sales/Day", Integer.parseInt(rs.getString(3)));
                dataSet.setValue("Average", (Float.parseFloat(rs.getString(2))/Integer.parseInt(rs.getString(3))));
                       } 
} catch(Exception e)
{
System.out.println(e);
}
                JFreeChart chart =  ChartFactory.createPieChart(
				"December(Average Sales)", dataSet, true, true, false);


return chart;
	}
%>


<%!
    public static void writeChartToPDF(JFreeChart chart, int width, int height, String fileName) {
		PdfWriter writer = null;
		Document document = new Document();
 width = 500;
height = 800;
		try {
//writer = PdfWriter.getInstance(document, new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/PDF/Report.pdf"));
writer = PdfWriter.getInstance(document, new FileOutputStream("PDF/Report.pdf"));			
document.open();
			PdfContentByte contentByte = writer.getDirectContent();
			PdfTemplate template = contentByte.createTemplate(width, height);
			Graphics2D graphics2d = template.createGraphics(width, height,
					new DefaultFontMapper());
			Rectangle2D rectangle2d = new Rectangle2D.Double(0, 0, width,
					height);

			chart.draw(graphics2d, rectangle2d);
			
			graphics2d.dispose();
			contentByte.addTemplate(template, 0, 0);
//document.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
document.close();		
	}

%>
<%
    writeChartToPDF(generatePieChart(EStid), 500, 400, "C://piechart.pdf");
    %>
    <%
if(request.getParameter("mail")!=null)
{
String str= "helloworld";   
conn.close();
SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com","keyway12");
SendGrid.Email email = new SendGrid.Email();
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
 
//email.setText("This is Demo Mail created using Java to show demo of Bluemix SendGrid service to 99 Retail Please ignore<br/><br/>To,<br/><br/>Store Register<br/><br/>Mumbai India <br/><br/>Dear Sir/Madam<br/><br/>Regards<br/>Nilu<br/><br/>99 Retails.<br/><br/>qneha.singh@gmail.com");
try {
SendGrid.Response response1 = sendgrid.send(email);

//out.println(response1.getMessage() + "Hi Kunal How r u ?" );
} catch (SendGridException e) {
// TODO Auto-generated catch block
e.printStackTrace();
}
}

} catch(Exception e)
{
out.println(e);
}	
	
}%>
<center>
<input  name="mail"  type="submit" id="exportButton" value="Email As PDF"> 
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

</form>
          
</body>
</html>
