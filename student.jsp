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
                            "INSERT INTO Student VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("SocialSecurity")));
                        pstmt.setString(3, request.getParameter("FirstName"));
                        pstmt.setString(4, request.getParameter("MiddleName"));
                        pstmt.setString(5, request.getParameter("LastName"));
                        pstmt.setString(6, request.getParameter("College"));
                        pstmt.setString(7, request.getParameter("Enrolled"));
                        pstmt.setString(8, request.getParameter("Major"));
                        pstmt.setString(9, request.getParameter("Minor"));
                        pstmt.setString(10, request.getParameter("Residency"));
                        pstmt.setString(11, request.getParameter("Department"));
                        pstmt.setString(12, request.getParameter("Program"));
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
                            "UPDATE Student SET FIRSTNAME = ?, " +
                            "LASTNAME = ?, PROGRAM = ? WHERE SocialSecurity = ?");


                        pstmt.setString(1, request.getParameter("FIRSTNAME"));
                        pstmt.setString(2, request.getParameter("LASTNAME"));
                        pstmt.setString(3, request.getParameter("PROGRAM"));
                        pstmt.setInt(  4, Integer.parseInt(request.getParameter("SocialSecurity")));
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

                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Student WHERE SocialSecurity = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SocialSecurity")));
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
                        ("SELECT * FROM Student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SocialSecurity</th>
                        <th>PID</th>
                        <th>FirstName</th>
                        <th>MiddleName</th>
                        <th>LastName</th>
                        <th>College</th>
                        <th>Enrolled</th>
                        <th>Major</th>
                        <th>Minor</th>
                        <th>Residency</th>
                        <th>Department</th>
                        <th>Program</th>
                    </tr>
                    <tr>
                        <form action="student.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SocialSecurity" size="10"></th>
                            <th><input value="" name="PID" size="10"></th>
                            <th><input value="" name="FirstName" size="20"></th>
                            <th><input value="" name="MiddleName" size="20"></th>
                            <th><input value="" name="LastName" size="20"></th>
                            <th><input value="" name="College" size="20"></th>
                            <th><input value="" name="Enrolled" size="20"></th>
                            <th><input value="" name="Major" size="20"></th>
                            <th><input value="" name="Minor" size="20"></th>
                            <th><input value="" name="Residency" size="20"></th>
                            <th><input value="" name="Department" size="20"></th>
                            <th><input value="" name="Program" size="20"></th>

                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="student.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SocialSecurity, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SocialSecurity") %>"
                                    name="SocialSecurity" size="10">
                            </td>

                            <%-- Get the PID --%>
                            <td>
                                <input value="<%= rs.getString("PID") %>"
                                    name="PID" size="10">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("FirstName") %>"
                                    name="FirstName" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("MiddleName") %>"
                                    name="MiddleName" size="20">
                            </td>



                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("LastName") %>"
                                    name="LastName" size="20">
                            </td>

                            <%-- Get the COLLEGE --%>
                            <td>
                                <input value="<%= rs.getString("College") %>"
                                    name="College" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Enrolled") %>"
                                    name="Enrolled" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Major") %>"
                                    name="Major" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("Minor") %>"
                                    name="Minor" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("Residency") %>"
                                    name="Residency" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Department") %>"
                                    name="Department" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Program") %>"
                                    name="Program" size="20">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="student.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("SocialSecurity") %>" name="SocialSecurity">
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
