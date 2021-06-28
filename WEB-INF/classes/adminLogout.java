// servlet for admin logout

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class adminLogout extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        // setting response content type
        response.setContentType("text/html");

        // PrintWriter Initialization
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        session.invalidate();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.sendRedirect("adminLogin.html");
        out.println("<h3 style='text-align: center; text-transform: uppercase; color:red;'>you logged out successfully</h3>");
    }
}