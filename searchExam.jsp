<!-- jsp file for listing exam -->

<%@ page import = "java.sql.*, java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EXAM SEARCH RESULT | EXAMINATION</title>
    <link rel="stylesheet" href="./css/searchExam.css">
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
                <a href="adminPage.jsp"><i class="fas fa-home"></i>Dashboard</a>
                <a href="adminProfile.jsp"><i class="fas fa-user-tie"></i>profile</a>
                <a href="addRecord.jsp"><i class="fas fa-plus"></i>add record</a>
                <a href="deleteRecord.jsp"><i class="fas fa-trash"></i>delete record</a>
                <a href="searchRecord.jsp"><i class="fas fa-search"></i>search record</a>
                <a href="questionBank.jsp"><i class="fas fa-folder"></i>question bank</a>
                <a href="setupExam.jsp"><i class="fas fa-file"></i>exam paper</a>
                <a href="scheduleExam.jsp"><i class="fas fa-calendar-alt"></i>conduct exam</a>
                <a href="adminLogout"><i class="fas fa-sign-out-alt"></i>log out</a>
            </div>
        </nav>
        <div class="menu" id="menu">
            <div id="clsoebtn" onclick="hideMenu()">&times;</div>
            <div class="desktop-menu">
                <a href="adminPage.jsp"><i class="fas fa-home"></i>Dashboard</a>
                <a href="adminProfile.jsp"><i class="fas fa-user-tie"></i>profile</a>
                <a href="addRecord.jsp"><i class="fas fa-plus"></i>add record</a>
                <a href="deleteRecord.jsp"><i class="fas fa-trash"></i>delete record</a>
                <a href="searchRecord.jsp"><i class="fas fa-search"></i>search record</a>
                <a href="questionBank.jsp"><i class="fas fa-folder"></i>question bank</a>
                <a href="setupExam.jsp"><i class="fas fa-file"></i>exam paper</a>
                <a href="scheduleExam.jsp"><i class="fas fa-calendar-alt"></i>conduct exam</a>
                <a href="adminLogout"><i class="fas fa-sign-out-alt"></i>log out</a>
            </div>
        </div>

        <!-- generating exam List -->
        <div class="examList">
            <div class="list">
                <h3>exam description</h3>
                <table>
                    <tr>
                        <th>s. no.</th>
                        <th>examcode</th>
                        <th>exam title</th>
                        <th>exam date</th>
                        <th>exma start time</th>
                        <th>exam end time</th>
                        <th>number of questions</th>
                        <th>status</th>
                        <!-- <th>operation</th> -->
                    </tr>
                    <%

                        String examCode = request.getParameter("searchExam");
                        int count = 1;
                        try{
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                            PreparedStatement psmt = conn.prepareStatement("select exam.examCode , examTitle, examDate, startTime, endTime, numberOfQuestions, status from exam, schedule where exam.examCode = ? and schedule.examCode = ?");
                            psmt.setString(1, examCode);
                            psmt.setString(2, examCode);
                            ResultSet rs = psmt.executeQuery(); 
                            while(rs.next()){
                                %>
                                <tr>
                                    <td><%=count%></td>
                                    <td><%=rs.getString("examCode")%></td>
                                    <td><%=rs.getString("examTitle")%></td>
                                    <td><%=rs.getDate("examDate")%></td>
                                    <td><%=rs.getTime("startTime")%></td>
                                    <td><%=rs.getTime("endTime")%></td>
                                    <td><%=rs.getString("numberOfQuestions")%></td>
                                    <td><%=rs.getString("status")%></td>
                                    <!-- <td>
                                        <a href="" title="EXAM PREVIEW"><i class="fas fa-play"></i></a>
                                        <a href="" title="EDIT EXAM"><i class="fas fa-edit"></i></a>
                                        <a href="" title="DELETE EXAM"><i class="fas fa-trash"></i></a>
                                    </td> -->
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
            response.sendRedirect("adminLogin.html");
        }
    %>

</body>
</html>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">