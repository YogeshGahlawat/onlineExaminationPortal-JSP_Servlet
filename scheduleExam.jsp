<%@ page import = "java.sql.*, java.io.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Online Examination Portal using Java">
    <title>SCHEDULE EXAM | EXAMINATION</title>
    <link rel="stylesheet" href="./css/scheduleExam.css">
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

        <!-- add question section -->
        <div class="addQuestion">
            <div class="exam">
                <h2>schedule your Exam</h2>
                <form action="scheduleExam" id="container" method="POST">
                    <div class="input-field">
                        <label for="">Select exam</label>
                        <div class="input">
                            <select name="examCode" id="" required>
                                <option value="" selected>NONE</option>
                                <%
                                    try{

                                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                                        PreparedStatement psmt = conn.prepareStatement("select * from exam");
                                        ResultSet rs = psmt.executeQuery();
                                        while(rs.next()){
                                            String examCode = rs.getString("examCode");
                                %>
                                            <option value=<%=examCode%> ><%=examCode%></option>
                                <%
                                            }
                                    } catch(Exception e){
                                        request.getRequestDispatcher("adminPage.jsp").include(request, response);
                                %>
                                        <h3>session expired! Please relogin again</h3>
                                <%
                                }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="input-field">
                        <label for="">exam date</label>
                        <div class="input">
                            <input type="date" name="startDate" id="" placeholder="exam start date" required>
                        </div>
                    </div>

                    <div class="input-field">
                        <label for="">exam start time</label>
                        <div class="input">
                            <input type="time" name="startTime" id="" placeholder="exam start time" required>
                        </div>
                    </div>

                    <div class="input-field">
                        <label for="">exam end time</label>
                        <div class="input">
                            <input type="time" name="endTime" id="" placeholder="exam end time" required>
                        </div>
                    </div>

                    <button type="submit">schedule Exam</button>
                </form>
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