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
                            "INSERT INTO Enrollment VALUES (?, ?, ?,?)");

                       pstmt.setString(1, request.getParameter("FIRSTNAME"));
                       pstmt.setInt(2, Integer.parseInt(request.getParameter("SECTIONNUMBER")));
                       pstmt.setString(3, request.getParameter("GRADEOPTION"));
                       pstmt.setInt(4, Integer.parseInt(request.getParameter("UNITS")));

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
                            "UPDATE Enrollment SET GRADEOPTION  = ?, UNITS = ? WHERE FIRSTNAME = ? AND SECTIONNUMBER = ?");


                            pstmt.setString(1, request.getParameter("GRADEOPTION"));
                            pstmt.setInt(2, Integer.parseInt(request.getParameter("UNITS")));
                            pstmt.setString(3, request.getParameter("FIRSTNAME"));
                            pstmt.setInt(4, Integer.parseInt(request.getParameter("SECTIONNUMBER")));


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
                            "DELETE FROM Enrollment WHERE FIRSTNAME = ? AND SECTIONNUMBER = ?");

                            pstmt.setString(1, request.getParameter("FIRSTNAME"));
                            pstmt.setInt(2, Integer.parseInt(request.getParameter("SECTIONNUMBER")));
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
                        ("SELECT * FROM Enrollment");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>FIRSTNAME</th>
                        <th>SECTIONNUMBER</th>
                        <th>GRADEOPTION</th>
                        <th>UNITS</th>
                    </tr>
                    <tr>
                        <form action="enrollment.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="FIRSTNAME" size="10"></th>
                            <th><input value="" name="SECTIONNUMBER" size="15"></th>
                            <th><input value="" name="GRADEOPTION" size="15"></th>
                            <th><input value="" name="UNITS" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="enrollment.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <td>
                                <input value="<%= rs.getString("FIRSTNAME") %>"
                                    name="FIRSTNAME" size="10">
                            </td>


                            <td>
                                <input value="<%= rs.getInt("SECTIONNUMBER") %>"
                                    name="SECTIONNUMBER" size="10">
                            </td>


                            <td>
                                <input value="<%= rs.getString("GRADEOPTION") %>"
                                    name="GRADEOPTION" size="10">
                            </td>


                            <td>
                                <input value="<%= rs.getInt("UNITS") %>"
                                    name="UNITS" size="10">
                            </td>



                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="enrollment.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getString("FIRSTNAME") %>" name="FIRSTNAME">
                            <input type="hidden"
                                value="<%= rs.getInt("SECTIONNUMBER") %>" name="SECTIONNUMBER">
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
