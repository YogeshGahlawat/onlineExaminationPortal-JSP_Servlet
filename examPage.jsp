<!-- jsp file for exam instructions with a start button -->

<%@ page import = "java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="onlineExaminationPortal in Java">
    <title>EXAM INSTRUCTIONS | EXAMINATION</title>
    <link rel="stylesheet" href="./css/examPage.css">
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

        <!-- exam Instructions -->
        <div class="exam">
            <div class="instructions">
                <h2>Exam instructions</h2>
                <ol>
                    <li>general instructions</li>
                    <ol>
                        <li>The examination will comprise of Objective type Multiple Choice Questions (MCQs)</li>
                        <li>All questions are compulsory and each carries One mark</li>
                        <li>The total number of questions, duration of examination, willbe different based on thecourse, the detail is available on your screen</li>
                        <li>The Subjects or topics covered in the exam will be as per the Syllabus</li>
                        <li>There will be NO NEGATIVE MARKING for the wrong answers.</li>
                    </ol>
                    <li>Information & instructions</li>
                    <ol>
                        <li>Every student will take the examination on a Laptop/Desktop/Smart Phone</li>
                        <li>On computer screen every studentwill be given objective type type Multiple Choice Questions (MCQs)</li>
                        <li>Each  student  will  get  questions  and  answers  in  different  order  selected  randomly from a fixed Question Databank</li>
                        <li>The  students  just  need  to  click  on  the  Right  Choice  /  Correct  option  from  the multiple choices /options given with each question. For Multiple Choice Questions, each  question  has  four  options,  and  the  candidate  has  to  click  the  appropriate option</li>
                    </ol>
                    <li>The  sequence  of  steps  to  be  followed  by  each  examinee  for  appearing  in  Examination using Online Examination Portal will be as follows:</li>
                    <ol>
                        <li>The   students   will   have   to   enter   their user id   Number   as   ID   and Password (which has been sent to their registered email-id)</li>
                        <li>The student's details appear on the screen, which will be verified by the student</li>
                        <li>The student will get Instructions to guide through the test</li>
                        <li>The Time of the examination begins only when the 'Start Test' button is pressed</li>
                        <li>The student proceeds answering the questions one by one by clicking on the small grey circle next to the chosen answer</li>
                        <li>The examinee can move to First, Last, Previous, Next and unanswered questions by clicking  on  the  buttons  with  respective  labels  displayed  on  screen  throughout  the test</li>
                        <li>The   answers   can   be   changed   at   any   time   during   the   test   and   are   saved automatically</li>
                        <li>It is possible to Review the answered as well as the unanswered questions</li>
                        <li>Time remaining is shown in the Right Top Corner of the screen</li>
                        <li>The system automatically shuts down when the time limit is over OR alternatively if examinee  finishes  the  exam  before  time  he  can  quit  by  pressingthe 'End Test' button. The students don't click the "END TEST" Button until the student  want  to quit from Examination</li>
                    </ol>
                    <li>Extra Exam Attempt Will not be provided if,</li>
                    <ol>
                        <li>Student failsto appear for exam within specified timings</li>
                        <li>Student doesnot appear the papers</li>
                        <li>Student appears for exam late / face lack of time</li>
                        <li>Student ignores instructionsand rules</li>
                        <li>Student does not submit the exam properly</li>
                        <li>Student face internet of power failure problems</li>
                    </ol>
                </ol>

                <table>
                    <h2>Today's schedule</h2>
                    <tr>
                        <th>s. no.</th>
                        <th>exam code</th>
                        <th>exam date</th>
                        <th>exam start time</th>
                        <th>exam end time</th>
                    </tr>
                    <%
                        int count = 1;

                        java.util.Date date=new java.util.Date();
                        java.sql.Date sqlDate=new java.sql.Date(date.getTime());
                        java.sql.Time sqlTime = new java.sql.Time(date.getTime());

                        try{
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                            PreparedStatement psmt = conn.prepareStatement("select schedule.examCode, examDate, startTime , endTime from schedule, enrollment where schedule.examCode = enrollment.examCode and userID =? and examDate = ? and startTime <= ? and endTime >= ? group by examCode");
                            psmt.setInt(1, Integer.parseInt(session.getAttribute("id").toString()));
                            psmt.setDate(2, sqlDate);
                            psmt.setTime(3, sqlTime);
                            psmt.setTime(4, sqlTime);
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
                <form action="startExam" method="POST">
                    <button type="submit">click to start exam</button>
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