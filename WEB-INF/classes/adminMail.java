// servlet for updating admin records

import java.io.*;
import java.sql.*;
import java.util.Properties;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.mail.*;
import javax.mail.internet.*;

public class adminMail extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting response content type
        response.setContentType("text/html");

        // PrintWriter object initialization
        PrintWriter out = response.getWriter();

        // reading form data
        String email = request.getParameter("email");

        // http session initialization
        HttpSession httpsession = request.getSession(true);
        httpsession.setAttribute("email", email);

        // connecting to database for updating the admin records
        try{
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
            PreparedStatement psmt = conn.prepareStatement("select * from admin");
            ResultSet rs = psmt.executeQuery();
            while(rs.next()){
                if(email.equals(rs.getString("adminMail"))){
                    
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
                        msg.setFrom(new InternetAddress("yogeshgahlawat2425@gmail.com"));
                        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                        msg.setSubject("RESET ADMIN PASSWORD");
                        msg.setContent(
                            "THIS EMAIL IS REGARDING TO RESET ADMIN PASSWORD, AND THIS EMAIL BELONGS TO " + email +
                            ", CLICK HERE TO <a href='http://localhost:8080/onlineExaminationPortal/resetAdminPassword.html'>RESET ADMIN PASSWORD</a>", "text/html"
                        );
                        Transport.send(msg);

                        out.println("<h3 style='text-align: center; color:green;'>RESET ADMIN PASSWORD MAIL SENT SUCCESSFULLY</h3>");
                    } catch(Exception e){
                        out.println("<h3 style='text-align: center; color:red;'>RESET ADMIN PASSWORD MAIL SENT FAILED</h3>");
                    }
                } else{
                    out.println("<h3 style='text-align: center; color:red;'>YOU ARE NOT REGISTERED WITH US, KINDLY PLEASE CONTACT YOUR ADMIN</h3>");
                }
            }
        } catch(Exception e){
            out.println("<h3 style='text-align: center; color:red;'>RESET ADMIN PASSWORD MAIL SENT FAILED</h3>");
        }
        request.getRequestDispatcher("adminLogin.html").include(request, response);
    }
}