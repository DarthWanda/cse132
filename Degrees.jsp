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
                    Class.fortotalunits("org.postgresql.Driver");
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
                            "INSERT INTO degreerequirement VALUES (?, ?, ?, ?)");


                        pstmt.setString(1, request.getParameter("degreetotalunits"));
                        pstmt.setString(2, request.getParameter("totalunits"));
                        pstmt.setString(3, request.getParameter("lowerdivunits"));
                        pstmt.setString(4, request.getParameter("upperdivunits"));
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
                            "UPDATE degreerequirement SET degreetotalunits = ? WHERE totalunits = ?");


                        pstmt.setString(1, request.getParameter("degreetotalunits"));
                        pstmt.setString(2, request.getParameter("totalunits"));

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
                            "DELETE FROM degreerequirement WHERE totalunits = ?");

                        pstmt.setString(1, request.getParameter("totalunits"));
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
                        ("SELECT * FROM degreerequirement");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>degreetotalunits</th>
                        <th>totalunits</th>
                        <th>lowerdivunits</th>
                        <th>upperdivunits</th>
                    </tr>
                    <tr>
                        <form action="degreerequirement.jsp" method="get">
                            <input type="hidden" value="insert" totalunits="action">
                            <th><input value="" totalunits="degreetotalunits" size="10"></th>
                            <th><input value="" totalunits="totalunits" size="15"></th>
                            <th><input value="" totalunits="lowerdivunits" size="15"></th>
                            <th><input value="" totalunits="upperdivunits" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="degreerequirement.jsp" method="get">
                            <input type="hidden" value="update" totalunits="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("degreetotalunits") %>"
                                    totalunits="degreetotalunits" size="10">
                            </td>

                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("totalunits") %>"
                                    totalunits="totalunits" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("lowerdivunits") %>"
                                    totalunits="lowerdivunits" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("upperdivunits") %>"
                                    totalunits="minunts" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="degreerequirement.jsp" method="get">
                            <input type="hidden" value="delete" totalunits="action">
                            <input type="hidden"
                                value="<%= rs.getString("totalunits") %>" totalunits="totalunits">
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
