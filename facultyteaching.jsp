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
                            "INSERT INTO facultyteaching VALUES (?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("id"));
                        pstmt.setString(2, request.getParameter("Name"));
                        pstmt.setString(3, request.getParameter("CourseNumber"));
                        pstmt.setString(4, request.getParameter("Section"));
                        pstmt.setString(5, request.getParameter("QuarterYear"));
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
                            "UPDATE facultyteaching SET Name = ?, CourseNumber = ?, Section = ?, QuarterYear = ? WHERE id = ?");

                        pstmt.setString(1, request.getParameter("Name"));
                        pstmt.setString(2, request.getParameter("CourseNumber"));
                        pstmt.setString(3, request.getParameter("Section"));
                        pstmt.setString(4, request.getParameter("QuarterYear"));
                        pstmt.setString(5, request.getParameter("id"));

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
                            "DELETE FROM facultyteaching WHERE id = ?");

                            pstmt.setString(1, request.getParameter("id"));
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
                        ("SELECT * FROM facultyteaching");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>id</th>
                        <th>Name</th>
                        <th>CourseNumber</th>
                        <th>Section</th>
                        <th>QuarterYear</th>
                    </tr>
                    <tr>
                        <form action="facultyteaching.jsp" method="get">
                            <input type="hidden" value="insert" Name="action">
                            <th><input value="" Name="id" size="15"></th>
                            <th><input value="" Name="Name" size="15"></th>
                            <th><input value="" Name="CourseNumber" size="10"></th>
                            <th><input value="" Name="Section" size="15"></th>
                            <th><input value="" Name="QuarterYear" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="facultyteaching.jsp" method="get">
                            <input type="hidden" value="update" Name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("id") %>"
                                    Name="id" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Name") %>"
                                    Name="Name" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("CourseNumber") %>"
                                    Name="CourseNumber" size="10">
                            </td>

                            <%-- Get the ID --%>

                            <td>
                                <input value="<%= rs.getString("Section") %>"
                                    Name="Section" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("QuarterYear") %>"
                                    Name="QuarterYear" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="facultyteaching.jsp" method="get">
                            <input type="hidden" value="delete" Name="action">
                            <input type="hidden"
                                value="<%= rs.getString("id") %>" Name="id">
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
