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
                        // INSERT the DegreeRequirement attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO DegreeRequirement VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("Name"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("UnitsRequired")));
                        pstmt.setString(3, request.getParameter("MinGrade"));
                        pstmt.setString(4, request.getParameter("Category1"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("UnitsRequired1")));
                        pstmt.setString(6, request.getParameter("MinGrade1"));

                        pstmt.setString(7, request.getParameter("Category2"));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("UnitsRequired2")));
                        pstmt.setString(9, request.getParameter("MinGrade2"));

                        pstmt.setString(10, request.getParameter("Category3"));
                        pstmt.setInt(11, Integer.parseInt(request.getParameter("UnitsRequired3")));
                        pstmt.setString(12, request.getParameter("MinGrade3"));

                        pstmt.setString(13, request.getParameter("Concentration"));
                        pstmt.setInt(14, Integer.parseInt(request.getParameter("ConcentrationUnits")));
                        pstmt.setString(15, request.getParameter("ConcentrationMinGrade"));
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
                            "UPDATE DegreeRequirement SET PID = ?, Reason = ? ");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setString(2, request.getParameter("Reason"));
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
                            "DELETE FROM DegreeRequirement WHERE PID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PID")));
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
                        ("SELECT * FROM DegreeRequirement");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Name</th>
                        <th>UnitsRequired</th>
                        <th>MinGrade</th>
                        <th>Category1</th>
                        <th>UnitsRequired1</th>
                        <th>MinGrade1</th>
                        <th>Category2</th>
                        <th>UnitsRequired2</th>
                        <th>MinGrade2</th>
                        <th>Category3</th>
                        <th>UnitsRequired3</th>
                        <th>MinGrade3</th>
                        <th>Concentration</th>
                        <th>ConcentrationUnits</th>
                        <th>ConcentrationMinGrade</th>
                    </tr>
                    <tr>
                        <form action="DegreeRequirement.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="Name" size="20"></th>
                            <th><input value="" name="UnitsRequired" size="20"></th>
                            <th><input value="" name="MinGrade" size="20"></th>
                            <th><input value="" name="Category1" size="20"></th>
                            <th><input value="" name="UnitsRequired1" size="20"></th>
                            <th><input value="" name="MinGrade1" size="20"></th>
                            <th><input value="" name="Category2" size="20"></th>
                            <th><input value="" name="UnitsRequired2" size="20"></th>
                            <th><input value="" name="MinGrade2" size="20"></th>
                            <th><input value="" name="Category3" size="20"></th>
                            <th><input value="" name="UnitsRequired3" size="20"></th>
                            <th><input value="" name="MinGrade3" size="20"></th>
                            <th><input value="" name="Concentration" size="20"></th>
                            <th><input value="" name="ConcentrationUnits" size="20"></th>
                            <th><input value="" name="ConcentrationMinGrade" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="DegreeRequirement.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <td>
                                <input value="<%= rs.getInt("Name") %>"
                                    name="Name" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("UnitsRequired") %>"
                                    name="Reason" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("MinGrade") %>"
                                    name="MinGrade" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Category1") %>"
                                    name="Category1" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("UnitsRequired1") %>"
                                    name="Reason" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("MinGrade1") %>"
                                    name="MinGrade1" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Category2") %>"
                                    name="Category2" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("UnitsRequired2") %>"
                                    name="Reason" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("MinGrade2") %>"
                                    name="MinGrade2" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Category3") %>"
                                    name="Category3" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("UnitsRequired3") %>"
                                    name="Reason" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("MinGrade3") %>"
                                    name="MinGrade3" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("Concentration") %>"
                                    name="Concentration" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("ConcentrationUnits") %>"
                                    name="ConcentrationUnits" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("ConcentrationMinGrade") %>"
                                    name="ConcentrationMinGrade" size="20">
                            </td>
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="DegreeRequirement.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("Name") %>" name="Name">
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
