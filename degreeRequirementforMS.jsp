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
                        ("SELECT DISTINCT SocialSecurity,Student.FirstName,LastName,MiddleName FROM Student, Enrollment WHERE Student.FIRSTNAME = enrollment.firstname AND program LIKE 'M%'");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr> Student enrolled </tr>
                    <tr>
                        <th>SocialSecurity</th>
                        <th>FirstName</th>
                        <th>LastName</th>
                        <th>MiddleName</th>
                    </tr>




            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SocialSecurity") %>"
                                    name="SocialSecurity" size="10">
                            </td>


                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("FirstName") %>"
                                    name="FirstName" size="20">
                            </td>

                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("LastName") %>"
                                    name="LastName" size="20">
                            </td>

                            <td>
                                <input value="<%= rs.getString("MiddleName") %>"
                                    name="MiddleName" size="20">
                            </td>

                    </tr>
            <%
                    }

                            // Iterate over the ResultSet



                    %>

   <%
            ResultSet rsdegree = statement.executeQuery
                ("SELECT degreename, totalunits FROM degreerequirement WHERE degreename LIKE 'M%'");

  %>
  <tr> Degree information </tr>
  <tr>
      <th>degreename</th>
      <th>totalunits</th>
  </tr>

 <%
  while ( rsdegree.next() ) {

      %>

      <tr>

              <td>
                  <input value="<%= rsdegree.getString("degreename") %>"
                      name="degreename" size="20">
              </td>

              <%-- Get the LASTNAME --%>
              <td>
                  <input value="<%= rsdegree.getString("totalunits") %>"
                      name="totalunits" size="20">
              </td>

      </tr>

      <%
              }

                      // Iterate over the ResultSet

              %>

            <%-- -------- FrameWork Code -------- --%>
            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>DegreeName</th>
                        <th>SSN</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="degreeRequirementforMS.jsp" method="get">
                            <input type="hidden" value="query" name="action">
                            <th><input value="" name="Degreename" size="40"></th>
                            <th><input value="" name="SocialSecurity" size="10"></th>

                            <th><input type="submit" value="Query"></th>
                        </form>
                    </tr>

                    <tr><th>Concentration</th></tr>

            <%-- -------- Query Statement Code -------- --%>
            <%
                    String action = request.getParameter("action");

                    if (action != null && action.equals("query")) {
                      PreparedStatement pstmt = conn.prepareStatement("(Select name as Systems from schedule,student, concentration where concentration.courseName = schedule.courseNumber AND concentration.courseName = 'CSE221'AND schedule.gradeint >=3.3 AND schedule.firstname = student.firstname AND schedule.firstname IN (select student.firstname from student where student.socialsecurity = ?))");
                      pstmt.setInt(1, Integer.parseInt(request.getParameter("SocialSecurity")));
                      rs1 = pstmt.executeQuery();

                      while ( rs1.next() ) {


                        %>
                        <tr><th>Systems</th></tr>
                      <tr>
                          <form action="degreeRequirementforMS.jsp" method="get">

                              <%-- Get the SSN, which is a number --%>
                              <td>
                                  <input value="<%= rs1.getInt("Systems") %>"
                                      name="Systems" size="10">
                              </td>
                          </form>
                      </tr>
                      <%
                      }
                    }

                    String action1 = request.getParameter("action");

                    if (action != null && action1.equals("query")) {
                       PreparedStatement pstmt = conn.prepareStatement("(Select name as database from schedule,student, concentration where concentration.courseName = schedule.courseNumber AND concentration.courseName = 'CSE232A'AND schedule.firstname = student.firstname AND schedule.firstname IN (select student.firstname from student where student.socialsecurity = ?))");
                      pstmt.setInt(1, Integer.parseInt(request.getParameter("SocialSecurity")));
                      rs1 = pstmt.executeQuery();

                      while ( rs1.next() ) {

                        %>
                        <tr><th>database</th></tr>
                      <tr>
                          <form action="degreeRequirementforMS.jsp" method="get">
                              <%-- Get the SSN, which is a number --%>
                              <td>
                                  <input value="<%= rs1.getInt("database") %>"
                                      name="database" size="10">
                              </td>
                          </form>
                      </tr>
                      <%

                    }
                  }


            String action2 = request.getParameter("action");

            if (action != null && action2.equals("query")) {
               PreparedStatement pstmt = conn.prepareStatement("(Select name as ai from schedule,student, concentration where concentration.courseName = schedule.courseNumber AND concentration.courseName = 'CSE250A'AND schedule.firstname = student.firstname AND schedule.firstname IN (select student.firstname from student where student.socialsecurity = ?)AND concentration.name in (Select name from schedule,student, concentration where concentration.courseName = schedule.courseNumber AND concentration.courseName = 'CSE255'AND schedule.firstname = student.firstname AND schedule.firstname IN (select student.firstname from student where student.socialsecurity = ?)))");
              pstmt.setInt(1, Integer.parseInt(request.getParameter("SocialSecurity")));
              pstmt.setInt(2, Integer.parseInt(request.getParameter("SocialSecurity")));

              rs1 = pstmt.executeQuery();


              while ( rs1.next() ) {

                %>
                <tr><th>ai</th></tr>
              <tr>
                  <form action="degreeRequirementforMS.jsp" method="get">


                      <%-- Get the SSN, which is a number --%>
                      <td>
                          <input value="<%= rs1.getInt("ai") %>"
                              name="ai" size="10">
                      </td>
                  </form>
              </tr>
              <tr><th>Course Needed</th></tr>
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
