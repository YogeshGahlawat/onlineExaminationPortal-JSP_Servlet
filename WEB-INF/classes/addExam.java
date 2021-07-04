// servlet for adding new exam details

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class addExam extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting up the response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // HttpSession initialization
        HttpSession session = request.getSession(false);
        if( session.getAttribute("id") != null && session.getAttribute("password") != null ){

            // reading form data
            String examCode = request.getParameter("code");
            String examTitle = request.getParameter("title");
            int number = Integer.parseInt(request.getParameter("number"));

            java.util.Date date=new java.util.Date();
            java.sql.Date sqlDate=new java.sql.Date(date.getTime());
            
            // creating connection to database
            try{
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("insert into exam(examCode, examTitle, examCreationDate, numberOfQuestions, createdBy, status) values(?, ?, ?, ?, ?, ?)");
                psmt.setString(1, examCode.toUpperCase());
                psmt.setString(2, examTitle.toUpperCase());
                psmt.setDate(3, sqlDate);
                psmt.setInt(4, number);
                psmt.setInt(5, Integer.parseInt(session.getAttribute("id").toString()));
                psmt.setString(6, "PENDING");
                psmt.executeUpdate();


                out.println("<h3 stle='text-transform: uppercase; text-align: center; color: green;'>question paper added successfully</h3>");
            
                request.getRequestDispatcher("setupExam.jsp").forward(request, response);

            } catch(Exception e){
                out.println("<h3 stle='text-transform: uppercase; text-align: center; color:red;'>failed to add exam paper</h3>");
            
                request.getRequestDispatcher("questionBank.jsp").forward(request, response);
            }

        } else{
            session.invalidate();
            response.setHeader("Cache-Control", "no-cache, no-store");
            response.setDateHeader("Expires", 0);
            out.println("<h3 stle='text-transform: uppercase; text-align: center; color:red;'>session expired! please relogin</h3>");
            response.sendRedirect("adminLogin.html");
        }
    }
}