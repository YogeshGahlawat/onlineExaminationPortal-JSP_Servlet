// servlet for adding questions

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class processExam extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // setting up the response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // HttpSession initialization
        HttpSession session = request.getSession(false);

        if( session.getAttribute("id") != null && session.getAttribute("password") != null ){

            // reading form data
            String examCode = request.getParameter("examCode");
            String qstatement = request.getParameter("statement");
            String option1 = request.getParameter("option1");
            String option2 = request.getParameter("option2");
            String option3 = request.getParameter("option3");
            String option4 = request.getParameter("option4");
            String correctOption = request.getParameter("correctOption");

            try{
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("insert into examQuestion(statement, option1, option2, option3, option4, correct, examCode) values(?, ?, ?, ?, ?, ?, ?)");
                psmt.setString(1, qstatement);
                psmt.setString(2, option1);
                psmt.setString(3, option2);
                psmt.setString(4, option3);
                psmt.setString(5, option4);
                psmt.setString(6, correctOption);
                psmt.setString(7, examCode);
                psmt.executeUpdate();

                out.println("<h3 style='text-transform: uppercase; text-align: center; color: green;'>question added successfully</h3>");
                request.getRequestDispatcher("scheduleExam.jsp").include(request, response);
            } catch(Exception e){
                out.println("<h3 style='text-transform: uppercase; text-align: center; color: red;'>question adding failed</h3>");
                request.getRequestDispatcher("setupExam.jsp").include(request, response);
            }

        } else{
            session.invalidate();
            response.setHeader("Cache-Control", "no-cache, no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("adminLogin.html");
        }
    }
}
