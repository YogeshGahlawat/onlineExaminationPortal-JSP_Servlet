<!-- jsp file for student enrollment -->

<%@ page import = "java.sql.*, java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>STUDENT ENROLLMENT | EXAMINATION</title>
    <link rel="stylesheet" href="./css/enroll.css">
    <script src="./js/script.js"></script>
</head>
<body>

    <%
        if( session.getAttribute("id")!=null && session.getAttribute("password")!=null){
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

        <!-- enroll for exam -->
        <div class="enroll">
            <div class="exam">
                <h2>enroll for exam</h2>
                <form action="enrollStudent" id="container" method="POST">
                    <div class="input-field">
                        <label for="">Select exam to enroll</label>
                        <div class="input">
                            <select name="examCode" id="" required>
                                <option value="NONE" selected>NONE</option>
                                <%
                                    try{

                                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                                        PreparedStatement psmt = conn.prepareStatement("select * from exam where status = ?");
                                        psmt.setString(1, "SUCCESS");
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
                    <button type="submit"><i class="fas fa-plus"></i>enroll</button>
                </form>
            </div>
        </div>

    <%
    } else{
        session.invalidate();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setDateHeader("Expires", 0);
        response.sendRedirect("userLogin.html");
        out.println("<h3 style='text-align: center; text-transform: uppercase; color:red;'>session expired! Please login again!</h3>");
    }
    %>
    
</body>
</html>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">