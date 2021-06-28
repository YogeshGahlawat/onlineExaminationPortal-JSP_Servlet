// servlet for searching user record

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class searchRecord extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting content type
        response.setContentType("text/html");

        // PrintWriter object initialization
        PrintWriter out = response.getWriter();

        // http session initialization
        HttpSession httpsession = request.getSession(false);
        if( httpsession.getAttribute("id")!=null && httpsession.getAttribute("password")!=null ){

            // reading form data
            int id = Integer.parseInt(request.getParameter("id"));
            String email = request.getParameter("email");

            // establishing connection to database for searching the records
            try{
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("select * from user where userID = ? and userMail =?");
                psmt.setInt(1, id);
                psmt.setString(2, email);
                ResultSet rs = psmt.executeQuery();
                if(rs.next()){

                    // creating a http session
                    HttpSession session = request.getSession(false);
                    session.setAttribute("userID", rs.getInt("userID"));
                    session.setAttribute("userName", rs.getString("userName"));
                    session.setAttribute("userMail", rs.getString("userMail"));
                    session.setAttribute("userPassword", rs.getString("password"));

                    // transfering the request to another page
                    request.getRequestDispatcher("searchResults.jsp").forward(request, response);
                } else{
                    out.println("<h3 style='text-align: center; text-transform: uppercase; color:red;'>invalid user profile</h3>");

                    // transfering the request to another page
                    request.getRequestDispatcher("adminPage.jsp").include(request, response);     
                }
            
                // closing the connection
                rs.close();
                psmt.close();
                conn.close();
            } catch(Exception e){
                out.println("<h3 style='text-align: center; text-transform: uppercase; color:red;'>searching for user profile failed</h3>");
            
                // transfering the request to another page
                request.getRequestDispatcher("adminPage.jsp").include(request, response);
            }
        } else{
            httpsession.invalidate();
            response.setHeader("Cache-Control","no-cache");
            response.setHeader("Cache-Control","no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("adminLogin.html");
            out.println("<h3 style='text-align-center; text-transform: uppercase; color:red;'>session expired! please login again");
        }
    }
}
