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
                        // INSERT the thesisCommittee attributes INTO the thesisCommittee table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO thesisCommittee VALUES (?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("TID")));
                        pstmt.setString(2, request.getParameter("Name1"));
                        pstmt.setString(3, request.getParameter("Name2"));
                        pstmt.setString(4, request.getParameter("Name3"));
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
                        // UPDATE the thesisCommittee attributes in the thesisCommittee table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE thesisCommittee SET TID = ?, Name1 = ?, Name2 = ?, Name3 = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("TID")));
                        pstmt.setString(2, request.getParameter("Name1"));
                        pstmt.setString(3, request.getParameter("Name2"));
                        pstmt.setString(4, request.getParameter("Name3"));
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
                        // DELETE the thesisCommittee FROM the thesisCommittee table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM thesisCommittee WHERE TID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("TID")));
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
                    // the thesisCommittee attributes FROM the thesisCommittee table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM thesisCommittee");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>TID</th>
                        <th>Name1</th>
                        <th>Name2</th>
                        <th>Name3</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="thesisCommittee.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="TID" size="10"></th>
                            <th><input value="" name="Name1" size="20"></th>
                            <th><input value="" name="Name2" size="20"></th>
                            <th><input value="" name="Name3" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="thesisCommittee.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("TID") %>"
                                    name="TID" size="10">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("Name1") %>"
                                    name="Name1" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("Name2") %>"
                                    name="Name2" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("Name3") %>"
                                    name="Name3" size="20">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="thesisCommittee.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("TID") %>" name="TID">
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
