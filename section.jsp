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

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);

                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Section VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

                       pstmt.setInt(1, Integer.parseInt(request.getParameter("SectionNumber")));
                       pstmt.setString(2, request.getParameter("CourseNumber"));
                       pstmt.setString(3, request.getParameter("Quarter"));
                       pstmt.setInt(4, Integer.parseInt(request.getParameter("Year")));
                       pstmt.setString(5, request.getParameter("MeetingTimeLEC"));
                       pstmt.setString(6, request.getParameter("MeetingTimeDIS"));
                       pstmt.setString(7, request.getParameter("MeetingTimeLAB "));
                       pstmt.setString(8, request.getParameter("ReviewSession"));
                       pstmt.setString(9, request.getParameter("Final"));
                       pstmt.setInt(10, Integer.parseInt(request.getParameter("EnrollmentLimit")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);

                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE SECTION SET CourseNumber = ?, Quarter = ?, Year = ?, MeetingTimeLEC = ?, MeetingTimeDIS = ?, MeetingTimeLAB = ?, ReviewSession = ?, Final = ?, EnrollmentLimit = ? WHERE SectionNumber = ?");

                        pstmt.setString(1, request.getParameter("CourseNumber"));
                        pstmt.setString(2, request.getParameter("Quarter"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("Year")));
                        pstmt.setString(4, request.getParameter("MeetingTimeLEC"));
                        pstmt.setString(5, request.getParameter("MeetingTimeDIS"));
                        pstmt.setString(6, request.getParameter("MeetingTimeLAB"));
                        pstmt.setString(7, request.getParameter("ReviewSession"));
                        pstmt.setString(8, request.getParameter("Final"));
                        pstmt.setInt(9, Integer.parseInt(request.getParameter("EnrollmentLimit")));
                        pstmt.setInt(10,  Integer.parseInt(request.getParameter("SectionNumber")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>


            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM section");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SectionNumber</th>
                        <th>CourseNumber</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>MeetingTimeLEC</th>
                        <th>MeetingTimeDIS</th>
                        <th>MeetingTimeLAB</th>
                        <th>ReviewSession</th>
                        <th>Final</th>
                        <th>EnrollmentLimit</th>
                    </tr>
                    <tr>
                        <form action="section.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SectionNumber" size="10"></th>
                            <th><input value="" name="CourseNumber" size="15"></th>
                            <th><input value="" name="Quarter" size="15"></th>
                            <th><input value="" name="Year" size="15"></th>
                            <th><input value="" name="MeetingTimeLEC" size="50"></th>
                            <th><input value="" name="MeetingTimeDIS" size="50"></th>
                            <th><input value="" name="MeetingTimeLAB" size="50"></th>
                            <th><input value="" name="ReviewSession" size="50"></th>
                            <th><input value="" name="Final" size="40"></th>
                            <th><input value="" name="EnrollmentLimit" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="section.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SectionNumber") %>"
                                    name="SectionNumber" size="10">
                            </td>

                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("CourseNumber") %>"
                                    name="CourseNumber" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Quarter") %>"
                                    name="Quarter" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("Year") %>"
                                    name="Year" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("MeetingTimeLEC") %>"
                                    name="MeetingTimeLec" size="80">
                            </td>
                            <td>
                                <input value="<%= rs.getString("MeetingTimeDIS") %>"
                                    name="MeetingTimeDis" size="80">
                            </td>
                            <td>
                                <input value="<%= rs.getString("MeetingTimeLAB") %>"
                                    name="MeetingTimeLAB" size="80">
                            </td>
                            <td>
                                <input value="<%= rs.getString("ReviewSession") %>"
                                    name="ReviewSession" size="80">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Final") %>"
                                    name="Final" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("EnrollmentLimit") %>"
                                    name="EnrollmentLimit" size="10">
                            </td>
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();

                    // Close the Statement
                    statement.close();

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
