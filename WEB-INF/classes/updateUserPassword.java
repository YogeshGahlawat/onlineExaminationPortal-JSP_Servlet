// servlet for updating admin records

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class updateUserPassword extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting response content type
        response.setContentType("text/html");

        // PrintWriter object initialization
        PrintWriter out = response.getWriter();

        // http session initialization
        HttpSession session = request.getSession(false);

        // reading form data
        String password = request.getParameter("password");
        
        // connecting to database for updating the admin records
        try{
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
            PreparedStatement psmt = conn.prepareStatement("update user set password = ? where userMail = ?");
            psmt.setString(1, password);
            psmt.setString(2, (String)session.getAttribute("email"));
            psmt.executeUpdate();

            out.println("<h3 style='text-align: center; color:green;'>USER PASSWORD UPDATED SUCCESSFULLY</h3>");
        } catch(Exception e){
            out.println("<h3 style='text-align: center; color:red;'>USER PASSWORD UPDATION FAILED</h3>");
        }
        request.getRequestDispatcher("userLogin.html").include(request, response);
    }
}