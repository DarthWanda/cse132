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
                            "INSERT INTO Classes VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SECTIONID")));
                        pstmt.setString(2, request.getParameter("QUARTERYEAR"));
                        pstmt.setString(3, request.getParameter("MEETINGTYPE"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("MANDATORY")));
                        pstmt.setString(5, request.getParameter("BUILDING"));
                        pstmt.setString(6, request.getParameter("COURSETITLE"));
                        pstmt.setString(7, request.getParameter("MEETINGTIME"));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("ENROLLMENTLIMIT")));
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
                            "UPDATE Classes SET QUARTERYEAR = ?, MEETINGTYPE = ?, " +
                            "MANDATORY = ?, BUILDING = ?, COURSETITLE = ?, MEETINGTIME = ?, ENROLLMENTLIMIT = ? WHERE SECTIONID = ?");


                            pstmt.setString(1, request.getParameter("QUARTERYEAR"));
                            pstmt.setString(2, request.getParameter("MEETINGTYPE"));
                            pstmt.setInt(3, Integer.parseInt(request.getParameter("MANDATORY")));
                            pstmt.setString(4, request.getParameter("BUILDING"));
                            pstmt.setString(5, request.getParameter("COURSETITLE"));
                            pstmt.setString(6, request.getParameter("MEETINGTIME"));
                            pstmt.setInt(7, Integer.parseInt(request.getParameter("ENROLLMENTLIMIT")));

                            pstmt.setInt(8, Integer.parseInt(request.getParameter("SECTIONID")));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);

                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM classes WHERE SectionId = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SECTIONID")));
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
                        ("SELECT * FROM CLASSES");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SectionId</th>
                        <th>QuarterYear</th>
                        <th>MeetingType</th>
                        <th>Mandatory</th>
                        <th>Building</th>
                        <th>CourseTitle</th>
                        <th>MeetingTime</th>
                        <th>EnrollmentLimit</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SECTIONID" size="10"></th>
                            <th><input value="" name="QUARTERYEAR" size="10"></th>
                            <th><input value="" name="MEETINGTYPE" size="15"></th>
                            <th><input value="" name="MANDATORY" size="15"></th>
                            <th><input value="" name="BUILDING" size="15"></th>
                            <th><input value="" name="COURSETITLE" size="15"></th>
                            <th><input value="" name="MEETINGTIME" size="15"></th>
                            <th><input value="" name="ENROLLMENTLIMIT" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SECTIONID") %>"
                                    name="SECTIONID" size="10">
                            </td>

                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("QUARTERYEAR") %>"
                                    name="QUARTERYEAR" size="10">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("MEETINGTYPE") %>"
                                    name="MEETINGTYPE" size="15">
                            </td>

                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getInt("MANDATORY") %>"
                                    name="MANDATORY" size="15">
                            </td>

                              <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("BUILDING") %>"
                                    name="BUILDING" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("COURSETITLE") %>"
                                    name="COURSETITLE" size="15">
                            </td>

                            <%-- Get the COLLEGE --%>
                            <td>
                                <input value="<%= rs.getString("MEETINGTIME") %>"
                                    name="MEETINGTIME" size="15">
                            </td>

                            <%-- Get the COLLEGE --%>
                            <td>
                                <input value="<%= rs.getInt("ENROLLMENTLIMIT") %>"
                                    name="ENROLLMENTLIMIT" size="15">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("SECTIONID") %>" name="SECTIONID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
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
