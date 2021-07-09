// servlet for admin login

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class adminLogin extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // reading form data
        int id = 0;
        if(request.getParameter("id") == ""){
            id = 0;
        } else{
            id = Integer.parseInt(request.getParameter("id"));
        }
        String password = request.getParameter("password");

        // creating connection to database
        try{

            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
            PreparedStatement psmt = conn.prepareStatement("select * from admin");
            ResultSet rs = psmt.executeQuery();
            while(rs.next()){
                if( ((id!=0) && (id==rs.getInt("adminID"))) && ((!(password.equals(""))) && (password.equals(rs.getString("password")))) ){

                    HttpSession session = request.getSession();
                    session.setAttribute("id", rs.getInt("adminID"));
                    session.setAttribute("name", rs.getString("adminName"));
                    session.setAttribute("email", rs.getString("adminMail"));
                    session.setAttribute("password", rs.getString("password"));

                    request.getRequestDispatcher("adminPage.jsp").forward(request, response);

                } else{
                    out.println("<h3 style='text-align: center; text-transform: uppercase; color:red;'>invalid login</h3>");
                    request.getRequestDispatcher("adminLogin.html").include(request, response);
                }
            }
        } catch(Exception e){
            out.println("<h3 style='text-align: center; text-transform: uppercase; color:red;'>login failed</h3>");
            request.getRequestDispatcher("adminLogin.html").include(request, response);
        }
    }
}