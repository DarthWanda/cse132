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
                            "INSERT INTO schedule VALUES (?, ?, ?, ?, ?,?)");

                            pstmt.setString(1, request.getParameter("FIRSTNAME"));
                           pstmt.setString(2, request.getParameter("COURSENUMBER"));
                            pstmt.setString(3, request.getParameter("QUARTERYEAR"));
                            pstmt.setString(4, request.getParameter("GRADEOPTION"));
                            pstmt.setInt(5, Integer.parseInt(request.getParameter("UNIT")));
                            pstmt.setString(6, request.getParameter("GRADE"));


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
                            "UPDATE schedule SET QUARTERYEAR = ?, GRADEOPTION = ?,UNIT = ?, GRADE = ? WHERE FIRSTNAME = ? AND COURSENUMBER = ?");

                        pstmt.setString(1, request.getParameter("QUARTERYEAR"));
                        pstmt.setString(2, request.getParameter("GRADEOPTION"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("UNIT")));
                        pstmt.setString(4, request.getParameter("GRADE"));

                        pstmt.setString(5, request.getParameter("FIRSTNAME"));
                        pstmt.setString(6, request.getParameter("COURSENUMBER"));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);

                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Schedule WHERE FIRSTNAME = ? AND COURSENUMBER = ?");

                        pstmt.setString(1, request.getParameter("FIRSTNAME"));
                        pstmt.setString(2, request.getParameter("COURSENUMBER"));
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
                        ("SELECT * FROM Schedule");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>FIRSTNAME</th>
                        <th>COURSENUMBER</th>
                        <th>QUARTERYEAR</th>
                        <th>GRADEOPTION</th>
                        <th>UNIT</th>
                        <th>GRADE</th>


                    </tr>
                    <tr>
                        <form action="schedule.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="FIRSTNAME" size="10"></th>
                            <th><input value="" name="COURSENUMBER" size="10"></th>
                            <th><input value="" name="QUARTERYEAR" size="15"></th>
                            <th><input value="" name="GRADEOPTION" size="15"></th>
                            <th><input value="" name="UNIT" size="15"></th>
                            <th><input value="" name="GRADE" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="schedule.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("FIRSTNAME") %>"
                                    name="FIRSTNAME" size="10">
                            </td>

                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("COURSENUMBER") %>"
                                    name="COURSENUMBER" size="10">
                            </td>

                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("QUARTERYEAR") %>"
                                    name="QUARTERYEAR" size="15">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("GRADEOPTION") %>"
                                    name="GRADEOPTION" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("UNIT") %>"
                                    name="UNIT" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("GRADE") %>"
                                    name="GRADE" size="15">
                            </td>


                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="schedule.jsp" method="get">
                            <input type="hidden" value="delete" name="action">

                            <input type="hidden"
                                value="<%= rs.getString("FIRSTNAME") %>" name="FIRSTNAME">

                            <input type="hidden"
                                value="<%= rs.getString("COURSENUMBER") %>" name="COURSENUMBER">

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
