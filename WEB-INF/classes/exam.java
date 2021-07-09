import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class exam extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // setting up the response content type
        response.setContentType("text/html");

        // PrintWriter initialization
        PrintWriter out = response.getWriter();

        // HttpSession initialization
        HttpSession session = request.getSession(false);
        if( session.getAttribute("id") != null && session.getAttribute("password") != null ){

            int numberOfQuestion = 0;
            try{
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                PreparedStatement psmt = conn.prepareStatement("select count(distinct(statement)) from user, examQuestion, enrollment where examQuestion.examCode = ? and enrollment.userID = ?");
                psmt.setString(1, session.getAttribute("examCode").toString());
                psmt.setInt(2, Integer.parseInt(session.getAttribute("id").toString()));
                ResultSet rs = psmt.executeQuery();
                while(rs.next()){
                    numberOfQuestion = rs.getInt(1);
                }

                int count = 1;
                while(count<=numberOfQuestion){
                    
                    // reading form data
                    String option = request.getParameter("option" + count);
                    // out.println("option: " + option);

                    psmt = conn.prepareStatement("select count(distinct(statement)) from user, examQuestion, enrollment where examQuestion.examCode = ? and correct = ? and enrollment.userID = ?");
                    psmt.setString(1, session.getAttribute("examCode").toString());
                    psmt.setString(2, option);
                    psmt.setInt(3, Integer.parseInt(session.getAttribute("id").toString()));
                    rs = psmt.executeQuery();
                    int marks = 0;
                    while(rs.next()){
                        // out.println("score: " + rs.getInt(1));
                        if(rs.getInt(1) == 1){
                            marks+=1;
                        }
                    }
                    out.println("total marks: " + marks);
                    out.println("<br>");
                    count++;
                }
            } catch (Exception e){
                out.println(e.toString());
                out.println("<h3 style='text-align: center; text-transform: uppercase; color: red;'>processing exam failed</h3>");
            }
            
        } else {
            session.invalidate();
            response.setHeader("Cache-Control", "no-cache, no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("userLogin.html");
        }
    }
}