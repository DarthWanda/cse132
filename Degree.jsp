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
                            "INSERT INTO degreerequirement VALUES (?, ?, ?, ?, ?, ?)");


                        pstmt.setString(1, request.getParameter("degreename"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("TotalUnits")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("LowerDivUnits")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("UpperDivUnits")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("TechUnits")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("gradUnits")));
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
                            "UPDATE degreerequirement SET TotalUnits = ?, LowerDivUnits = ?, UpperDivUnits = ?, TechUnits = ?, gradUnits = ? WHERE DegreeName= ?");


                        pstmt.setInt(1, Integer.parseInt(request.getParameter("TotalUnits")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("LowerDivUnits")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("UpperDivUnits")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("TechUnits")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("gradUnits")));
                        pstmt.setString(6, request.getParameter("DegreeName"));
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
                          "DELETE FROM degreerequirement WHERE DegreeName = ?");

                          pstmt.setString(
                              1, request.getParameter("DegreeName"));
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
                    <th>DegreeName</th>
                    <th>TotalUnits</th>
                    <th>LowerDivUnits</th>
                    <th>UpperDivUnits</th>
                    <th>TechUnits</th>
                    <th>GradUnits</th>
                    </tr>
                    <tr>
                        <form action="Degree.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="DegreeName" size="20"></th>
                            <th><input value="" name="TotalUnits" size="20"></th>
                            <th><input value="" name="LowerDivUnits" size="20"></th>
                            <th><input value="" name="UpperDivUnits" size="20"></th>
                            <th><input value="" name="TechUnits" size="20"></th>
                            <th><input value="" name="GradUnits" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="Degree.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("DegreeName") %>"
                                    name="DegreeName" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("TotalUnits") %>"
                                    name="TotalUnits" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("LowerDivUnits") %>"
                                    name="LowerDivUnits" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("UpperDivUnits") %>"
                                    name="UpperDivUnits" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("TechUnits") %>"
                                    name="TechUnits" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("gradUnits") %>"
                                    name="gradUnits" size="20">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="Degree.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getString("DegreeName") %>" name="DegreeName">
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
