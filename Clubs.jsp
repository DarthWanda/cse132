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
                        // INSERT the Clubs attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Clubs VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ClubID")));
                        pstmt.setString(2, request.getParameter("Name"));
                        pstmt.setString(3, request.getParameter("Advisor"));
                        pstmt.setString(4, request.getParameter("MeetingPlace"));
                        pstmt.setString(5, request.getParameter("Description"));

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
                            "UPDATE Clubs SET ClubID = ?, Name = ?, Advisor = ?, MeetingPlace = ?, Description = ? ");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ClubID")));
                        pstmt.setString(2, request.getParameter("Name"));
                        pstmt.setString(3, request.getParameter("Advisor"));
                        pstmt.setString(4, request.getParameter("MeetingPlace"));
                        pstmt.setString(5, request.getParameter("Description"));
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
                            "DELETE FROM Clubs WHERE ClubID= ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ClubID")));
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
                        ("SELECT * FROM Clubs");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>ClubID</th>
                        <th>Name</th>
                        <th>Advisor</th>
                        <th>MeetingPlace</th>
                        <th>Description</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="Clubs.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ClubID" size="10"></th>
                            <th><input value="" name="Name" size="10"></th>
                            <th><input value="" name="Advisor" size="20"></th>
                            <th><input value="" name="MeetingPlace" size="20"></th>
                            <th><input value="" name="Description" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="Clubs.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <td>
                                <input value="<%= rs.getInt("ClubID") %>"
                                    name="ClubID" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("Name") %>"
                                    name="Name" size="10">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("Advisor") %>"
                                    name="Advisor" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("MeetingPlace") %>"
                                    name="MeetingPlace" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Description") %>"
                                    name="Description" size="20">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="Clubs.jsp" method="get">
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
