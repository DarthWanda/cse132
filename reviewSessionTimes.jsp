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
                    ResultSet rs1;
                    ResultSet rs2;
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("select title, coursenumber,QuarterOffer, CurrentlyTaught, NextOffered from classes where classes.coursenumber in (select section.coursenumber from Section, Classes, Enrollment WHERE Enrollment.sectionnumber = Section.Sectionnumber Group by section.sectionnumber)");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr> Sections in current QUARTER </tr>
                    <tr>
                        <th>Title</th>
                        <th>Coursenumber</th>
                        <th>QuarterOffer</th>
                        <th>CurrentlyTaught</th>
                        <th>NextOffered</th>
                    </tr>


            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("Title") %>"
                                    name="Title" size="10">
                            </td>


                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("Coursenumber") %>"
                                    name="Coursenumber" size="20">
                            </td>

                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("QuarterOffer") %>"
                                    name="QuarterOffer" size="20">
                            </td>


                            <td>
                                <input value="<%= rs.getString("CurrentlyTaught") %>"
                                    name="CurrentlyTaught" size="20">
                            </td>
                            <td>
                                <input value="<%= rs.getString("NextOffered") %>"
                                    name="NextOffered" size="20">
                            </td>

                    </tr>

            <%
                    }
                      %>


// code to display section

                      <%
                      Statement statement1 = conn.createStatement();
                      ResultSet rsSection = statement1.executeQuery
                      ("select section.sectionnumber, section.coursenumber from section");

                      %>

                      <tr> information codes </tr>
                      <tr>
                          <th>SectionNumber</th>
                          <th>Coursenumber</th>
                      </tr>

                      <%
                              while ( rsSection.next() ) {
                      %>
                                    <tr>
                                        <td>
                                            <input value="<%= rsSection.getString("SectionNumber") %>"
                                              name="SectionNumber" size="10">
                                            </td>
                                            <td>
                                                <input value="<%= rsSection.getString("CourseNumber") %>"
                                                    name="CourseNumber" size="10">
                                            </td>
                                            </tr>
    <%
                        }
    %>

            <%-- -------- FrameWork Code -------- --%>
            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SectionNumber</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="reviewSessionTimes.jsp" method="get">
                            <input type="hidden" value="query" name="action">
                            <th><input value="" name="SectionNumber" size="10"></th>
                            <th><input type="submit" value="Query"></th>
                        </form>
                    </tr>

            <%-- -------- Query Statement Code -------- --%>
            <%
                    String action = request.getParameter("action");

                    if (action != null && action.equals("query")) {
                      PreparedStatement pstmt = conn.prepareStatement(
                          "select distinct time from event where time not in (select distinct time from event WHERE Monday  IN(Select sectionNumber from enrollment where enrollment.sectionnumber !=? AND enrollment.firstname IN (SELECT Firstname FROM enrollment Where sectionnumber =?))) order by time desc");
                      pstmt.setInt(1, Integer.parseInt(request.getParameter("SectionNumber")));
                      pstmt.setInt(2, Integer.parseInt(request.getParameter("SectionNumber")));
                      rs1 = pstmt.executeQuery();
  %>
                    <tr><th>times on monday student:</th></tr>
                    <tr>
                        <th>time</th>
                    </tr>
                      <%
                      while ( rs1.next() ) {

                        %>


                      <tr>
                          <form action="reviewSessionTimes.jsp" method="get">


                              <%-- Get the SSN, which is a number --%>
                              <td>
                                  <input value="<%= rs1.getInt("Time") %>"
                                      name="time" size="10">
                              </td>
                          </form>
                      </tr>
                      <%
                      }
                    %>


                    <%
                            action = request.getParameter("action");

                            if (action != null && action.equals("query")) {
                              pstmt = conn.prepareStatement(
                                  "select distinct time from event where time not in (select distinct time from event WHERE TUESDAY  IN(Select sectionNumber from enrollment where enrollment.sectionnumber !=? AND enrollment.firstname IN (SELECT Firstname FROM enrollment Where sectionnumber =?))) order by time desc");
                              pstmt.setInt(1, Integer.parseInt(request.getParameter("SectionNumber")));
                              pstmt.setInt(2, Integer.parseInt(request.getParameter("SectionNumber")));
                              rs1 = pstmt.executeQuery();
          %>
                            <tr><th>times on tuesday  student:</th></tr>
                            <tr>
                                <th>time</th>
                            </tr>
                              <%
                              while ( rs1.next() ) {

                                %>

                              <tr>
                                  <form action="reviewSessionTimes.jsp" method="get">
                                      <%-- Get the SSN, which is a number --%>
                                      <td>
                                          <input value="<%= rs1.getInt("Time") %>"
                                              name="time" size="10">
                                      </td>
                                  </form>
                              </tr>
                              <%
                              }
                            }
                            %>

                            <%
                                    action = request.getParameter("action");

                                    if (action != null && action.equals("query")) {
                                      pstmt = conn.prepareStatement(
                                          "select distinct time from event where time not in (select distinct time from event WHERE WEDNESDAY  IN(Select sectionNumber from enrollment where enrollment.sectionnumber !=? AND enrollment.firstname IN (SELECT Firstname FROM enrollment Where sectionnumber =?))) order by time desc");
                                      pstmt.setInt(1, Integer.parseInt(request.getParameter("SectionNumber")));
                                      pstmt.setInt(2, Integer.parseInt(request.getParameter("SectionNumber")));
                                      rs1 = pstmt.executeQuery();
                  %>
                                    <tr><th>times on WEDNESDAY  student:</th></tr>
                                    <tr>
                                        <th>time</th>
                                    </tr>
                                      <%
                                      while ( rs1.next() ) {

                                        %>

                                      <tr>
                                          <form action="reviewSessionTimes.jsp" method="get">
                                              <%-- Get the SSN, which is a number --%>
                                              <td>
                                                  <input value="<%= rs1.getInt("Time") %>"
                                                      name="time" size="10">
                                              </td>
                                          </form>
                                      </tr>
                                      <%
                                      }
                                    }
                                    %>

                                    <%
                                            action = request.getParameter("action");

                                            if (action != null && action.equals("query")) {
                                              pstmt = conn.prepareStatement(
                                                  "select distinct time from event where time not in (select distinct time from event WHERE THURSDAY  IN(Select sectionNumber from enrollment where enrollment.sectionnumber !=? AND enrollment.firstname IN (SELECT Firstname FROM enrollment Where sectionnumber =?))) order by time desc");
                                              pstmt.setInt(1, Integer.parseInt(request.getParameter("SectionNumber")));
                                              pstmt.setInt(2, Integer.parseInt(request.getParameter("SectionNumber")));
                                              rs1 = pstmt.executeQuery();
                          %>
                                            <tr><th>times on THURSDAY</th></tr>
                                            <tr>
                                                <th>time</th>
                                            </tr>
                                              <%
                                              while ( rs1.next() ) {

                                                %>

                                              <tr>
                                                  <form action="reviewSessionTimes.jsp" method="get">
                                                      <%-- Get the SSN, which is a number --%>
                                                      <td>
                                                          <input value="<%= rs1.getInt("Time") %>"
                                                              name="time" size="10">
                                                      </td>
                                                  </form>
                                              </tr>
                                              <%
                                              }
                                            }
                                            %>

                                            <%
                                                    action = request.getParameter("action");

                                                    if (action != null && action.equals("query")) {
                                                      pstmt = conn.prepareStatement(
                                                          "select distinct time from event where time not in (select distinct time from event WHERE FRIDAY IN(Select sectionNumber from enrollment where enrollment.sectionnumber !=? AND enrollment.firstname IN (SELECT Firstname FROM enrollment Where sectionnumber =?))) order by time desc");
                                                      pstmt.setInt(1, Integer.parseInt(request.getParameter("SectionNumber")));
                                                      pstmt.setInt(2, Integer.parseInt(request.getParameter("SectionNumber")));
                                                      rs1 = pstmt.executeQuery();
                                  %>
                                                    <tr><th>times on Friday</th></tr>
                                                    <tr>
                                                        <th>time</th>
                                                    </tr>
                                                      <%
                                                      while ( rs1.next() ) {

                                                        %>

                                                      <tr>
                                                          <form action="reviewSessionTimes.jsp" method="get">
                                                              <%-- Get the SSN, which is a number --%>
                                                              <td>
                                                                  <input value="<%= rs1.getInt("Time") %>"
                                                                      name="time" size="10">
                                                              </td>
                                                          </form>
                                                      </tr>
                                                      <%
                                                      }
                                                    }
                                                    %>

                    //
  <%
                    }
            %>


            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    // rs1.close();
                    //
                    // // Close the Statement
                    // statement.close();

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
