// servlet for scheduling exam

import java.io.*;
import java.sql.*;
import java.time.LocalTime;
import javax.servlet.*;
import javax.servlet.http.*;

public class scheduleExam extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Setting up the response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // HttpSession Initialization
        HttpSession session = request.getSession(false);

        if( session.getAttribute("id") != null && session.getAttribute("password") != null ) {

            // reading form data
            String examCode = request.getParameter("examCode");
            String startDate = request.getParameter("startDate");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");

            LocalTime startingTime = LocalTime.parse(startTime);
            LocalTime endingTime = LocalTime.parse(endTime);

            out.println(Date.valueOf(startDate));
            out.println(Time.valueOf(startingTime));
            out.println(Time.valueOf(endingTime));

            try{

                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("insert into schedule(examDate, startTime, endTime, examCode) values(?, ?, ?, ?)");
                psmt.setDate(1, Date.valueOf(startDate));
                psmt.setTime(2, Time.valueOf(startingTime));
                psmt.setTime(3, Time.valueOf(endingTime));
                psmt.setString(4, examCode);
                psmt.executeUpdate();

                psmt = conn.prepareStatement("update exam set status = 'SUCCESS' where examCode =?");
                psmt.setString(1, examCode);
                psmt.executeUpdate();

                out.println("<h3 style='text-align: center; text-transform: uppercase; color: green;'>exam published successfully</h3>");
            } catch(Exception e) {
                out.println("<h3 style='text-align: center; text-transform: uppercase; color: red;'>exam publishing failed</h3>");
            }

            request.getRequestDispatcher("adminPage.jsp").include(request, response);

        } else {
            session.invalidate();
            response.setHeader("Cahe-Control", "no-cache, no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("adminLogin.html");
        }
    }
}