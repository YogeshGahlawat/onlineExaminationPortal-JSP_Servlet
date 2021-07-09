<!-- jsp file for listing exam -->

<%@ page import = "java.sql.*, java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EXAM LIST | EXAMINATION</title>
    <link rel="stylesheet" href="./css/examDates.css">
    <script src="./js/script.js"></script>
</head>
<body>
    
    <%
        if( session.getAttribute("id") != null && session.getAttribute("password") != null ){
    %>
        
        <!-- Navigation Panal -->
        <nav>
            <div class="mobile-menu" id="mobile-menu" onclick="showMenu()">
                <div id="bar1"></div>
                <div id="bar2"></div>
                <div id="bar3"></div>
            </div>
            <div class="desktop-menu" id="desktop-menu">
                <a href="userPage.jsp"><i class="fas fa-home"></i>Dashboard</a>
                <a href="userProfile.jsp"><i class="fas fa-user-tie"></i>profile</a>
                <a href="enroll.jsp"><i class="fas fa-plus"></i>enroll exam</a>
                <a href="examDates.jsp"><i class="fas fa-calendar-alt"></i>exam date</a>
                <a href="examPage.jsp"><i class="fas fa-play"></i>start exam</a>
                <a href="userLogout"><i class="fas fa-sign-out-alt"></i>log out</a>
            </div>
        </nav>
        <div class="menu" id="menu">
            <div id="clsoebtn" onclick="hideMenu()">&times;</div>
            <div class="desktop-menu">
                <a href="userPage.jsp"><i class="fas fa-home"></i>Dashboard</a>
                <a href="userProfile.jsp"><i class="fas fa-user-tie"></i>profile</a>
                <a href="enroll.jsp"><i class="fas fa-plus"></i>enroll exam</a>
                <a href="examDates.jsp"><i class="fas fa-calendar-alt"></i>exam date</a>
                <a href="examPage.jsp"><i class="fas fa-play"></i>start exam</a>
                <a href="userLogout"><i class="fas fa-sign-out-alt"></i>log out</a>
            </div>
        </div>

        <!-- generating exam List -->
        <div class="examList">
            <div class="list">
                <h3>exam schedule</h3>
                <table>
                    <tr>
                        <th>s. no.</th>
                        <th>exam code</th>
                        <th>exam date</th>
                        <th>exam start time</th>
                        <th>exam end time</th>
                    </tr>
                    <%
                        int count = 1;
                        try{
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                            PreparedStatement psmt = conn.prepareStatement("select schedule.examCode, examDate, startTime , endTime from schedule, enrollment where schedule.examCode = enrollment.examCode and userID = ? group by examCode order by examDate, startTime, endTime asc");
                            psmt.setInt(1, Integer.parseInt(session.getAttribute("id").toString()));
                            ResultSet rs = psmt.executeQuery(); 
                            while(rs.next()){
                                %>
                                <tr>
                                    <td><%=count%></td>
                                    <td><%=rs.getString("examCode")%></td>
                                    <td><%=rs.getDate("examDate")%></td>
                                    <td><%=rs.getTime("startTime")%></td>
                                    <td><%=rs.getTime("endTime")%></td>
                                </tr>
                                <%
                                count+=1;
                            }
                        } catch(Exception e){
                    %>
                        <h3>fetching data from table failed</h3>
                    <%
                        }
                    %>
                </table>
            </div>    
        </div>
        
    <%
        } else{
            session.invalidate();
            response.setHeader("Cache-Control", "no-cache, no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("userLogin.html");
        }
    %>

</body>
</html>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">