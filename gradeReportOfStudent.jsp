<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>

            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    String dbURL = "jdbc:postgresql:cse132?user=postgres&password=admin";
                    Connection conn = DriverManager.getConnection(dbURL);
                    ResultSet rs1;
                    ResultSet rs2;
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT DISTINCT SocialSecurity,Student.FirstName,LastName,MiddleName FROM Student, Enrollment WHERE Student.FIRSTNAME = enrollment.firstname");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr> Student enrolled </tr>
                    <tr>
                        <th>SocialSecurity</th>
                        <th>FirstName</th>
                        <th>LastName</th>
                        <th>MiddleName</th>
                    </tr>


            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SocialSecurity") %>"
                                    name="SocialSecurity" size="10">
                            </td>


                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("FirstName") %>"
                                    name="FirstName" size="20">
                            </td>

                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("LastName") %>"
                                    name="LastName" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("MiddleName") %>"
                                    name="MiddleName" size="20">
                            </td>

                    </tr>
            <%
                    }
            %>


            <%-- -------- FrameWork Code -------- --%>
            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="gradeReportOfStudent.jsp" method="get">
                            <input type="hidden" value="query" name="action">
                            <th><input value="" name="SocialSecurity" size="10"></th>
                            <th><input type="submit" value="Query"></th>
                        </form>
                    </tr>

            <%-- -------- Query Statement Code -------- --%>
            <%
                    String action = request.getParameter("action");

                    if (action != null && action.equals("query")) {
                      PreparedStatement pstmt = conn.prepareStatement(
                          "SELECT * FROM STUDENT WHERE SocialSecurity = ?");
                      pstmt.setInt(
                          1, Integer.parseInt(request.getParameter("SocialSecurity")));

                      rs1 = pstmt.executeQuery();


                      while ( rs1.next() ) {

                        %>
                        <tr><th>Grade Report for student:</th></tr>
                        <tr>
                            <th>SocialSecurity</th>
                            <th>FirstName</th>
                            <th>MiddleName</th>
                            <th>LastName</th>
                        </tr>
                      <tr>
                          <form action="gradeReportOfStudent.jsp" method="get">


                              <%-- Get the SSN, which is a number --%>
                              <td>
                                  <input value="<%= rs1.getInt("SocialSecurity") %>"
                                      name="SocialSecurity" size="10">
                              </td>


                              <%-- Get the FIRSTNAME --%>
                              <td>
                                  <input value="<%= rs1.getString("FirstName") %>"
                                      name="FirstName" size="20">
                              </td>

                              <td>
                                  <input value="<%= rs1.getString("MiddleName") %>"
                                      name="MiddleName" size="20">
                              </td>


                              <%-- Get the LASTNAME --%>
                              <td>
                                  <input value="<%= rs1.getString("LastName") %>"
                                      name="LastName" size="20">
                              </td>
                          </form>
                      </tr>
                      <%
                      }

                    //
                    PreparedStatement pstmt1 = conn.prepareStatement(
                        "select coursenumber,quarteryear, unit, gradeoption, grade, gradeint from schedule where schedule.firstname in (Select firstname from student where socialsecurity = ?) order by quarteryear");
                    pstmt1.setInt(
                        1, Integer.parseInt(request.getParameter("SocialSecurity")));

                    rs2 = pstmt1.executeQuery();

                    %>
                    <tr><th>His classes taken:</th></tr>
                    <tr>
                        <th>coursenumber</th>
                        <th>quarteryear</th>
                        <th>unit</th>
                        <th>gradeoption</th>
                        <th>grade</th>
                        <th>Gradeint</th>
                    </tr>
                    <%
                    while ( rs2.next() ) {

                      %>

                    <tr>
                        <form action="gradeReportOfStudent.jsp" method="get">
                            <input type="hidden" value="update" name="action">


                            <td>
                                <input value="<%= rs2.getString("coursenumber") %>"
                                    name="coursenumber" size="30">
                            </td>


                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs2.getString("Grade") %>"
                                    name="Grade" size="20">
                            </td>

                            <td>
                                <input value="<%= rs2.getString("Quarteryear") %>"
                                    name="Quarter/Year" size="20">
                            </td>
                            <td>
                                <input value="<%= rs2.getString("unit") %>"
                                    name="unit" size="20">
                            </td>
                            <td>
                                <input value="<%= rs2.getString("gradeoption") %>"
                                    name="gradeoption" size="20">
                            </td>
                            <td>
                                <input value="<%= rs2.getString("grade") %>"
                                    name="grade" size="20">
                            </td>
                            <td>
                                <input value="<%= rs2.getString("gradeint") %>"
                                    name="gradeint" size="20">
                            </td>

                        </form>
                    </tr>
                    <%
                    }


                    // calculate GPA
                    PreparedStatement pstmt2 = conn.prepareStatement(
                        "SELECT ROUND(AVG(Schedule.Gradeint),2) as GPA FROM  schedule where schedule.firstname in (Select firstname from student where socialsecurity = ?)");
                    pstmt2.setInt(
                        1, Integer.parseInt(request.getParameter("SocialSecurity")));

                    rs2 = pstmt2.executeQuery();

                    %>
                    <tr><th>Cumulative GPA report</th></tr>
                    <tr>
                        <th>GPA</th>
                    </tr>
                    <%
                    while ( rs2.next() ) {

                      %>

                    <tr>
                        <form action="gradeReportOfStudent.jsp" method="get">
                            <input type="hidden" value="update" name="action">
                            <td>
                                <input value="<%= rs2.getString("GPA") %>"
                                    name="GPA" size="20">
                            </td>

                        </form>
                    </tr>
                    <%
                    }

                    // calculate gpa by quarter
                    PreparedStatement pstmt3 = conn.prepareStatement(
                        "SELECT Schedule.QuarterYEar, ROUND(AVG(Schedule.Gradeint),2) as GPA FROM  schedule where schedule.firstname in (Select firstname from student where socialsecurity = ?) Group by Schedule.QuarterYEar");
                    pstmt3.setInt(
                        1, Integer.parseInt(request.getParameter("SocialSecurity")));

                    rs2 = pstmt3.executeQuery();

                    %>
                    <tr><th>GPA report by quarter</th></tr>
                    <tr>
                        <th>QuarterYear</th>
                        <th>GPA</th>
                    </tr>
                    <%
                    while ( rs2.next() ) {

                      %>

                    <tr>
                        <form action="gradeReportOfStudent.jsp" method="get">
                            <input type="hidden" value="update" name="action">
                            <td>
                                <input value="<%= rs2.getString("QuarterYear") %>"
                                    name="QuarterYear" size="20">
                            </td>
                            <td>
                                <input value="<%= rs2.getString("GPA") %>"
                                    name="GPA" size="20">
                            </td>

                        </form>
                    </tr>
                    <%
                    }

                    }
            %>


            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    // rs1.close();
                    //
                    // // Close the Statement
                    // statement.close();

                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
