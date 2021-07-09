<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="onlineExaminationPortal in Java">
    <title>EXAM BANK | EXAMINATION</title>
    <link rel="stylesheet" href="./css/questionBank.css">
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

        <!-- new user profile section -->
        <div class="exam">
            <div class="links">
                <a href="listExam.jsp"><i class="fas fa-list"></i>list all exams</a>
                <form action="searchExam.jsp" method="POST">
                    <div class="input" title="EXAMCODE FOR SEARCHING">
                        <input type="text" name="searchExam" id="searchExam" placeholder="search exam" required>
                        <button type="submit"><i class="fas fa-search"></i>Search</button>
                    </div>
                </form>
            </div>
            <div class="paper">
                <h2>ADD question paper</h2>
                <form action="addExam" method="POST">
                    <div class="input">
                        <label for="">exam code</label>
                        <div class="input-fields">
                            <input type="text" name="code" id="code" placeholder="exam code" required>
                        </div>
                    </div>
                    <div class="input">
                        <label for="">exam title</label>
                        <div class="input-fields">
                            <input type="text" name="title" id="title" placeholder="exam title" required>
                        </div>
                    </div>
                    <div class="input">
                        <label for="">No of questions</label>
                        <div class="input-fields">
                            <input type="number" name="number" id="number" placeholder="no of questions" required>
                        </div>
                    </div>
                    <button type="submit"><i class="fas fa-plus"></i>create exam</button>
                </form>
            </div>    
        </div>
    <%
    } else{
        session.invalidate();
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.sendRedirect("adminLogin.html");
        out.println("<h3 style='text-align: center; text-transform: uppercase; color:red;'>session expired! Please login again!</h3>");
    }
    %>
    
</body>
</html>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">