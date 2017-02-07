<%@page import="java.text.DecimalFormat"%>
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
            <title>Hemas Sales Daily Detail</title>
        </head>
        <body>
            <form name="stridpage" ID="" method="POST">
                <%@ include file="Header.html" %>
                <%!  String mailid; %>
                <%

                    String usrid = (String) session.getAttribute("usnm");
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

                <%
                    String perdaysalevalue;
                    String totalbill;
                    String averagesale;
                    String Sale_date = (String) session.getAttribute("pm");
                    //out.println(Sale_date);
                    String EStid = (String) session.getAttribute("abc");
                    String V_Strnm = (String) session.getAttribute("efg");
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
                    <!--                    <div style="text-align: center">
                                            <div style="color: Indigo;"><h2><u><b>Welcome Hemas</u></b></h2></div> 
                                            <div style="color: Indigo;"><h3><u><b><% out.println("Overall Store Distribution "); %></u></b></h3></div>
                                    </div>-->
                </table>
                <%
                    if ((EStid != null)) {

                        try {
                            Class.forName("com.ibm.db2.jcc.DB2Driver");
                            Connection conn = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                            Statement stm = conn.createStatement();
                            ResultSet RS1 = stm.executeQuery("select thirdset.thirdstoreid,thirdset.thirdstorename,COALESCE(thirdset.Totalsalestillnow,0),COALESCE( secondset.MonthlySales,0),COALESCE(secondset.MonthlyBillNos,0),COALESCE(round((secondset.monthlysales/secondset.monthlybillnos),2),0) as monthlyavg from (select retail_store.store_id as firststoreid, retail_store.Str_nm as storename,sum(retail_str_sales_master.Grand_total) as DailySales, count(retail_str_sales_master.tri_id) as TodayBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id  and retail_str_sales_master.Sale_date LIKE CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm ) as firstset full outer join (select retail_store.store_id as secstoreid,retail_store.Str_nm as secondstorename,sum(retail_str_sales_master.Grand_total) as MonthlySales, count(retail_str_sales_master.tri_id) as MonthlyBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id and retail_str_sales_master.Sale_date Between '2017-01-01' and '2017-01-31' group by retail_store.Store_id,retail_store.Str_nm) as secondset on firstset.firststoreid = secondSet.secstoreid full outer join (select retail_store.store_id  as thirdstoreid,retail_store.Str_nm as thirdstorename, sum(retail_str_sales_master.Grand_total) as Totalsalestillnow,count(retail_str_sales_master.tri_id) as  TotalBillsTillNow from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id  and retail_str_sales_master.Sale_date between '2016-10-01' and CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm) as thirdset on thirdset.thirdstoreid = secondset.secstoreid ");
                            int V_Count = 0;
                            double V_Sum = 0;
                            float V_Sum_Mon = 0;
                            double a = 0;
                            double s = 0;
                            int n;
                            String V_Sum_Array[] = new String[10000];
                            String V_Sum_Mon_Array[] = new String[10000];
                            ArrayList<String> l = new ArrayList<String>();
                            ArrayList<String> storename = new ArrayList<String>();
                            while (RS1.next()) {
                                V_Sum_Array[V_Count] = RS1.getString(3);
                                l.add(RS1.getString(3));
                                storename.add(RS1.getString(2));
                                V_Sum_Mon_Array[V_Count] = RS1.getString(5);
                                V_Count++;

                            }
                            DecimalFormat df = new DecimalFormat("#,##.#######");
                            df.setMaximumFractionDigits(2);
                            for (int m = 0; m < l.size(); m++) {
                                V_Sum = V_Sum + Double.parseDouble(V_Sum_Array[m]);
                            }


                %>
                <script type="text/javascript">
                    window.onload = function a() {
                        var chart1 = new CanvasJS.Chart("chartContainer",
                                {
                                    title: {
                                        text: "Overall Store Distribution ",
                                        fontFamily: "arial",
                                        fontColor: "BLACK",
                                        fontStyle: "NORMAL",
                                        fontSize: 35,
                                    },
                                    animationEnabled: false,
                                    legend: {
                                        verticalAlign: "left",
                                        fontSize: 20,
                                        fontFamily: "Helvetica"
                                    },
                                    theme: "theme2",
                                    data: [
                                        {
                                            type: "pie",
                                            indexLabelFontFamily: "Garamond",
                                            indexLabelFontSize: 20,
                                            indexLabel: "{m}",
                                            indexLabelPlacement: "outside",
                                            radius: "70%",
                                            startAngle: 90,
                                            showInLegend: true,
                                            toolTipContent: "Total sale(In LKR):{y1}  <br> </br>Share  :  {y}%  ",
                                            legendText: "Store Name : {m}",
                                            dataPoints: [
                    <%                    ResultSet r2 = stm.executeQuery("select thirdset.thirdstoreid,thirdset.thirdstorename,COALESCE(thirdset.Totalsalestillnow,0),COALESCE( secondset.MonthlySales,0),COALESCE(secondset.MonthlyBillNos,0),COALESCE(round((secondset.monthlysales/secondset.monthlybillnos),2),0) as monthlyavg from (select retail_store.store_id as firststoreid, retail_store.Str_nm as storename,sum(retail_str_sales_master.Grand_total) as DailySales, count(retail_str_sales_master.tri_id) as TodayBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id  and retail_str_sales_master.Sale_date LIKE CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm ) as firstset full outer join (select retail_store.store_id as secstoreid,retail_store.Str_nm as secondstorename,sum(retail_str_sales_master.Grand_total) as MonthlySales, count(retail_str_sales_master.tri_id) as MonthlyBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id and retail_str_sales_master.Sale_date Between '2017-01-01' and '2017-01-31' group by retail_store.Store_id,retail_store.Str_nm) as secondset on firstset.firststoreid = secondSet.secstoreid full outer join (select retail_store.store_id  as thirdstoreid,retail_store.Str_nm as thirdstorename, sum(retail_str_sales_master.Grand_total) as Totalsalestillnow,count(retail_str_sales_master.tri_id) as  TotalBillsTillNow from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id  and retail_str_sales_master.Sale_date between '2016-10-01' and CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm) as thirdset on thirdset.thirdstoreid = secondset.secstoreid ");
                        for (n = 0; n < l.size(); n++) {
                            a = (Double.parseDouble(l.get(n)) / (V_Sum)) * 100;
                            s = Math.round(a * 100.0) / 100.0;
    //                        storename.get(n));
    //                            out.println(l.get(n));

                    %>
                                                {y: <%=s%>, y1: <%=l.get(n)%>, m: "<%=(storename.get(n))%>  ", indexLabelFontColor: "orange", indexLabelOrientation: "vertical"},
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
                    <div id="chartContainer" style="height: 700px; width: 70%;"></div>
            </center>




            <%! public static JFreeChart generatePieChart(String storeid) {
                    DefaultPieDataset dataSet = new DefaultPieDataset();
                    //JFreeChart chart = null;
                    try {
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        Connection conn = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = conn.createStatement();
                        ResultSet rs = stm.executeQuery("select extract(year from retail_str_sales_detail.sale_date),(select (round(sum(retail_str_sales_detail.total),2)) from retail_str_sales_detail,retail_dstr_prod  where retail_str_sales_detail.store_id='" + storeid + "' and retail_dstr_prod.prod_id=retail_str_sales_detail.prod_id ),round(sum(retail_str_sales_detail.total),2) from retail_str_sales_detail where retail_str_sales_detail.store_id='" + storeid + "' group by extract(year from retail_str_sales_detail.sale_date) order by 1,2 desc");
                        while (rs.next()) {
                            // dataSet.setValue("Year", Integer.parseInt(rs.getString(1)));
                            dataSet.setValue("Hemas Sales(In LKR)", Float.parseFloat(rs.getString(2)));
                            dataSet.setValue("Total Sales(In LKR)", Float.parseFloat(rs.getString(3)));
                            dataSet.setValue("Market Share(In %)", ((Float.parseFloat(rs.getString(2)) * 100) / Float.parseFloat(rs.getString(3))));
                        }
                    } catch (Exception e) {
                        System.out.println(e);
                    }
                    JFreeChart chart = ChartFactory.createPieChart(
                            "Year-2016 (Hemas Market Share)", dataSet, true, true, false);
                    return chart;
                }

            %>


            <%!    public static void writeChartToPDF(JFreeChart chart, int width, int height, String fileName) {
                    PdfWriter writer = null;
                    Document document = new Document();
                    width = 594;
                    height = 810;
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
                        if (request.getParameter("mail") != null) {
                            String str = "helloworld";
                            conn.close();
                            SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com", "keyway12");
                            SendGrid.Email email = new SendGrid.Email();
                            //email.addAttachment("Report.pdf", new File("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/PDF/Report.pdf"));
                            email.addAttachment("Report.pdf", new File("PDF/Report.pdf"));
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
                        }

                    } catch (Exception e) {
                        out.println(e);
                    }

                }%>
            <center>
                <input  name="mail"  type="submit" id="exportButton" value="Email As PDF"> 
            </center>
            <div id="pageNavPosition" style="padding-top: 20px" align="center">
                </div>
                <script type="text/javascript">
                var pager = new Pager('tablepaging', 05);
                pager.init();
                pager.showPageNav('pager', 'pageNavPosition');
                pager.showPage(1);
                </script>
                <br>

                <table align="center" bgcolor="#BDB76B">
                    <tr bgcolor="#BDB76B">
                        <td bgcolor="#BDB76B">

                            <center><button><a href="#" onClick="history.go(-1);
                                    return true;">Back</a></button></center>
                        </td>
                    </tr>
                </table>

            </form>

        </body>
    </html>
