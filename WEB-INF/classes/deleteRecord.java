// servlet for adding new user profile

import java.io.*;
import java.sql.*;
import java.util.Properties;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.mail.*;
import javax.mail.internet.*;

public class deleteRecord extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting the response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // http session initialization
        HttpSession httpsession = request.getSession(false);
        if( httpsession.getAttribute("id")!=null && httpsession.getAttribute("password")!=null ){
    
            // reading form data
            int id = Integer.parseInt(request.getParameter("id"));
            String email = request.getParameter("email");

            // connecting to database
            try{

                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("delete from user where userID = ? and userMail =? ");
                psmt.setInt(1, id);
                psmt.setString(2, email);
                psmt.executeUpdate();

                out.println("<h3 style = 'text-align: center; color:green;'>USER PROFILE DELETED SUCCESSFULLY</h3>");

                Properties properties = System.getProperties();
                properties.put("mail.smtp.host", "smtp.gmail.com");
                properties.put("mail.smtp.port", "465");
                properties.put("mail.smtp.ssl.enable", "true");
                properties.put("mail.smtp.auth", "true");

                Session session = Session.getInstance(properties, new javax.mail.Authenticator(){
                    protected PasswordAuthentication getPasswordAuthentication(){
                            return new PasswordAuthentication("mail@gmail.com", "password");
                    }
                });

                session.setDebug(true);

                try{
                    MimeMessage msg = new MimeMessage(session);
                    msg.setFrom("yogeshgahlawat2425@gmail.com");
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                    msg.setSubject("DELETE USER PROFILE");
                    msg.setContent("YOU ARE NO LONGER BE THE USER ON OUR ONLINE EXAMINATION PORTAL THROUGH YOU REFERENCE EMAIL " + email +
                    ", KINDLY VISIT OUR <a href = 'https://localhost:8080/onlineExaminationPortal/contact.html'>CONTACT PAGE</a> IF YOU HAVE ANY QUERY REGARDING THIS OR CONTACT THE ADMIN", "text/html");
                    Transport.send(msg);

                    out.println("<h3 style='text-align: center; color:green;'>MAIL SENT SUCCESSFULLY</h3>");
                } catch(Exception e){
                    out.println("<h3 style='text-align: center; color:red;'>MAIL SENT FAILED</h3>");
                }
            } catch(Exception e){
                out.println("<h3 style='text-align: center; color:red;'>USER PROFILE DELETION FAILED</h3>");
            }

            request.getRequestDispatcher("adminPage.jsp").include(request, response);
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