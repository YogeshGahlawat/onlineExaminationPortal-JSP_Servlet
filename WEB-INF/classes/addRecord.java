// servlet for adding new user profile

import java.io.*;
import java.sql.*;
import java.util.Properties;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.mail.*;
import javax.mail.internet.*;

public class addRecord extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting the response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // http session initialization
        HttpSession httpsession = request.getSession(false);
        if( httpsession.getAttribute("id")!=null && httpsession.getAttribute("password")!=null ){
    
            // reading form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");

            // generating random password
            String alphaNumeric = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz!@#$%&";
            StringBuilder createPassword = new StringBuilder(8);
            for( int i = 0; i<8; i++){
                int index = (int)(alphaNumeric.length() * Math.random());
                createPassword.append(alphaNumeric.charAt(index));
            }
            String password = createPassword.toString();

            // connecting to database
            try{

                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("insert into user(userName, userMail, password) values(?, ?, ?)");
                psmt.setString(1, name);
                psmt.setString(2, email);
                psmt.setString(3, password);
                psmt.executeUpdate();

                out.println("<h3 style = 'text-align: center; text-transform: uppercase; color: green;'>NEW USER REGISTERED SUCCESSFULLY</h3>");

                // fetching data from datasource
                psmt =  conn.prepareStatement("select * from user where userName = '" + name + "' and userMail = '" + email + "'");
                ResultSet rs = psmt.executeQuery();
                while(rs.next()){
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
                        msg.setSubject("NEW USER REGISTERATION");
                        msg.setContent(
                            "YOU ARE REGISTERED AS USER ON OUR ONLINE EXAMINATION PORTAL THROUGH YOU REFERENCE EMAIL " + email +
                            ", YOUR LOGIN CREDENTIALS ARE: USERID--> " + rs.getInt("userID") + " PASSWORD--> " + rs.getString("password") +
                            " CLICK HERE TO <a href='https://localhost:8080/onlineExaminationPortal/userLogin.html'>LOGIN</a> INTO YOUR ACCOUNT", "text/html"
                        );
                        Transport.send(msg);

                        out.println("<h3 style='text-align: center; color:green;'>MAIL SENT SUCCESSFULLY</h3>");
                    } catch(Exception e){
                        out.println("<h3 style='text-align: center; color:red;'>MAIL SENT FAILED</h3>");
                    }
                }
            } catch(Exception e){
                out.println("<h3 style='text-align: center; color:red;'>NEW USER REGISTERATION FAILED</h3>");
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