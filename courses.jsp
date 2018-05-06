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
                            "INSERT INTO Courses VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("COURSEID")));
                        pstmt.setString(2, request.getParameter("GRADEOPTION"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("LAB")));
                        pstmt.setString(4, request.getParameter("COURSETITLE"));
                        pstmt.setString(5, request.getParameter("DEPARTMENT"));

                        pstmt.setInt(6, Integer.parseInt(request.getParameter("UNITS")));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("FLEXIBLE")));

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
                            "UPDATE courses SET GRADEOPTION = ?, LAB = ?, " +
                            "COURSETITLE = ?, DEPARTMENT = ?, UNITS = ?,  FLEXIBLE = ? WHERE COURSEID = ?");


                            pstmt.setString(1, request.getParameter("GRADEOPTION"));
                            pstmt.setInt(2, Integer.parseInt(request.getParameter("LAB")));
                            pstmt.setString(3, request.getParameter("COURSETITLE"));
                            pstmt.setString(4, request.getParameter("DEPARTMENT"));

                            pstmt.setInt(5, Integer.parseInt(request.getParameter("UNITS")));
                            pstmt.setInt(6, Integer.parseInt(request.getParameter("FLEXIBLE")));
                            pstmt.setInt(7, Integer.parseInt(request.getParameter("COURSEID")));
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
                            "DELETE FROM Courses WHERE COURSEID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("COURSEID")));
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
                        ("SELECT * FROM COURSES");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>CourseId</th>
                        <th>GradeOption</th>
                        <th>Lab</th>
                        <th>CourseTitle</th>
                        <th>Department</th>
                        <th>Units</th>
                        <th>Flexible</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="COURSEID" size="10"></th>
                            <th><input value="" name="GRADEOPTION" size="10"></th>
                            <th><input value="" name="LAB" size="15"></th>
                            <th><input value="" name="COURSETITLE" size="15"></th>
                            <th><input value="" name="DEPARTMENT" size="15"></th>
                            <th><input value="" name="UNITS" size="15"></th>
                            <th><input value="" name="FLEXIBLE" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("COURSEID") %>"
                                    name="COURSEID" size="10">
                            </td>

                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("GRADEOPTION") %>"
                                    name="GRADEOPTION" size="10">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("LAB") %>"
                                    name="LAB" size="15">
                            </td>

                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("COURSETITLE") %>"
                                    name="COURSETITLE" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("DEPARTMENT") %>"
                                    name="DEPARTMENT" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("UNITS") %>"
                                    name="UNITS" size="15">
                            </td>


                            <td>
                                <input value="<%= rs.getString("FLEXIBLE") %>"
                                    name="FLEXIBLE" size="15">
                            </td>


                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("COURSEID") %>" name="COURSEID">
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
