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
                    ResultSet rs;
            %>



            <%-- -------- FrameWork Code -------- --%>
            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course Number</th>
                        <th>Professor Name</th>
                        <th>Quarter Year</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="p3n.jsp" method="get">
                            <input type="hidden" value="query" name="action">
                            <th><input value="" name="COURSENUMBER" size="10"></th>
                            <th><input value="" name="NAME" size="10"></th>
                            <th><input value="" name="QUARTERYEAR" size="10"></th>
                            <th><input type="submit" value="Query"></th>
                        </form>
                    </tr>

            <%-- -------- Query Statement Code -------- --%>
            <%
                    String action = request.getParameter("action");

                    if (action != null && action.equals("query")) {
                      PreparedStatement pstmt = conn.prepareStatement(
                          "Select counta, countb, countc, countd, countother from cpqg where coursenumber = ? and name = ? and quarteryear = ?"
                          );

                      pstmt.setString(1, request.getParameter("COURSENUMBER"));
                      pstmt.setString(2, request.getParameter("NAME"));
                      pstmt.setString(3, request.getParameter("QUARTERYEAR"));



                      rs = pstmt.executeQuery();

                        %>
                        <tr><th>Grade Info:</th></tr>
                        <tr>
                            <th>A</th>
                            <th>B</th>
                            <th>C</th>
                            <th>D</th>
                            <th>Others</th>
                        </tr>

                        <%
                      while ( rs.next() ) {

                        %>

                      <tr>
                          <form action="p3n.jsp" method="get">

                              <td>
                                  <input value="<%= rs.getInt("counta") %>"
                                      name="geta" size="20">
                              </td>

                              <td>
                                  <input value="<%= rs.getInt("countb") %>"
                                      name="getb" size="20">
                              </td>


                              <td>
                                  <input value="<%= rs.getInt("countc") %>"
                                      name="getc" size="20">
                              </td>

                              <td>
                                  <input value="<%= rs.getInt("countd") %>"
                                      name="getd" size="20">
                              </td>

                              <td>
                                  <input value="<%= rs.getInt("countother") %>"
                                      name="getother" size="20">
                              </td>

                          </form>
                      </tr>
                      <%
                      }
                    }

                      %>




            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    // rs1.close();
                    //
                    // // Close the Statement
                    // statement.close();
                    //
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
