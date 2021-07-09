<%@ page import = "java.sql.*, java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EXAM | EXAMINATION</title>
    <link rel="stylesheet" href="./css/exam.css">
</head>
<body>

    <%
        if( session.getAttribute("id") != null && session.getAttribute("password") != null ){
            %>
            
            <!-- Navigation Panal -->
            <nav>
                <h3>examcode: <%=session.getAttribute("examCode")%></h3>
            </nav>

            <!-- exam section -->
            <div class="exam">
                <div class="questions">
                    <form method="POST" id="" action="exam">
                <%
                int count = 1;
                try{
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineExaminationPortal", "root", "");
                    PreparedStatement psmt = conn.prepareStatement("select * from examQuestion where examCode = ?");
                    psmt.setString(1, session.getAttribute("examCode").toString());
                    ResultSet rs = psmt.executeQuery();
                    while(rs.next()){
                        %>
                            <div class="input-field">
                                <label for="">Question <%=count%></label>
                                <div class="input">
                                    <label for="option"+<%=count%>><%=rs.getString("statement")%></label>
                                    <div class="options">
                                        <div class="option">
                                            <input type="radio" name=<%="option" + count%> id="" value="<%=rs.getString("option1")%>"> <%=rs.getString("option1")%>
                                        </div>
                                        <div class="option">
                                            <input type="radio" name=<%="option" + count%> id="" value="<%=rs.getString("option2")%>"> <%=rs.getString("option2")%>
                                        </div>
                                        <div class="option">
                                            <input type="radio" name=<%="option" + count%> id="" value="<%=rs.getString("option3")%>"> <%=rs.getString("option3")%>
                                        </div>
                                        <div class="option">
                                            <input type="radio" name=<%="option" + count%> id="" value="<%=rs.getString("option4")%>"> <%=rs.getString("option4")%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <%
                        count++;
                    }
                } catch(Exception e){
                    request.getRequestDispatcher("userPage.jsp").include(request, response);
                    out.println("fetching records failed");
                }
                %>
                <button type="submit">submit</button>
                    </form>
                </div>
            </div>
            <%
        } else {
            session.invalidate();
            response.setHeader("Cache-Control", "no-cache, no-store");
            response.setDateHeader("Expires", 0);
            response.sendRedirect("userLogin.html");
        }
    %>
    
</body>
</html>