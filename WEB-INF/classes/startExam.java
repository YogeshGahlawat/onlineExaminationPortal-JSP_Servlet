import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class startExam extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // setting up the response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // HttpSession initialization
        HttpSession session = request.getSession(false);

        if( session.getAttribute("id") != null && session.getAttribute("password") != null ){

            java.util.Date date=new java.util.Date();
            java.sql.Date sqlDate=new java.sql.Date(date.getTime());
            java.sql.Time sqlTime = new java.sql.Time(date.getTime());

            try{

                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("select schedule.examCode, examDate, startTime , endTime from schedule, enrollment where schedule.examCode = enrollment.examCode and userID =? and examDate = ? and startTime <= ? and endTime >= ? group by examCode");
                psmt.setInt(1, Integer.parseInt(session.getAttribute("id").toString()));
                psmt.setDate(2, sqlDate);
                psmt.setTime(3, sqlTime);
                psmt.setTime(4, sqlTime);
                ResultSet rs = psmt.executeQuery(); 
                while(rs.next()){
                    session.setAttribute("examCode", rs.getString("examCode"));
                    session.setAttribute("startTime", rs.getTime("startTime"));
                    session.setAttribute("endTime", rs.getTime("endTime"));
                }
                
                request.getRequestDispatcher("exam.jsp").include(request, response);

            } catch (Exception e){
                out.println(e.toString());
                out.println("<h3 style='text-align: center; text-transform: uppercase; color: red;'>error occured, please contact admin to continue....</h3>");
                request.getRequestDispatcher("userPage.jsp").include(request, response);
            }

        } else {
            session.invalidate();
            response.setHeader("Cache-Control", "no-cache, no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("userLogin.html");
            out.println("<h3 style='text-align: center; text-transform: uppercase; color: red;'>session expired, please relogin to continue....</h3>");
        }
    }
}