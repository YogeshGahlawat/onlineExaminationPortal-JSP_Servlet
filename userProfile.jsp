<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="onlineExaminationPortal in Java">
    <title>ADMIN PROFILE | EXAMINATION</title>
    <link rel="stylesheet" href="./css/userProfile.css">
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

        <!-- user profile section -->
        <div class="user">
            <div class="profile">
                <h2>profile panal</h2>
                <form action="updateUserProfile" method="POST">
                    <div class="input">
                        <label for="">id</label>
                        <div class="input-fields">
                            <i class="fas fa-user"></i>
                            <input type="number" name="id" id="id" value=<%=session.getAttribute("id")%> disabled>
                        </div>
                    </div>
                    <div class="input">
                        <label for="">name</label>
                        <div class="input-fields">
                            <i class="fas fa-user"></i>
                            <input type="text" name="name" id="name" value=<%=session.getAttribute("name")%> disabled>
                        </div>
                    </div>
                    <div class="input">
                        <label for="">email</label>
                        <div class="input-fields">
                            <i class="fas fa-envelope"></i>
                            <input type="email" name="email" id="email" value=<%=session.getAttribute("email")%> onfocusout="validateMail()" required disabled>
                        </div>
                    </div>
                    <div class="input">
                        <label for="">password</label>
                        <div class="input-fields">
                            <i class="fas fa-lock"></i>
                            <input type="text" name="password" id="password" value=<%=session.getAttribute("password")%> onfocusout="validatePassworde()" required disabled>
                        </div>
                    </div>
                    <button type="button" id="btn1" onclick="enable()" ><i class="fas fa-edit"></i>edit</button>
                    <button type="submit" id="btn2" disabled><i class="fas fa-upload"></i>update</button>
                    <button type="button" id="btn3" onclick="disable()" disabled><i class="fas fa-window-close"></i>cancel</button>
                </form>
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
