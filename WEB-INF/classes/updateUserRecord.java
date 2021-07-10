// servlet for updating user record

import java.io.*;
import java.sql.*;
import java.util.Properties;
import javax.servlet.*;
import javax.servlet.http.*;;
import javax.mail.*;
import javax.mail.internet.*;

public class updateUserRecord extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting up the response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // HttpSession initialization
        HttpSession httpsession = request.getSession(false);
        if( httpsession.getAttribute("id") != null && httpsession.getAttribute("password") != null){

            // reading form data
            int id = Integer.parseInt(httpsession.getAttribute("userID").toString());
            String email = request.getParameter("userMail");
            String password = request.getParameter("userPassword");

            // establishing the database connection and updating the user record
            try{

                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("update user set userMail = ?, password = ? where userID = ?");
                psmt.setString(1, email);
                psmt.setString(2, password);
                psmt.setInt(3, id);
                psmt.executeUpdate();

                out.println("<h3 style='text-transform: uppercase; text-align: center; color: green;'>user record updated successfully</h3>");

                // sending the new login credentials to user
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
                    MimeMessage message = new MimeMessage(session);
                    message.setFrom(new InternetAddress("yogeshgahlawat2425@gmail.com"));
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                    message.setSubject("USER RECORD UPDATION");
                    message.setContent(
                        "<p> THIS EMAIL IS RELATED TO " + email +", YOUR CONTACT INFORMATION AND LOGIN CREDENTIALS UPDATED BY ADMIN ON YOUR REQUEST" +
                        ". YOUR NEW CONTACT AND LOGIN CREDENTIALS ARE: USERID--> " + id + ", PASSWORD--> " + password +
                        "CLICK HERE TO <a href='https://localhost:8080/userLogin.html'>LOGIN</a></p>", "text/html");
                    Transport.send(message);
                    out.println("<h3 style='text-transform: uppercase; text-align: center; color:green;'>user record updation mail sent successfully!</h3>");
                } catch(Exception e){
                    out.println("<h3 style='text-transform: uppercase; text-align: center; color:red;'>user record updation mail sent failed!</h3>");
                }
            } catch(Exception e){
                out.println("<h3 style='text-transform: uppercase; text-align: center; color:red;'>user record updation failed!</h3>");
            }
            request.getRequestDispatcher("adminPage.jsp").include(request, response);
        } else{
            httpsession.invalidate();
            response.setHeader("Cache-Control","no-cache");
            response.setHeader("Cache-Control","no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("adminLogin.html");
            out.println("<h3 style='text-transform: uppercase; text-align: center; color:red;'>session timeout! Please login again!</h3>");
        }
    }
}