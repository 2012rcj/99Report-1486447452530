<%@page import="java.text.NumberFormat"%>
<%@page import="com.itextpdf.text.Chunk"%>
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
<%@ page import="org.openstack4j.api.OSClient"%>
<%@ page import="org.openstack4j.openstack.OSFactory"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftAccount"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.openstack4j.model.common.Identifier"%>
<%@ page import="org.openstack4j.api.storage.ObjectStorageService"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftObject"%>
<%@ page import="org.openstack4j.api.storage.ObjectStorageService"%>
<%@ page import="org.openstack4j.model.common.DLPayload"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftContainer"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftObject"%>
<%@ page import="org.openstack4j.model.common.Payloads"%>
<%@ page import="javax.servlet.http.Part"%>
<%@ page import="org.openstack4j.model.common.Payload"%>
<%@ page import="java.util.*"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftContainer"%>
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
        <script>
            function cal() {

                if (document.getElementById("datepicker1")) {

                    var startDate = document.getElementById("datepicker").value;
                    var endDate = document.getElementById("datepicker1").value;

                    if ((Date.parse(startDate) > Date.parse(endDate))) {
                        alert("End date should be greater than Start date");
                        document.getElementById("datepicker1").value = "";
                    }
                }
            }
        </script>
        <script>
            function cal2() {

                if (document.getElementById("datepicker")) {

                    var startDate = document.getElementById("datepicker").value;
                    var endDate = document.getElementById("datepicker1").value;
                    var current_date = new Date();
                    var selDate = Date.parse(dateText);
                    if (selDate > current_date) {
                        alert("Please select Today date or less than today date.");
                        document.getElementById("datepicker").value = "";
                    }
                }
            }

        </script>

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <link rel="stylesheet" href="runnable.css" />
        <script>
            $(document).ready(
                    function () {
                        $('#datepicker1').datepicker({
                            dateFormat: 'yy-mm-dd',
                            yearRange: "2016:2020",
                            onSelect: function (dateText, inst) {
                                $(this).val(dateText);
                                $(this).change();

                                var current_date = new Date();

                                var selDate = Date.parse(dateText);

                                if (selDate > current_date) {

                                    alert("Please select Today date or less than today date.");
                                    $('#datepicker1').val('');
                                    $(inst).datepicker('show');
                                }
                            }
                        });
                    }

            );
        </script>


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

                    this.showRecords = function (from, to) {

                        var rows = document.getElementById(tableName).rows;

                        // i starts from 1 to skip table header row

                        for (var i = 1; i < rows.length; i++) {

                            if (i < from || i > to)
                                rows[i].style.display = 'none';

                            else
                                rows[i].style.display = '';

                        }

                    }

                    this.showPage = function (pageNumber) {

                        if (!this.inited) {

                            alert("not inited");

                            return;

                        }

                        var oldPageAnchor = document.getElementById('pg' + this.currentPage);

                        oldPageAnchor.className = 'pg-normal';

                        this.currentPage = pageNumber;

                        var newPageAnchor = document.getElementById('pg' + this.currentPage);

                        newPageAnchor.className = 'pg-selected';

                        var from = (pageNumber - 1) * itemsPerPage + 1;

                        var to = from + itemsPerPage - 1;

                        this.showRecords(from, to);

                    }

                    this.prev = function () {

                        if (this.currentPage > 1)
                            this.showPage(this.currentPage - 1);

                    }

                    this.next = function () {

                        if (this.currentPage < this.pages) {

                            this.showPage(this.currentPage + 1);

                        }

                    }

                    this.init = function () {

                        var rows = document.getElementById(tableName).rows;

                        var records = (rows.length - 1);

                        this.pages = Math.ceil(records / itemsPerPage);

                        this.inited = true;

                    }

                    this.showPageNav = function (pagerName, positionId) {

                        if (!this.inited) {

                            alert("not inited");

                            return;

                        }

                        var element = document.getElementById(positionId);

                        var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal">PREV </span> ';

                        for (var page = 1; page <= this.pages; page++)
                            pagerHtml += '<style id="pg' + page + '" class="pg-normal;"></style> ';

                        pagerHtml += '<span onclick="' + pagerName + '.next();" class="pg-normal"> NEXT</span>';

                        element.innerHTML = pagerHtml;

                    }

                }
            </script>
            <script type="text/javascript" src="JS/DisableBack.js"></script>
            <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
            <title>Admin Sales Daily </title>

        </head>
        <head> <meta http-equiv="refresh" content="60"></head>
        <body>
            <form action="Admin_salesreportdaily.jsp" method="post" id="myForm">
                <%@ include file="Header.html" %>
                <%
                    String EStid = (String) session.getAttribute("abc");
                    String V_Strnm = (String) session.getAttribute("efg");
                    //out.println(EStid);
                    int count = 0;

                %>
                <%!  String mailid; %>
                <%    String usrid = (String) session.getAttribute("usnm");
                    String psword = (String) session.getAttribute("pswd");

                    try {
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = con1.createStatement();
                        ResultSet RS = stm.executeQuery("select EMAIL from retail_registration where Name='" + usrid + "' and Password='" + psword + "'");
                        while (RS.next()) {
                            mailid = (RS.getString(1));

                        }
                    } catch (Exception e) {
                        out.println(e);
                    } %>
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
                                    <li><a href="Admin_inventorydaywise.jsp">Inventory
                                            Reports</a></li>
                                    <li><a href="therapeutic.jsp">Therapeutic Classes</a></li>
                                </ul></li>
                        </ul>
                        <div style="text-align: center">
                            <!-- <div style="color: Indigo;"><h2><u><b>Welcome Hemas</u></b></h2></div> -->
                            <div style="color: Indigo;">
                            <h3>
                                <u>
                                    <%
                                        out.println(V_Strnm);
                                    %>
                                </u>
                            </h3>
                        </div>
                    </div>
                </table>

                <%!
                    String first;
                    String second;
                %>

                <%
                    try {
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        //create the connection database
                        Connection con12 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stmn = con12.createStatement();
                        ResultSet RSM = stmn.executeQuery("select distinct(first_day(retail_str_sales_detail.sale_date)),current_date from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' AND  retail_str_sales_detail.SALE_DATE Between ( current_date + 1 days - day(current_date) days )and(select current_date from sysibm.sysdummy1) group by retail_str_sales_detail.sale_date ");
                        while (RSM.next()) {
                            first = RSM.getString(1);
                            second = RSM.getString(2);
                            //out.println(RSM.getString(1));
                            //out.println(RSM.getString(2));

                        }
                    } catch (Exception e) {
                        out.println(e);
                    }

                %>
                <% String startdate = (String) request.getParameter("dateofexpnd");
                    String enddate = (String) request.getParameter("dateofexpnd1");

                    if (request.getParameter("sub") != null) {
                %>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging" width="40%">
                    <tr class="even">
                        <td>
                            <input type="radio" name="month" value="today" onclick="this.form.submit()" />Today's
                            <input type="radio" name="month" value="current" onclick="this.form.submit()"  />Current Month
                            <input type="radio" name="month" value="previous" onclick="this.form.submit()"  />Previous Month
                            <input type="radio" name="month" value="past" onclick="this.form.submit()"  />Past 60 Days
                            <input type="radio" name="month" value="custom"  onclick="this.form.submit()" checked/>Custom Reports
                        </td>
                    </tr>
                </table>
                <%
                    if (request.getParameter("sub") != null) {
                %>
                <center>
                    <tr class="even">
                        <td>Start Date:<input width="50px" type = "text" id = "datepicker" value="<%out.println(startdate); %>" placeholder="select any date" required="required" name="dateofexpnd" onchange="cal()" />
                            End Date :<input width="50px" type ="text" id = "datepicker1" value="<%out.println(enddate); %>" placeholder="select any date" required="required" name="dateofexpnd1" onchange="cal()" />
                            <input type="submit" value="Submit" name="sub" id="abc">

                        </td>
                    </tr>
                </center>
                <% } else {%>

                <center>
                    <tr class="even">
                        <td>Start Date:<input width="50px" type = "date" id = "datepicker" value="<%out.println(first); %>" placeholder="select any date" required="required" name="dateofexpnd" onchange="cal()" />
                            End Date :<input width="50px" type ="date" id = "datepicker1" value="<%out.println(second); %>" placeholder="select any date" required="required" name="dateofexpnd1" onchange="cal()" />
                            <input type="submit" value="Submit" name="sub" id="abc">


                        </td>
                    </tr>
                </center>
                <%String date1 = request.getParameter("dateofexpnd");
                    String date2 = request.getParameter("dateofexpnd1");
                    // out.println(date1);
                    // out.println(date2);
                %>

                <%
                    try {
                        //out.println(second);
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        //create the connection database
                        Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = con1.createStatement();
                        ResultSet RS = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where  retail_str_sales_detail.store_id='" + EStid + "' and  retail_str_sales_detail.sale_date between '" + date1 + "' and '" + date2 + "'  group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                        //ResultSet rs2=stm.executeQuery("Select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2)from retail_dstr_prod,retail_str_sales_detail where retail_str_sales_detail.store_id='"+EStid+"' and  retail_dstr_prod.prod_id=retail_str_sales_detail.prod_id and  SALE_DATE Between ( current_date + 1 days - day(current_date) days )and(select current_date from sysibm.sysdummy1) order by sale_date desc");
                %>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                    <tr class="even">
                        <th >Sales Date</th>
                        <th >Total Sales Value &nbsp&nbsp(In LKR)</th>

                    </tr>
                    <%
                        Document d = new Document(PageSize.A4);
                        //OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                        OutputStream file = new FileOutputStream("PDF/Report.pdf");
                        PdfWriter.getInstance(d, file);
                        d.open();
                        //Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/logo.jpg");
                        Image image1 = Image.getInstance("src/logo.jpg");
                        image1.setAlignment(Element.ALIGN_LEFT);
                        d.add(image1);
                        Paragraph text = new Paragraph(V_Strnm);
                        text.setIndentationRight(20);
                        text.setAlignment(Element.ALIGN_CENTER);

                        text.setSpacingAfter(30f);
                        d.add(new Paragraph(text));
                        float[] columnWidths = new float[]{40f, 40f};
                        PdfPTable table = new PdfPTable(columnWidths);
                        table.setWidths(columnWidths);
                        PdfPCell cell = new PdfPCell(text);
                        table.addCell("                    Sale Date");
                        table.addCell("          Total Sales Value (In LKR)");

                        while (RS.next()) {%>
                    <tr class="odd">

                        <td align="left"><a href="Admin_salesdaywise.jsp?Value1='<%=(RS.getString(1))%>' "style="color:#00FFF" style="text-decoration: none" ><%=(RS.getString(1))%></a></td>
                            <td align="right"><fmt:formatNumber type="number"  minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(2))%>"/></td>
                        </tr>
                        <%
                                String abc = (String) request.getParameter("value");
                                //out.println(abc);
                                cell = new PdfPCell(new Phrase(RS.getString(1)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase((RS.getString(2))));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                ++count;
                            }
                            d.add(table);
                            try {
                                String a[] = new String[1000];//declaration and instantiation
                                int i = 0;
                                float sum = 0;
                                Class.forName("com.ibm.db2.jcc.DB2Driver");
                                Connection con2 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                                Statement stmt = con2.createStatement();
                                ResultSet RS2 = stmt.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  retail_str_sales_detail.sale_date between '" + date1 + "' and '" + date2 + "'  group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                                while (RS2.next()) {
                                    a[i] = RS2.getString(2);
                                    i++;
                                }
                                for (int b = 0; b < i; b++) {
                                    //out.println(a[b]);
                                    sum = sum + Float.parseFloat(a[b]);
                                }
                                String strAmount = String.valueOf(sum);
                                //out.println(strAmount);
                                Paragraph p = new Paragraph();
                                p.add(new Chunk("Total Sales Value (In LKR) :-      "));
                                p.add(new Chunk(strAmount));
                                PdfPCell cell1 = new PdfPCell();

                                cell1.addElement(p);
                                p.setAlignment(Element.ALIGN_CENTER);
                                d.add(p);%>
                        <center><div style="color: Indigo;"><h3><u><b><% out.println("Data from");
                            out.println(date1);
                            out.println(" To");
                            out.println(date2); %></u></b></h3></div>
                    </center>
                                    <center><div style="color: darkred;"><h3><b><% out.println("Total Value(In LKR)-");
                        out.println(strAmount);  %></b></h3></div>
                    </center>
                    <%
                        } catch (Exception e) {
                            out.println(e);
                        }
                        d.close();
                        //out.println("Pdf created successfully..");
                    %>
                </table>

                <%if (count < 1) {%>
                <br>
                <table align="center" ><tr align="center" > <td>&nbsp&nbsp No Data available for Selected Store :&nbsp <%=(V_Strnm)%> &nbsp &nbsp </td><tr>  </table>  
                <br>
                <% }
                        //FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                        FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");

                        ResultSet RS1 = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  retail_str_sales_detail.sale_date between '" + date1 + "' and '" + date2 + "'  group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                        HSSFWorkbook workbook = new HSSFWorkbook();
                        HSSFSheet sheet = workbook.createSheet("New Sheet");
                        HSSFRow row = sheet.createRow((short) 0);
                        HSSFFont font = workbook.createFont();
                        font.setColor(HSSFFont.COLOR_RED);
                        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                        HSSFCell cell1 = row.createCell((short) 0);
                        cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell1.setCellValue("Sale Date");
                        HSSFCell cell2 = row.createCell((short) 1);
                        cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                        cell2.setCellValue("Total Sales Value (In LKR)");
                        int b = 1;

                        while (RS1.next()) {
                            row = sheet.createRow(b);
                            row.createCell((short) 0).setCellValue(RS1.getString(1));
                            row.createCell((short) 1).setCellValue(RS1.getString(2));
                            b++;
                            // out.println("hi");
                        }
                        workbook.write(fileOut);
                        fileOut.close();
                        //out.println("Your excel file has been generated");           

                        con1.close();
                    } catch (Exception e) {
                        out.println(e);
                    }


                %>
                <center>
                    <input  name="mail"  type="submit"  value="Email As PDF"> 
                    <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                </center>
                <div id="pageNavPosition" style="padding-top: 20px" align="center">
                    </div>

                    <br>
                    <%    }
                        String date1 = request.getParameter("dateofexpnd");
                        String date2 = request.getParameter("dateofexpnd1");
                    %>

                    <%
                        try {
                            Class.forName("com.ibm.db2.jcc.DB2Driver");
                            Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                            Statement stm = con1.createStatement();
                            ResultSet RS = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  retail_str_sales_detail.sale_date between '" + date1 + "' and '" + date2 + "'  group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                    %>
                    <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                    <tr class="even">
                        <th >Sales Date</th>
                        <th >Total Sales Value &nbsp&nbsp(In LKR)</th>
                    </tr>
                    <%
                        Document d = new Document(PageSize.A4);
                        //OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                        OutputStream file = new FileOutputStream("PDF/Report.pdf");
                        PdfWriter.getInstance(d, file);
                        d.open();
                        //Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/logo.jpg");
                        Image image1 = Image.getInstance("src/logo.jpg");
                        image1.setAlignment(Element.ALIGN_LEFT);
                        d.add(image1);
                        Paragraph text = new Paragraph(V_Strnm);
                        text.setIndentationRight(20);
                        text.setAlignment(Element.ALIGN_CENTER);

                        text.setSpacingAfter(30f);
                        d.add(new Paragraph(text));
                        float[] columnWidths = new float[]{40f, 40f};
                        PdfPTable table = new PdfPTable(columnWidths);
                        table.setWidths(columnWidths);
                        PdfPCell cell = new PdfPCell(text);
                        table.addCell("                    Sale Date");
                        table.addCell("          Total Sales Value (In LKR)");

                        while (RS.next()) {%>
                    <tr class="odd">

                        <td align="left"><a href="Admin_salesdaywise.jsp?Value1='<%=(RS.getString(1))%>' "style="color:#00FFF" style="text-decoration: none" ><%=(RS.getString(1))%></a></td>
                            <td align="right"><fmt:formatNumber type="number"  minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(2))%>"/></td>
                        </tr>
                        <%
                                String abc = (String) request.getParameter("value");
                                cell = new PdfPCell(new Phrase(RS.getString(1)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase((RS.getString(2))));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                ++count;
                            }
                            d.add(table);
                            try {
                                String a[] = new String[1000];//declaration and instantiation
                                int i = 0;
                                float sum = 0;
                                Class.forName("com.ibm.db2.jcc.DB2Driver");
                                Connection con2 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                                Statement stmt = con2.createStatement();
                                ResultSet RS2 = stmt.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  retail_str_sales_detail.sale_date between '" + date1 + "' and '" + date2 + "'  group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                                while (RS2.next()) {
                                    a[i] = RS2.getString(2);
                                    i++;
                                }
                                for (int b = 0; b < i; b++) {
                                    //out.println(a[b]);
                                    sum = sum + Float.parseFloat(a[b]);
                                }
                                String strAmount = String.valueOf(sum);
                                //out.println(strAmount);
                                Paragraph p = new Paragraph();
                                p.add(new Chunk("Total Sales Value (In LKR) :-      "));
                                p.add(new Chunk(strAmount));
                                PdfPCell cell1 = new PdfPCell();

                                cell1.addElement(p);
                                p.setAlignment(Element.ALIGN_CENTER);
                                d.add(p);%>

                        <center><div style="color: Indigo;"><h3><u><b><% out.println("Data from");
                            out.println(date1);
                            out.println(" To");
                            out.println(date2); %></u></b></h3></div>
                    </center>
                                    <center><div style="color: darkred;"><h3><b><% out.println("Total Value(In LKR)-");
                        out.println(strAmount);  %></b></h3></div>
                    </center>
                    <%
                        } catch (Exception e) {
                            out.println(e);
                        }
                        d.close();
                        //out.println("Pdf created successfully..");
                    %>
                </table>
                <%if (count < 1) {%>
                <br>
                <table align="center" ><tr align="center" > <td>&nbsp&nbsp No Data available for Selected Store :&nbsp <%=(V_Strnm)%> &nbsp &nbsp </td><tr>  </table>  
                <br>
                <% }
//FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                        FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");

                        ResultSet RS1 = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "'  and  retail_str_sales_detail.sale_date between '" + date1 + "' and '" + date2 + "'  group by sale_date order by sale_date desc");
                        HSSFWorkbook workbook = new HSSFWorkbook();
                        HSSFSheet sheet = workbook.createSheet("New Sheet");
                        HSSFRow row = sheet.createRow((short) 0);
                        HSSFFont font = workbook.createFont();
                        font.setColor(HSSFFont.COLOR_RED);
                        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                        HSSFCell cell1 = row.createCell((short) 0);
                        cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell1.setCellValue("Sale Date");
                        HSSFCell cell2 = row.createCell((short) 1);
                        cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                        cell2.setCellValue("Total Sales Value (In LKR)");
                        int b = 1;

                        while (RS1.next()) {
                            row = sheet.createRow(b);
                            row.createCell((short) 0).setCellValue(RS1.getString(1));
                            row.createCell((short) 1).setCellValue(RS1.getString(2));
                            b++;
                            // out.println("hi");
                        }
                        workbook.write(fileOut);
                        fileOut.close();
                        //out.println("Your excel file has been generated");           

                        con1.close();
                    } catch (Exception e) {
                        out.println(e);
                    }


                %>
                <center>
                    <input  name="mail"  type="submit"  value="Email As PDF"> 
                    <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                </center>
                <div id="pageNavPosition" style="padding-top: 20px" align="center">
                    </div>
                    <table align="center" bgcolor="#BDB76B">
                        <tr bgcolor="#BDB76B">
                            <td bgcolor="#BDB76B">
                                <center><button><a href="#" onClick="history.go(-1);
                                        return true;">Back</a></button></center>
                    </table>
                    <br>
                    <% } else if ((request.getParameter("month") != null)) {
                        if (request.getParameter("month").equals("today")) {
                    %>

                    <table style="white-space: nowrap;" border="1" align="center" id="tablepaging" width="40%">
                    <tr class="even">
                        <td>
                            <input type="radio" name="month" value="today" onclick="this.form.submit()" checked/>Today's
                            <input type="radio" name="month" value="current" onclick="this.form.submit()"  />Current Month
                            <input type="radio" name="month" value="previous" onclick="this.form.submit()"  />Previous Month
                            <input type="radio" name="month" value="past" onclick="this.form.submit()"  />Past 60 Days
                            <input type="radio" name="month" value="custom"  onclick="this.form.submit()" />Custom Reports
                        </td>
                    </tr>
                </table>



                <%
                    try {
                        //out.println(second);
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        //create the connection database
                        Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = con1.createStatement();
                        ResultSet RS = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "'  and  retail_str_sales_detail.SALE_DATE like current_date group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                %>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                    <tr class="even">
                        <th >Sales Date</th>
                        <th >Total Sales Value &nbsp&nbsp(In LKR)</th>

                    </tr>
                    <%
                        Document d = new Document(PageSize.A4);
                        //OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                        OutputStream file = new FileOutputStream("PDF/Report.pdf");
                        PdfWriter.getInstance(d, file);
                        d.open();
                        //Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/logo.jpg");
                        Image image1 = Image.getInstance("src/logo.jpg");
                        image1.setAlignment(Element.ALIGN_LEFT);
                        d.add(image1);
                        Paragraph text = new Paragraph(V_Strnm);
                        text.setIndentationRight(20);
                        text.setAlignment(Element.ALIGN_CENTER);

                        text.setSpacingAfter(30f);
                        d.add(new Paragraph(text));
                        float[] columnWidths = new float[]{40f, 40f};
                        PdfPTable table = new PdfPTable(columnWidths);
                        table.setWidths(columnWidths);
                        PdfPCell cell = new PdfPCell(text);
                        table.addCell("                    Sale Date");
                        table.addCell("          Total Sales Value (In LKR)");

                        while (RS.next()) {%>
                    <tr class="odd">

                        <td align="left"><a href="Admin_salesdaywise.jsp?Value1='<%=(RS.getString(1))%>' "style="color:#00FFF" style="text-decoration: none" ><%=(RS.getString(1))%></a></td>
                            <td align="right"><fmt:formatNumber type="number"  minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(2))%>"/></td>
                        </tr>
                        <%
                                String abc = (String) request.getParameter("value");
                                //out.println(abc);
                                cell = new PdfPCell(new Phrase(RS.getString(1)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase((RS.getString(2))));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                ++count;
                            }
                            d.add(table);
                            try {
                                String a[] = new String[1000];//declaration and instantiation
                                int i = 0;
                                float sum = 0;
                                Class.forName("com.ibm.db2.jcc.DB2Driver");
                                Connection con2 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                                Statement stmt = con2.createStatement();
                                ResultSet RS2 = stmt.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "'  and  retail_str_sales_detail.SALE_DATE like current_date group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                                while (RS2.next()) {
                                    a[i] = RS2.getString(2);
                                    i++;
                                }
                                for (int b = 0; b < i; b++) {
                                    //out.println(a[b]);
                                    sum = sum + Float.parseFloat(a[b]);
                                }
                                String strAmount = String.valueOf(sum);
                                //out.println(strAmount);
                                Paragraph p = new Paragraph();
                                p.add(new Chunk("Total Sales Value (In LKR) :-      "));
                                p.add(new Chunk(strAmount));
                                PdfPCell cell1 = new PdfPCell();

                                cell1.addElement(p);
                                p.setAlignment(Element.ALIGN_CENTER);
                                d.add(p);%>

                        <center><div style="color: Indigo;"><h3><u><b><% out.println("Daily Report");  %></u></b></h3></div>
                    </center>

                    <%
                        } catch (Exception e) {
                            out.println(e);
                        }
                        d.close();
                        //out.println("Pdf created successfully..");
                    %>
                </table>
                <%if (count < 1) {%>
                <br>
                <table align="center" ><tr align="center" > <td>&nbsp&nbsp No Data available for Selected Store :&nbsp <%=(V_Strnm)%> &nbsp &nbsp </td><tr>  </table>  
                <br>
                <% } %>
                <%
                        try {
                            // FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                            FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");

                            ResultSet RS1 = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "'  and  retail_str_sales_detail.SALE_DATE like current_date group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                            HSSFWorkbook workbook = new HSSFWorkbook();
                            HSSFSheet sheet = workbook.createSheet("New Sheet");
                            HSSFRow row = sheet.createRow((short) 0);
                            HSSFFont font = workbook.createFont();
                            font.setColor(HSSFFont.COLOR_RED);
                            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                            HSSFCell cell1 = row.createCell((short) 0);
                            cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                            cell1.setCellValue("Sale Date");
                            HSSFCell cell2 = row.createCell((short) 1);
                            cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                            cell2.setCellValue("Total Sales Value (In LKR)");
                            int b = 1;

                            while (RS1.next()) {
                                row = sheet.createRow(b);
                                row.createCell((short) 0).setCellValue(RS1.getString(1));
                                row.createCell((short) 1).setCellValue(RS1.getString(2));
                                b++;
                                // out.println("hi");
                            }
                            workbook.write(fileOut);
                            fileOut.close();
                            //out.println("Your excel file has been generated");           
                        } catch (Exception e) {
                            out.println(e);

                        }

                        con1.close();
                    } catch (Exception e) {
                        out.println(e);
                    }


                %>
                <center>
                    <input  name="mail"  type="submit"  value="Email As PDF"> 
                    <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                </center>
                <div id="pageNavPosition" style="padding-top: 20px" align="center">
                    </div>


                    <% } else if (request.getParameter("month").equals("current")) {
                    %>
                    <table style="white-space: nowrap;" border="1" align="center" id="tablepaging" width="40%">
                    <tr class="even">
                        <td>
                            <input type="radio" name="month" value="today" onclick="this.form.submit()" />Today's
                            <input type="radio" name="month" value="current" onclick="this.form.submit()" checked />Current Month
                            <input type="radio" name="month" value="previous" onclick="this.form.submit()"  />Previous Month
                            <input type="radio" name="month" value="past" onclick="this.form.submit()"  />Past 60 Days
                            <input type="radio" name="month" value="custom"  onclick="this.form.submit()" />Custom Reports
                        </td>
                    </tr>
                </table>

                <%
                    try {
                        //out.println(second);
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        //create the connection database
                        Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = con1.createStatement();
                        ResultSet RS = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "'  and  retail_str_sales_detail.SALE_DATE Between ( current_date + 1 days - day(current_date) days )and(select current_date from sysibm.sysdummy1) group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                %>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                    <tr class="even">
                        <th >Sales Date</th>
                        <th >Total Sales Value &nbsp&nbsp(In LKR)</th>

                    </tr>
                    <%
                        Document d = new Document(PageSize.A4);
                        //OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                        OutputStream file = new FileOutputStream("PDF/Report.pdf");
                        PdfWriter.getInstance(d, file);
                        d.open();
                        //Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/logo.jpg");
                        Image image1 = Image.getInstance("src/logo.jpg");
                        image1.setAlignment(Element.ALIGN_LEFT);
                        d.add(image1);
                        Paragraph text = new Paragraph(V_Strnm);
                        text.setIndentationRight(20);
                        text.setAlignment(Element.ALIGN_CENTER);

                        text.setSpacingAfter(30f);
                        d.add(new Paragraph(text));
                        float[] columnWidths = new float[]{40f, 40f};
                        PdfPTable table = new PdfPTable(columnWidths);
                        table.setWidths(columnWidths);
                        PdfPCell cell = new PdfPCell(text);
                        table.addCell("                    Sale Date");
                        table.addCell("          Total Sales Value (In LKR)");

                        while (RS.next()) {%>
                    <tr class="odd">

                        <td align="left" ><a href="Admin_salesdaywise.jsp?Value1='<%=(RS.getString(1))%>' "style="color:#00FFF" style="text-decoration: none" ><%=(RS.getString(1))%></a></td>
                            <td align="right"><fmt:formatNumber type="number"  minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(2))%>"/></td>
                        </tr>
                        <%
                                String abc = (String) request.getParameter("value");
                                //out.println(abc);
                                cell = new PdfPCell(new Phrase(RS.getString(1)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase((RS.getString(2))));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                ++count;
                            }
                            d.add(table);
                            try {
                                String a[] = new String[1000];//declaration and instantiation
                                int i = 0;
                                float sum = 0;
                                Class.forName("com.ibm.db2.jcc.DB2Driver");
                                Connection con2 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                                Statement stmt = con2.createStatement();
                                ResultSet RS2 = stmt.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  SALE_DATE Between ( current_date + 1 days - day(current_date) days )and(select current_date from sysibm.sysdummy1) group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                                while (RS2.next()) {
                                    a[i] = RS2.getString(2);
                                    i++;
                                }
                                for (int b = 0; b < i; b++) {
                                    sum = sum + Float.parseFloat(a[b]);
                                }
                                String strAmount = String.valueOf(sum);
                                //out.println(strAmount);
                                Paragraph p = new Paragraph();
                                p.add(new Chunk("Total Sales Value (In LKR) :-      "));
                                p.add(new Chunk(strAmount));
                                PdfPCell cell1 = new PdfPCell();

                                cell1.addElement(p);
                                p.setAlignment(Element.ALIGN_CENTER);
                                d.add(p);%>
                        <center><div style="color: Indigo;"><h3><u><b><% out.println("Monthly Report");  %></u></b></h3></div>
                    </center>
                                    <center><div style="color: darkred;"><h3><b><% out.println("Total Value(In LKR)-");
                        out.println(strAmount);  %></b></h3></div>
                    </center>
                    <%
                        } catch (Exception e) {
                            out.println(e);
                        }
                        d.close();
                        //out.println("Pdf created successfully..");
                    %>
                </table>
                <%if (count < 1) {%>
                <br>
                <table align="center" ><tr align="center" > <td>&nbsp&nbsp No Data available for Selected Store :&nbsp <%=(V_Strnm)%> &nbsp &nbsp </td><tr>  </table>  
                <br>
                <% } %>
                <%
//        FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                        FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");

                        ResultSet RS1 = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  retail_str_sales_detail.SALE_DATE Between ( current_date + 1 days - day(current_date) days )and(select current_date from sysibm.sysdummy1) group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                        HSSFWorkbook workbook = new HSSFWorkbook();
                        HSSFSheet sheet = workbook.createSheet("New Sheet");
                        HSSFRow row = sheet.createRow((short) 0);
                        HSSFFont font = workbook.createFont();
                        font.setColor(HSSFFont.COLOR_RED);
                        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                        HSSFCell cell1 = row.createCell((short) 0);
                        cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell1.setCellValue("Sale Date");
                        HSSFCell cell2 = row.createCell((short) 1);
                        cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                        cell2.setCellValue("Total Sales Value (In LKR)");
                        int b = 1;

                        while (RS1.next()) {
                            row = sheet.createRow(b);
                            row.createCell((short) 0).setCellValue(RS1.getString(1));
                            row.createCell((short) 1).setCellValue(RS1.getString(2));
                            b++;
                            // out.println("hi");
                        }
                        workbook.write(fileOut);
                        fileOut.close();
                        //out.println("Your excel file has been generated");           

                        con1.close();
                    } catch (Exception e) {
                        out.println(e);
                    }
                %>
                <center>
                    <input  name="mail"  type="submit"  value="Email As PDF"> 
                    <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                </center>
                <div id="pageNavPosition" style="padding-top: 20px" align="center">
                    </div>

                    <% } else if (request.getParameter("month").equals("previous")) {
                    %>
                    <table style="white-space: nowrap;" border="1" align="center" id="tablepaging" width="40%">
                    <tr class="even">
                        <td>
                            <input type="radio" name="month" value="today" onclick="this.form.submit()" />Today's
                            <input type="radio" name="month" value="current" onclick="this.form.submit()"  />Current Month
                            <input type="radio" name="month" value="previous" onclick="this.form.submit()" checked />Previous Month
                            <input type="radio" name="month" value="past" onclick="this.form.submit()"  />Past 60 Days
                            <input type="radio" name="month" value="custom"  onclick="this.form.submit()" />Custom Reports
                        </td>
                    </tr>
                </table>

                <%
                    try {

                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        //create the connection database
                        Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = con1.createStatement();
                        ResultSet RS = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  SALE_DATE Between ( current_date + 1 days - day(current_date) days - 1 MONTH )and ( current date - DAY(CURRENT_DATE ))   group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                %>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                    <tr class="even">
                        <th >Sales Date</th>
                        <th >Total Sales Value &nbsp&nbsp(In LKR)</th>

                    </tr>
                    <%
                        Document d = new Document(PageSize.A4);
                        //OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                        OutputStream file = new FileOutputStream("PDF/Report.pdf");
                        PdfWriter.getInstance(d, file);
                        d.open();
                        //Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/logo.jpg");
                        Image image1 = Image.getInstance("src/logo.jpg");
                        image1.setAlignment(Element.ALIGN_LEFT);
                        d.add(image1);
                        Paragraph text = new Paragraph(V_Strnm);
                        text.setIndentationRight(20);
                        text.setAlignment(Element.ALIGN_CENTER);

                        text.setSpacingAfter(30f);
                        d.add(new Paragraph(text));
                        float[] columnWidths = new float[]{40f, 40f};
                        PdfPTable table = new PdfPTable(columnWidths);
                        table.setWidths(columnWidths);
                        PdfPCell cell = new PdfPCell(text);
                        table.addCell("                    Sale Date");
                        table.addCell("          Total Sales Value (In LKR)");

                        while (RS.next()) {%>
                    <tr class="odd">

                        <td align="left"><a href="Admin_salesdaywise.jsp?Value1='<%=(RS.getString(1))%>' "style="color:#00FFF" style="text-decoration: none" ><%=(RS.getString(1))%></a></td>
                            <td align="right"><fmt:formatNumber type="number"  minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(2))%>"/></td>
                        </tr>
                        <%
                                String abc = (String) request.getParameter("value");
                                //out.println(abc);
                                cell = new PdfPCell(new Phrase(RS.getString(1)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase((RS.getString(2))));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                ++count;
                            }
                            d.add(table);
                            try {
                                String a[] = new String[1000];//declaration and instantiation
                                int i = 0;
                                float sum = 0;
                                Class.forName("com.ibm.db2.jcc.DB2Driver");
                                Connection con2 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                                Statement stmt = con2.createStatement();
                                ResultSet RS2 = stmt.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  retail_str_sales_detail.SALE_DATE Between ( current_date + 1 days - day(current_date) days - 1 MONTH ) and ( current date - DAY(CURRENT_DATE ))   group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                                while (RS2.next()) {
                                    a[i] = RS2.getString(2);
                                    i++;
                                }
                                for (int b = 0; b < i; b++) {
                                    sum = sum + Float.parseFloat(a[b]);
                                }
                                String strAmount = String.valueOf(sum);
                                //out.println(strAmount);
                                Paragraph p = new Paragraph();
                                p.add(new Chunk("Total Sales Value (In LKR) :-      "));
                                p.add(new Chunk(strAmount));
                                PdfPCell cell1 = new PdfPCell();
                                cell1.addElement(p);
                                p.setAlignment(Element.ALIGN_CENTER);
                                d.add(p);
                        %>
                        <center><div style="color: Indigo;"><h3><u><b><% out.println("Data of January Month");  %></u></b></h3></div>
                    </center>
                                    <center><div style="color: darkred;"><h3><b><% out.println("Total Value(In LKR)-");
                        out.println(strAmount);  %></b></h3></div>
                    </center>
                    <%
                        } catch (Exception e) {
                            out.println(e);
                        }
                        d.close();
                        //out.println("Pdf created successfully..");
                    %>
                </table>
                <%if (count < 1) {%>
                <br>
                <table align="center" ><tr align="center" > <td>&nbsp&nbsp No Data available for Selected Store :&nbsp <%=(V_Strnm)%> &nbsp &nbsp </td><tr>  </table>  
                <br>
                <% }%>
                <%
                        //FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                        FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");

                        ResultSet RS1 = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "'  and  retail_str_sales_detail.SALE_DATE Between ( current_date + 1 days - day(current_date) days - 1 MONTH )and(current date + 1 month - day(current date + 1 month) days - 1 month)  group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                        HSSFWorkbook workbook = new HSSFWorkbook();
                        HSSFSheet sheet = workbook.createSheet("New Sheet");
                        HSSFRow row = sheet.createRow((short) 0);
                        HSSFFont font = workbook.createFont();
                        font.setColor(HSSFFont.COLOR_RED);
                        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                        HSSFCell cell1 = row.createCell((short) 0);
                        cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell1.setCellValue("Sale Date");
                        HSSFCell cell2 = row.createCell((short) 1);
                        cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                        cell2.setCellValue("Total Sales Value (In LKR)");
                        int b = 1;

                        while (RS1.next()) {
                            row = sheet.createRow(b);
                            row.createCell((short) 0).setCellValue(RS1.getString(1));
                            row.createCell((short) 1).setCellValue(RS1.getString(2));
                            b++;
                            // out.println("hi");
                        }
                        workbook.write(fileOut);
                        fileOut.close();
                        //out.println("Your excel file has been generated");           

                        con1.close();
                    } catch (Exception e) {
                        out.println(e);
                    }
                %>
                <center>
                    <input  name="mail"  type="submit"  value="Email As PDF"> 
                    <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                </center>
                <div id="pageNavPosition" style="padding-top: 20px" align="center">
                    </div>

                    <% } else if (request.getParameter("month").equals("past")) {
                    %>
                    <table style="white-space: nowrap;" border="1" align="center" id="tablepaging" width="40%">
                    <tr class="even">
                        <td>
                            <input type="radio" name="month" value="today" onclick="this.form.submit()"/>Today's
                            <input type="radio" name="month" value="current" onclick="this.form.submit()"  />Current Month
                            <input type="radio" name="month" value="previous" onclick="this.form.submit()"  />Previous Month
                            <input type="radio" name="month" value="past" onclick="this.form.submit()" checked />Past 60 Days
                            <input type="radio" name="month" value="custom"  onclick="this.form.submit()" />Custom Reports
                        </td>
                    </tr>
                </table>

                <%
                    try {
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        //create the connection database
                        Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = con1.createStatement();
                        ResultSet RS = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "'  and  retail_str_sales_detail.SALE_DATE Between   (  current_date  - 60 DAYS  )  and(current_date ) group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                %>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                    <tr class="even">
                        <th >Sales Date</th>
                        <th >Total Sales Value &nbsp&nbsp(In LKR)</th>

                    </tr>
                    <%
                        Document d = new Document(PageSize.A4);
                        //OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                        OutputStream file = new FileOutputStream("PDF/Report.pdf");
                        PdfWriter.getInstance(d, file);
                        d.open();
                        //Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/logo.jpg");
                        Image image1 = Image.getInstance("src/logo.jpg");
                        image1.setAlignment(Element.ALIGN_LEFT);
                        d.add(image1);
                        Paragraph text = new Paragraph(V_Strnm);
                        text.setIndentationRight(20);
                        text.setAlignment(Element.ALIGN_CENTER);

                        text.setSpacingAfter(30f);
                        d.add(new Paragraph(text));
                        float[] columnWidths = new float[]{40f, 40f};
                        PdfPTable table = new PdfPTable(columnWidths);
                        table.setWidths(columnWidths);
                        PdfPCell cell = new PdfPCell(text);
                        table.addCell("                    Sale Date");
                        table.addCell("          Total Sales Value (In LKR)");

                        while (RS.next()) {%>
                    <tr class="odd">

                        <td align="left"><a href="Admin_salesdaywise.jsp?Value1='<%=(RS.getString(1))%>' "style="color:#00FFF" style="text-decoration: none" ><%=(RS.getString(1))%></a></td>
                            <td align="right"><fmt:formatNumber type="number"  minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(2))%>"/></td>
                        </tr>
                        <%
                                String abc = (String) request.getParameter("value");
                                //out.println(abc);
                                cell = new PdfPCell(new Phrase(RS.getString(1)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase((RS.getString(2))));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                ++count;
                            }
                            d.add(table);

                            try {
                                String a[] = new String[1000];//declaration and instantiation
                                int i = 0;
                                float sum = 0;
                                Class.forName("com.ibm.db2.jcc.DB2Driver");
                                Connection con2 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                                Statement stmt = con2.createStatement();
                                ResultSet RS2 = stmt.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  SALE_DATE Between   (  current_date  - 60 DAYS  )  and(current_date ) group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                                while (RS2.next()) {
                                    a[i] = RS2.getString(2);
                                    i++;
                                }
                                for (int b = 0; b < i; b++) {
                                    //out.println(a[b]);
                                    sum = sum + Float.parseFloat(a[b]);
                                }
                                String strAmount = String.valueOf(sum);
                                //out.println(strAmount);
                                Paragraph p = new Paragraph();
                                p.add(new Chunk("Total Sales Value (In LKR) :-      "));
                                p.add(new Chunk(strAmount));
                                PdfPCell cell1 = new PdfPCell();

                                cell1.addElement(p);
                                p.setAlignment(Element.ALIGN_CENTER);
                                d.add(p);
                        %>

                        <center><div style="color: Indigo;"><h3><u><b><% out.println("Data for Past 60 Days");  %></u></b></h3></div>
                    </center>
                                    <center><div style="color: darkred;"><h3><b><% out.println("Total Value(In LKR)-");
                        out.println(strAmount);  %></b></h3></div>
                    </center>
                    <%
                        } catch (Exception e) {
                            out.println(e);
                        }

                        d.close();
                        //out.println("Pdf created successfully..");
                    %>
                </table>
                <%if (count < 1) {%>
                <br>
                <table align="center" ><tr align="center" > <td>&nbsp&nbsp No Data available for Selected Store :&nbsp <%=(V_Strnm)%> &nbsp &nbsp </td><tr>  </table>  
                <br>
                <% }%>
                <%
                        //  FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                        FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");

                        ResultSet RS1 = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "'  and  retail_str_sales_detail.SALE_DATE Between   (  current_date  - 60 DAYS  )  and(current_date ) group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                        HSSFWorkbook workbook = new HSSFWorkbook();
                        HSSFSheet sheet = workbook.createSheet("New Sheet");
                        HSSFRow row = sheet.createRow((short) 0);
                        HSSFFont font = workbook.createFont();
                        font.setColor(HSSFFont.COLOR_RED);
                        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                        HSSFCell cell1 = row.createCell((short) 0);
                        cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell1.setCellValue("Sale Date");
                        HSSFCell cell2 = row.createCell((short) 1);
                        cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                        cell2.setCellValue("Total Sales Value (In LKR)");
                        int b = 1;

                        while (RS1.next()) {
                            row = sheet.createRow(b);
                            row.createCell((short) 0).setCellValue(RS1.getString(1));
                            row.createCell((short) 1).setCellValue(RS1.getString(2));
                            b++;
                            // out.println("hi");
                        }
                        workbook.write(fileOut);
                        fileOut.close();
                        //out.println("Your excel file has been generated");           

                        con1.close();
                    } catch (Exception e) {
                        out.println(e);
                    }


                %>
                <center>
                    <input  name="mail"  type="submit"  value="Email As PDF"> 
                    <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                </center>
                <div id="pageNavPosition" style="padding-top: 20px" align="center">
                    </div>

                    <% } else if (request.getParameter("month").equals("custom")) {
                    %>

                    <table style="white-space: nowrap;" border="1" align="center" id="tablepaging" width="40%">
                    <tr class="even">
                        <td>
                            <input type="radio" name="month" value="today" onclick="this.form.submit()" />Today's
                            <input type="radio" name="month" value="current" onclick="this.form.submit()"  />Current Month
                            <input type="radio" name="month" value="previous" onclick="this.form.submit()"  />Previous Month
                            <input type="radio" name="month" value="past" onclick="this.form.submit()"  />Past 60 Days
                            <input type="radio" name="month" value="custom"  onclick="this.form.submit()" checked/>Custom Reports
                        </td>
                    </tr>
                </table>
                <%
                %>
                <center>
                    <tr class="even">
                        <td>Start Date:<input width="50px" type = "date" id = "datepicker" value="<%out.println(first); %>" placeholder="select any date" required="required" name="dateofexpnd" onchange="cal()" />
                            End Date :<input width="50px" type ="date" id = "datepicker1" value="<%out.println(second); %>" placeholder="select any date" required="required"  name="dateofexpnd1" onchange="cal()"  />
                            <input type="submit" value="Submit" name="sub" id="abc">

                        </td>
                    </tr>
                </center>
                <%
                } else {
                %>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging" width="40%">
                    <tr class="even">
                        <td>
                            <input type="radio" name="month" value="today" onclick="this.form.submit()" />Today's
                            <input type="radio" name="month" value="current" onclick="this.form.submit()"  />Current Month
                            <input type="radio" name="month" value="previous" onclick="this.form.submit()"  />Previous Month
                            <input type="radio" name="month" value="past" onclick="this.form.submit()"  />Past 60 Days
                            <input type="radio" name="month" value="custom"  onclick="this.form.submit()" />Custom Reports
                        </td>
                    </tr>
                </table>
                <%
                    }
                } else {
                %>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging"  width="40%">
                    <tr class="even">
                        <td>
                            <input type="radio" name="month" value="today" onclick="this.form.submit()" checked />Today's
                            <input type="radio" name="month" value="current" onclick="this.form.submit()"  />Current Month
                            <input type="radio" name="month" value="previous" onclick="this.form.submit()"  />Previous Month
                            <input type="radio" name="month" value="past" onclick="this.form.submit()"  />Past 60 Days
                            <input type="radio" name="month" value="custom"  onclick="this.form.submit()" />Custom Reports
                        </td>
                    </tr>
                </table>

                <%
                    try {
                        //out.println(second);
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        //create the connection database
                        Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = con1.createStatement();
                        ResultSet RS = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  SALE_DATE like current_date group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                %>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                    <tr class="even">
                        <th >Sales Date</th>
                        <th >Total Sales Value &nbsp&nbsp(In LKR)</th>

                    </tr>
                    <%
                        Document d = new Document(PageSize.A4);
                        //OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                        OutputStream file = new FileOutputStream("PDF/Report.pdf");
                        PdfWriter.getInstance(d, file);
                        d.open();
                        //Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/logo.jpg");
                        Image image1 = Image.getInstance("src/logo.jpg");
                        image1.setAlignment(Element.ALIGN_LEFT);
                        d.add(image1);
                        Paragraph text = new Paragraph(V_Strnm);
                        text.setIndentationRight(20);
                        text.setAlignment(Element.ALIGN_CENTER);

                        text.setSpacingAfter(30f);
                        d.add(new Paragraph(text));
                        float[] columnWidths = new float[]{40f, 40f};
                        PdfPTable table = new PdfPTable(columnWidths);
                        table.setWidths(columnWidths);
                        PdfPCell cell = new PdfPCell(text);
                        table.addCell("                    Sale Date");
                        table.addCell("          Total Sales Value (In LKR)");

                        while (RS.next()) {%>
                    <tr class="odd">

                        <td align="left"><a href="Admin_salesdaywise.jsp?Value1='<%=(RS.getString(1))%>' "style="color:#00FFF" style="text-decoration: none" ><%=(RS.getString(1))%></a></td>
                            <td align="right"><fmt:formatNumber type="number"  minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(2))%>"/></td>
                        </tr>
                        <%
                                String abc = (String) request.getParameter("value");
                                //out.println(abc);
                                cell = new PdfPCell(new Phrase(RS.getString(1)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase((RS.getString(2))));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                ++count;
                            }
                            d.add(table);
                            try {
                                String a[] = new String[1000];//declaration and instantiation
                                int i = 0;
                                float sum = 0;
                                Class.forName("com.ibm.db2.jcc.DB2Driver");
                                Connection con2 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                                Statement stmt = con2.createStatement();
                                ResultSet RS2 = stmt.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  retail_str_sales_detail.SALE_DATE like current_date group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                                while (RS2.next()) {
                                    a[i] = RS2.getString(2);
                                    i++;
                                }
                                for (int b = 0; b < i; b++) {
                                    //out.println(a[b]);
                                    sum = sum + Float.parseFloat(a[b]);
                                }
                                String strAmount = String.valueOf(sum);
                                //out.println(strAmount);
                                Paragraph p = new Paragraph();
                                p.add(new Chunk("Total Sales Value (In LKR) :-      "));
                                p.add(new Chunk(strAmount));
                                PdfPCell cell1 = new PdfPCell();

                                cell1.addElement(p);
                                p.setAlignment(Element.ALIGN_CENTER);
                                d.add(p);
                        %>
                        <center><div style="color: Indigo;"><h3><u><b><% out.println("Daily Report");  %></u></b></h3></div>
                    </center>
                    <%
                        } catch (Exception e) {
                            out.println(e);
                        }
                        d.close();
                        //out.println("Pdf created successfully..");
                    %>
                </table>
                <%if (count < 1) {%>
                <br>
                <table align="center" ><tr align="center" > <td>&nbsp&nbsp No Data available for Selected Store :&nbsp <%=(V_Strnm)%> &nbsp &nbsp </td><tr>  </table>  
                <br>
                <% } %>
                <%
                        try {
                            //  FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                            FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");

                            ResultSet RS1 = stm.executeQuery("select retail_str_sales_detail.sale_date,round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + EStid + "' and  retail_str_sales_detail.SALE_DATE like current_date group by retail_str_sales_detail.sale_date order by retail_str_sales_detail.sale_date desc");
                            HSSFWorkbook workbook = new HSSFWorkbook();
                            HSSFSheet sheet = workbook.createSheet("New Sheet");
                            HSSFRow row = sheet.createRow((short) 0);
                            HSSFFont font = workbook.createFont();
                            font.setColor(HSSFFont.COLOR_RED);
                            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                            HSSFCell cell1 = row.createCell((short) 0);
                            cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                            cell1.setCellValue("Sale Date");
                            HSSFCell cell2 = row.createCell((short) 1);
                            cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                            cell2.setCellValue("Total Sales Value (In LKR)");
                            int b = 1;

                            while (RS1.next()) {
                                row = sheet.createRow(b);
                                row.createCell((short) 0).setCellValue(RS1.getString(1));
                                row.createCell((short) 1).setCellValue(RS1.getString(2));
                                b++;
                                // out.println("hi");
                            }
                            workbook.write(fileOut);
                            fileOut.close();
                            //out.println("Your excel file has been generated");           
                        } catch (Exception e) {
                            out.println(e);

                        }

                        con1.close();
                    } catch (Exception e) {
                        out.println(e);
                    }


                %>
                <center>
                    <input  name="mail"  type="submit"  value="Email As PDF"> 
                    <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                </center>
                <div id="pageNavPosition" style="padding-top: 20px" align="center">
                    </div>

                    <table align="center" bgcolor="#BDB76B">
                        <tr bgcolor="#BDB76B">
                            <td bgcolor="#BDB76B">
                                <center><button><a href="#" onClick="history.go(-1);
                                        return true;">Back</a></button></center>
                    </table>
                    <%    }

                        if ((request.getParameter("mail") != null)) {
                    %>

                    <%
                            String str = "helloworld";

                            SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com", "keyway12");
                            SendGrid.Email email = new SendGrid.Email();
                            //email.addAttachment("Report.pdf", new File("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf"));
                            //email.addAttachment("Abhi.xls", new File("/home/abhinav/workspace/Admin/WebContent/PDF/Abhi.xls"));
                            email.addAttachment("Report.pdf", new File("PDF/Report.pdf"));
                            //email.addAttachment("Abhi.xls", new File("PDF/Abhi.xls"));

                            email.addTo(mailid);
                            //email.addTo("tiwarymanis@gmail.com ");
                            email.setFrom("no-reply@99Retail.com");
                            email.setFromName("99 Retail Solutions Pvt Ltd");
                            email.setSubject("Reports");
                            email.setHtml("<html><body><table<tr><td>Dear ,</td></tr><br><tr><td></td> </tr><br><tr> <td>Regards,</td></tr><br><tr><td></td></tr></table></body><html>");
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
                    %>
                    <%
                        if ((request.getParameter("mailXls") != null)) {

                            String str = "helloworld";

                            SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com", "keyway12");
                            SendGrid.Email email = new SendGrid.Email();
                            //email.addAttachment("Report.pdf", new File("/home/abhinav/workspace/Admin/WebContent/PDF/Report.pdf"));
                            //email.addAttachment("Report.xls", new File("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls"));
                            email.addAttachment("Report.xls", new File("PDF/Report.xls"));
                            email.addTo(mailid);
                            email.setFrom("no-reply@99Retail.com");
                            email.setFromName("99 Retail Solutions Pvt Ltd");
                            email.setSubject("Reports");
                            email.setHtml("<html><body><table<tr><td>Dear ,</td></tr><br><tr><td></td> </tr><br><tr> <td>Regards,</td></tr><br><tr><td></td></tr></table></body><html>");
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

                        }%>
                    <script type="text/javascript">
                        var pager = new Pager('tablepaging', 10);
                        pager.init();
                        pager.showPageNav('pager', 'pageNavPosition');
                        pager.showPage(1);
                    </script>
                    <%--
                    <%@ include file="Footer.html" %>
                    --%>
                </form>

            </body>
        </html>	