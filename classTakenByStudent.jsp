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
                        ("SELECT DISTINCT SocialSecurity,Student.FirstName,LastName,Program FROM Student, Enrollment WHERE Student.FIRSTNAME = enrollment.firstname");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr> Student enroll in current QUARTER </tr>
                    <tr>
                        <th>SocialSecurity</th>
                        <th>FirstName</th>
                        <th>LastName</th>
                        <th>Degree</th>
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
                                <input value="<%= rs.getString("Program") %>"
                                    name="Program" size="20">
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
                        <form action="classTakenByStudent.jsp" method="get">
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
                        <tr><th>Info for student:</th></tr>
                        <tr>
                            <th>SocialSecurity</th>
                            <th>FirstName</th>
                            <th>MiddleName</th>
                            <th>LastName</th>
                        </tr>
                      <tr>
                          <form action="classTakenByStudent.jsp" method="get">


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
                        "SELECT DISTINCT Title, classes.CourseNumber,quarter,year,MeetingTimeLEC,MeetingTimeDIS,GRADEOPTION,UNITS FROM STUDENT,Enrollment,Classes,SECTION WHERE SocialSecurity = ? AND Student.FIRSTNAME = enrollment.firstname AND Enrollment.SECTIONNUMBER = SECTION.SECTIONNUMBER AND SECTION.CourseNumber = classes.CourseNumber");
                    pstmt1.setInt(
                        1, Integer.parseInt(request.getParameter("SocialSecurity")));

                    rs2 = pstmt1.executeQuery();

                    %>
                    <tr><th>His classes in current quarter:</th></tr>
                    <tr>
                        <th>Title</th>
                        <th>CourseNumber</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>MeetingTime Lecture</th>
                        <th>MeetingTime Discussion</th>
                        <th>Grade Option</th>
                        <th>Units</th>
                    </tr>
                    <%
                    while ( rs2.next() ) {

                      %>

                    <tr>
                        <form action="classTakenByStudent.jsp" method="get">
                            <input type="hidden" value="update" name="action">


                            <td>
                                <input value="<%= rs2.getString("Title") %>"
                                    name="Title" size="30">
                            </td>


                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs2.getString("CourseNumber") %>"
                                    name="CourseNumber" size="20">
                            </td>

                            <td>
                                <input value="<%= rs2.getString("Quarter") %>"
                                    name="Quarter" size="20">
                            </td>


                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs2.getInt("Year") %>"
                                    name="Year" size="20">
                            </td>

                            <td>
                                <input value="<%= rs2.getString("MeetingTimeLEC") %>"
                                    name="MeetingTimeLEC" size="20">
                            </td>

                            <td>
                                <input value="<%= rs2.getString("MeetingTimeDIS") %>"
                                    name="MeetingTimeDIS" size="20">
                            </td>



                            <td>
                                <input value="<%= rs2.getString("GRADEOPTION") %>"
                                    name="GRADEOPTION" size="20">
                            </td>

                            <td>
                                <input value="<%= rs2.getInt("UNITS") %>"
                                    name="UNITS" size="20">
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
