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
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT DISTINCT * FROM Classes ");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr> Class Roaster </tr>
                    <tr>
                        <th>Title</th>
                        <th>Course Number</th>
                        <th>Quarters Offered</th>
                        <th>Currently Taught</th>
                    </tr>
            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                            <td>
                                <input value="<%= rs.getString("Title") %>"
                                    name="Title" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("CourseNumber") %>"
                                    name="CourseNumber" size="20">
                            </td>


                            <td>
                                <input value="<%= rs.getString("QuarterOffer") %>"
                                    name="QuarterOffer" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("CurrentlyTaught") %>"
                                    name="QuarterOffer" size="20">
                            </td>

                    </tr>
            <%
                    }
            %>

            <%-- -------- Query Entry Code -------- --%>
            <table border="1">
                <tr>
                    <th>Title</th>
                    <th>Action</th>
                </tr>
                <tr>
                    <form action="classRoaster.jsp" method="get">
                        <input type="hidden" value="query" name="action">
                        <th><input value="" name="Title" size="10"></th>
                        <th><input type="submit" value="Query"></th>
                    </form>
                </tr>
                <tr><th>Info for students enrolled in this class:</th></tr>

                <%-- -------- Query Statement Code -------- --%>
                <%
                        String action = request.getParameter("action");

                        if (action != null && action.equals("query")) {
                          PreparedStatement pstmt = conn.prepareStatement(
                              "SELECT DISTINCT SocialSecurity,student.firstname,student.LASTNAME,student.Program,enrollment.GRADEOPTION,enrollment.UNITS FROM SECTION,Student,classes,enrollment WHERE classes.Title = ? AND classes.CourseNumber = SECTION.CourseNumber and section.SECTIONNUMBER = enrollment.SECTIONNUMBER and enrollment.firstname = student.firstname");
                          pstmt.setString(1, request.getParameter("Title"));
                          ResultSet rs1 = pstmt.executeQuery();
                          %>
                          <tr>
                            <th>SocialSecurity</th>
                            <th>FirstName</th>
                            <th>LastName</th>
                            <th>Degree</th>
                            <th>Grade Option</th>
                            <th>Units</th>
                          </tr>
                          <%
                          while ( rs1.next() ) {

                            %>


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

                                <%-- Get the LASTNAME --%>
                                <td>
                                    <input value="<%= rs1.getString("LastName") %>"
                                        name="LastName" size="20">
                                </td>


                                <td>
                                    <input value="<%= rs1.getString("Program") %>"
                                        name="Program" size="20">
                                </td>

                                <td>
                                    <input value="<%= rs1.getString("GRADEOPTION") %>"
                                        name="GRADEOPTION" size="20">
                                </td>

                                <td>
                                    <input value="<%= rs1.getInt("UNITS") %>"
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
