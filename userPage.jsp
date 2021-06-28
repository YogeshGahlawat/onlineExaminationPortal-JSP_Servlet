<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="refresh" content="60">
    <meta name="description" content="onlineExaminationPortal in Java">
    <title>ADMIN PAGE | EXAMINATION</title>
    <link rel="stylesheet" href="./css/userPage.css">
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
                <a href="#"><i class="fas fa-plus"></i>enroll exam</a>
                <a href="#"><i class="fas fa-calendar-alt"></i>exam date</a>
                <a href="#"><i class="fas fa-play"></i>start exam</a>
                <a href="#"><i class="fas fa-sign-out-alt"></i>log out</a>
            </div>
        </nav>
        <div class="menu" id="menu">
            <div id="clsoebtn" onclick="hideMenu()">&times;</div>
            <div class="desktop-menu">
                <a href="userPage.jsp"><i class="fas fa-home"></i>Dashboard</a>
                <a href="userProfile.jsp"><i class="fas fa-user-tie"></i>profile</a>
                <a href="#"><i class="fas fa-plus"></i>enroll exam</a>
                <a href="#"><i class="fas fa-calendar-alt"></i>exam date</a>
                <a href="#"><i class="fas fa-play"></i>start exam</a>
                <a href="#"><i class="fas fa-sign-out-alt"></i>log out</a>
            </div>
        </div>

        <!-- user profile section -->
        <div class="user">
            <div class="welcome">
                <h2>welcome back, Mr.<%=session.getAttribute("name")%></h2>
            </div>    
        </div>
    <%
    } else{
        session.invalidate();
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.sendRedirect("userLogin.html");
        out.println("<h3 style='text-align: center; text-transform: uppercase; color:red;'>session expired! Please login again!</h3>");
    }
    %>

</body>
</html>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">