// servlet for updating admin records

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class updateUserProfile extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting response content type
        response.setContentType("text/html");

        // PrintWriter object initialization
        PrintWriter out = response.getWriter();

        // http session initialization
        HttpSession session = request.getSession(false);
        if( session.getAttribute("id")!=null && session.getAttribute("password")!=null ){
            int id = Integer.parseInt(session.getAttribute("id").toString());

            // reading form data
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // connecting to database for updating the admin records
            try{
                out.println("in try block");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("update user set userMail =?, password = ? where userID = ?");
                psmt.setString(1, email);
                psmt.setString(2, password);
                psmt.setInt(3, id);
                psmt.executeUpdate();

                session.setAttribute("email", email);
                session.setAttribute("password", password);

                out.println("<h3 style='text-align: center; color:green;'>USER RECORD UPDATED SUCCESSFULLY</h3>");
            } catch(Exception e){
                out.println("<h3 style='text-align: center; color:red;'>USER RECORD UPDATION FAILED</h3>");
            }
            request.getRequestDispatcher("userPage.jsp").include(request, response);
        } else{
            session.invalidate();
            response.setHeader("Cache-Control","no-cache");
            response.setHeader("Cache-Control","no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("userLogin.html");
            out.println("<h3 style='text-align-center; text-transform: uppercase; color:red;'>session expired! please login again");
        }
    }
}
