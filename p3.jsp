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
                        <form action="p3.jsp" method="get">
                            <input type="hidden" value="query" name="action">
                            <th><input value="" name="coursenumber" size="10"></th>
                            <th><input value="" name="professorname" size="10"></th>
                            <th><input value="" name="quarteryear" size="10"></th>
                            <th><input type="submit" value="Query"></th>
                        </form>
                    </tr>

            <%-- -------- Query Statement Code -------- --%>
            <%
                    String action = request.getParameter("action");

                    if (action != null && action.equals("query")) {
                      String req =  "Select grade, NUMBER_GRADE, avg(NUMBER_GRADE) AS avg, count(grade) AS gradecount from facultyteaching, schedule, GRADE_CONVERSION where GRADE_CONVERSION.LETTER_GRADE = GRADE and schedule.coursenumber = facultyteaching.coursenumber and schedule.quarteryear = facultyteaching.quarteryear";
                      String req2 =  "Select cast(avg(1.0 * number_grade) as decimal(10, 2)) as ag from facultyteaching, schedule, GRADE_CONVERSION where GRADE_CONVERSION.LETTER_GRADE = GRADE and schedule.coursenumber = facultyteaching.coursenumber and schedule.quarteryear = facultyteaching.quarteryear";


                      if (request.getParameter("coursenumber") != ""){
                        req = req + " and facultyteaching.coursenumber = " + "\'" +request.getParameter("coursenumber") + "\'"  ;
                        req2 = req2 + " and facultyteaching.coursenumber = " + "\'" +request.getParameter("coursenumber") + "\'"  ;

                      }

                      if (request.getParameter("professorname") != ""){
                        req = req + " and facultyteaching.name = " + "\'" +request.getParameter("professorname") + "\'"  ;
                        req2 = req2 + " and facultyteaching.name = " + "\'" +request.getParameter("professorname") + "\'"  ;

                      }

                      if (request.getParameter("quarteryear") != ""){
                        req = req + " and facultyteaching.quarteryear = " + "\'" +request.getParameter("quarteryear") + "\'"  ;
                        req2 = req2 + " and facultyteaching.quarteryear = " + "\'" +request.getParameter("quarteryear") + "\'"  ;

                      }


                      req += " group by grade, NUMBER_GRADE";
                      PreparedStatement pstmt = conn.prepareStatement(req);

                      PreparedStatement pstmt1 = conn.prepareStatement(req2);
                      rs2 = pstmt1.executeQuery();

                      rs1 = pstmt.executeQuery();

                        %>
                        <tr><th>Grade Info:</th></tr>
                        <tr>
                            <th>Letter Grade</th>
                            <th>Number Grade</th>
                            <th>Numbers</th>
                        </tr>

                        <%
                      while ( rs1.next() ) {

                        %>

                      <tr>
                          <form action="p3.jsp" method="get">

                              <td>
                                  <input value="<%= rs1.getString("grade") %>"
                                      name="grade" size="10">
                              </td>

                              <td>
                                  <input value="<%= rs1.getString("NUMBER_GRADE") %>"
                                      name="num" size="10">
                              </td>


                              <td>
                                  <input value="<%= rs1.getString("gradecount") %>"
                                      name="GPA" size="20">
                              </td>

                          </form>
                      </tr>
                      <%
                      }


                      %>
                      <tr><th>Average Grade:</th></tr>
                      <%
                      while ( rs2.next() ) {

                      %>
                      <tr>
                        <form action="p3.jsp" method="get">
                          <td>
                              <input value="<%= rs2.getDouble("ag") %>"
                                  name="Average" size="20">
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
