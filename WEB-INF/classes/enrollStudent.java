// servlet for enrolling the student

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class enrollStudent extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // setting up the response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // HttpSession initialization
        HttpSession session = request.getSession(false);

        if( session.getAttribute("id") != null && session.getAttribute("password") != null ) {

            // reading form data
            String examCode = request.getParameter("examCode");

            try{

                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("insert into enrollment(examCode, userID) values(?, ?)");
                psmt.setString(1, examCode);
                psmt.setInt(2, Integer.parseInt(session.getAttribute("id").toString()));
                psmt.executeUpdate();

                out.println("<h3 style='text-align: center; text-transform: uppercase; color: green;'>you enrolled successfully</h3>");

            } catch(Exception e){
                out.println("<h3 style='text-align: center; text-transform: uppercase; color: red;'>error occured</h3>");
            }
            request.getRequestDispatcher("userPage.jsp").include(request, response);

        } else {
            session.invalidate();
            response.setHeader("Cache-Control", "no-cache, no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("userLogin.html");
        }
    }
}