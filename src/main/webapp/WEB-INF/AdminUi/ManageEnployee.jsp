<<<<<<< HEAD
<section>
    <h2>User Management</h2>
=======
<%--<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
>>>>>>> 46fa08718adf1f29770fd389fe82ec88e6d6dc42

    <!-- User List Table -->
    <table id="userTable" border="1" width="100%">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone Number</th>
            <th>Address</th>
            <th>Children</th>
            <th>Salary</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <!-- User data will be dynamically inserted here by jQuery -->
        </tbody>
    </table>

    <!-- Feedback Section -->
    <div id="feedback"></div>

<<<<<<< HEAD
    <!-- jQuery and AJAX -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        // Fetch users when the page loads
        $(document).ready(function() {
            loadUsers();
        });

        // Function to load users and populate the table
        function loadUsers() {
            $.ajax({
                url: 'GetUsersForAdmin',  // The servlet to fetch user data
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    var users = data.users;
                    var userTableBody = '';
=======
<%--<section class="Container relative">--%>
<%--  <div class="absolute Hidden " id="AddForm">--%>

<%--    <form id="employeeForm" class="styled-form">--%>
<%--      <input type="text" name="name" placeholder="Name" required>--%>
<%--      <input type="email" name="email" placeholder="Email" required>--%>
<%--      <input type="text" name="phone" placeholder="Phone" required>--%>
<%--      <input type="text" name="department" placeholder="Department" required>--%>
<%--      <input type="text" name="position" placeholder="Position" required>--%>
<%--      <button type="submit" class="submit-btn">Submit</button>--%>
<%--    </form>--%>
<%--  </div>--%>
>>>>>>> 46fa08718adf1f29770fd389fe82ec88e6d6dc42

                    // Loop through each user and add a row to the table
                    $.each(users, function(index, user) {
                        userTableBody += `
                            <tr>
                                <td>\${user.id}</td>
                                <td>\${user.name}</td>
                                <td>\${user.email}</td>
                                <td><input type="text" id="phoneNumber-\${user.id}" value="\${user.phoneNumber}"></td>
                                <td><input type="text" id="adresse-\${user.id}" value="\${user.adresse}"></td>
                                <td><input type="number" id="childsnmbr-\${user.id}" value="\${user.childs}"></td>
                                <td>\${user.salaire}</td>
                                <td>
                                    <button onclick="updateUser(\${user.id})">Update</button>
                                </td>
                            </tr>
                        `;
                    });

<<<<<<< HEAD
                    // Insert rows into the table body
                    $('#userTable tbody').html(userTableBody);
                },
                error: function(xhr, status, error) {
                    $('#feedback').text('Failed to load users: ' + error);
                }
            });
        }

        // Function to update user details via AJAX
        // Function to update user details via AJAX
        function updateUser(userId) {
            // Get the updated values from the input fields
            var phoneNumber = $('#phoneNumber-' + userId).val();
            var adresse = $('#adresse-' + userId).val();
            var childsnmbr = $('#childsnmbr-' + userId).val();

            $.ajax({
                url: 'ModifyUserAdmin' ,  // URL of the ModifyUser servlet
                method: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({
                    phoneNumber: phoneNumber,
                    adresse: adresse,
                    childsnmbr: parseInt(childsnmbr)
                }),
                success: function(response) {
                    $('#feedback').text('User updated successfully.');
                    loadUsers();  // Reload the users after a successful update
                },
                error: function(xhr, status, error) {
                    $('#feedback').text('Failed to update user: ' + error);
                }
            });
        }

    </script>
</section>
=======
<%--  <div class="Column">--%>
<%--    <h2 class="ColumnName">Name</h2>--%>
<%--    <div class="RowsContainer">--%>
<%--      <!-- Iterate over the employees and display their names -->--%>
<%--      <c:forEach var="employee" items="${employees}">--%>
<%--        <div id="NameRows"  data-id="${employee.id}" class="SingleRow SingleRow-${employee.id} ">--%>
<%--          <input  oninput="InputChange(${employee.id},true)" class="Rowinput-${employee.id}" value="${employee.name}" />--%>
<%--        </div>--%>
<%--      </c:forEach>--%>
<%--    </div>--%>
<%--  </div>--%>

<%--  <div class="Column">--%>
<%--    <h2 class="ColumnName">Email</h2>--%>
<%--    <div class="RowsContainer">--%>
<%--      <!-- Display employee emails -->--%>
<%--      <c:forEach var="employee" items="${employees}">--%>
<%--        <div id="EmailRows" data-id="${employee.id}" class="SingleRow SingleRow-${employee.id}">--%>
<%--          <input  oninput="InputChange(${employee.id},true)" class="Rowinput-${employee.id}" value="${employee.email}" />--%>

<%--        </div>--%>
<%--      </c:forEach>--%>
<%--    </div>--%>
<%--  </div>--%>

<%--  <div class="Column">--%>
<%--    <h2 class="ColumnName">Phone Number</h2>--%>
<%--    <div class="RowsContainer">--%>
<%--      <!-- Display employee phone numbers -->--%>
<%--      <c:forEach var="employee" items="${employees}">--%>
<%--        <div id="PhoneRows" data-id="${employee.id}" class="SingleRow SingleRow-${employee.id}">--%>
<%--          <input  oninput="InputChange(${employee.id},true)" class="Rowinput-${employee.id}" value="${employee.phone}" />--%>

<%--        </div>--%>
<%--      </c:forEach>--%>
<%--    </div>--%>
<%--  </div>--%>

<%--  <div class="Column">--%>
<%--    <h2 class="ColumnName">Position</h2>--%>
<%--    <div class="RowsContainer">--%>
<%--      <!-- Display employee positions -->--%>
<%--      <c:forEach var="employee" items="${employees}">--%>
<%--        <div id="PositionRows" data-id="${employee.id}" class="SingleRow SingleRow-${employee.id}">--%>
<%--          <input  oninput="InputChange(${employee.id},true)" class="Rowinput-${employee.id}" value="${employee.position}" />--%>

<%--        </div>--%>
<%--      </c:forEach>--%>
<%--    </div>--%>
<%--  </div>--%>

<%--  <div class="Column">--%>
<%--    <h2 class="ColumnName">Department</h2>--%>
<%--    <div class="RowsContainer">--%>
<%--      <!-- Display employee departments -->--%>
<%--      <c:forEach var="employee" items="${employees}">--%>
<%--        <div id="DepartmentRows" data-id="${employee.id}" class="SingleRow SingleRow-${employee.id}">--%>
<%--          <input  oninput="InputChange(${employee.id},true)" class="Rowinput-${employee.id} " value="${employee.department}" />--%>

<%--        </div>--%>
<%--      </c:forEach>--%>
<%--    </div>--%>
<%--  </div>--%>

<%--  <div class="Column">--%>
<%--    <h2 class="ColumnName">Actions</h2>--%>
<%--    <div class="RowsActionsr">--%>
<%--      <div  class="ActionColumn">--%>
<%--        <c:forEach var="employee" items="${employees}">--%>
<%--          <div id="UpdateRows-${employee.id}" data-id="${employee.id}" class="SingleRow SingleRow-${employee.id}">--%>


<%--            <svg onclick="update(${employee.id})" style=" height: 30px" class="Update-${employee.id}  iconHover" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M471.6 21.7c-21.9-21.9-57.3-21.9-79.2 0L362.3 51.7l97.9 97.9 30.1-30.1c21.9-21.9 21.9-57.3 0-79.2L471.6 21.7zm-299.2 220c-6.1 6.1-10.8 13.6-13.5 21.9l-29.6 88.8c-2.9 8.6-.6 18.1 5.8 24.6s15.9 8.7 24.6 5.8l88.8-29.6c8.2-2.7 15.7-7.4 21.9-13.5L437.7 172.3 339.7 74.3 172.4 241.7zM96 64C43 64 0 107 0 160L0 416c0 53 43 96 96 96l256 0c53 0 96-43 96-96l0-96c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 96c0 17.7-14.3 32-32 32L96 448c-17.7 0-32-14.3-32-32l0-256c0-17.7 14.3-32 32-32l96 0c17.7 0 32-14.3 32-32s-14.3-32-32-32L96 64z"/></svg>--%>

<%--          </div>--%>
<%--        </c:forEach>--%>
<%--      </div>--%>
<%--      <div  class="ActionColumn">--%>
<%--        <c:forEach var="employee" items="${employees}">--%>
<%--          <div id="DeleteRows-${employee.id}"  onclick="deleteEmp(${employee.id})" data-id="${employee.id}" class="SingleRow SingleRow-${employee.id}">--%>
<%--            <svg style=" fill: red; height: 30px" class="Update-${employee.id} iconHover" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M135.2 17.7C140.6 6.8 151.7 0 163.8 0L284.2 0c12.1 0 23.2 6.8 28.6 17.7L320 32l96 0c17.7 0 32 14.3 32 32s-14.3 32-32 32L32 96C14.3 96 0 81.7 0 64S14.3 32 32 32l96 0 7.2-14.3zM32 128l384 0 0 320c0 35.3-28.7 64-64 64L96 512c-35.3 0-64-28.7-64-64l0-320zm96 64c-8.8 0-16 7.2-16 16l0 224c0 8.8 7.2 16 16 16s16-7.2 16-16l0-224c0-8.8-7.2-16-16-16zm96 0c-8.8 0-16 7.2-16 16l0 224c0 8.8 7.2 16 16 16s16-7.2 16-16l0-224c0-8.8-7.2-16-16-16zm96 0c-8.8 0-16 7.2-16 16l0 224c0 8.8 7.2 16 16 16s16-7.2 16-16l0-224c0-8.8-7.2-16-16-16z"/></svg></svg>--%>

<%--          </div>--%>
<%--        </c:forEach>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</section>--%>

<%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>

<%--<style>--%>
<%--  .Hidden{--%>
<%--    display: none;--%>
<%--  }--%>

<%--  .relative{--%>
<%--    position: relative;--%>
<%--  }--%>
<%--  .absolute {--%>
<%--    position: absolute;--%>
<%--    top: 50%;--%>
<%--    left: 50%;--%>
<%--    transform: translate(-50%, -50%);--%>
<%--    margin: auto;--%>
<%--  }--%>

<%--  .styled-form {--%>
<%--    width: 300px;--%>
<%--    padding: 20px;--%>
<%--    background-color: #f9f9f9;--%>
<%--    border-radius: 15px;--%>
<%--    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);--%>
<%--    display: flex;--%>
<%--    justify-content: center;--%>
<%--    align-items: center;--%>
<%--    flex-direction: column;--%>
<%--    border: 1px solid #ddd;--%>
<%--  }--%>

<%--  .styled-form input {--%>
<%--    width: 100%;--%>
<%--    padding: 10px;--%>
<%--    margin-bottom: 15px;--%>
<%--    border: 1px solid #ccc;--%>
<%--    border-radius: 5px;--%>
<%--    font-size: 16px;--%>
<%--    transition: border-color 0.3s;--%>
<%--  }--%>

<%--  .styled-form input:focus {--%>
<%--    border-color: #007bff;--%>
<%--    outline: none;--%>
<%--  }--%>

<%--  .styled-form .submit-btn {--%>
<%--    width: 100%;--%>
<%--    padding: 12px;--%>
<%--    background-color: #007bff;--%>
<%--    border: none;--%>
<%--    border-radius: 5px;--%>
<%--    color: #fff;--%>
<%--    font-size: 16px;--%>
<%--    cursor: pointer;--%>
<%--    transition: background-color 0.3s;--%>
<%--  }--%>

<%--  .styled-form .submit-btn:hover {--%>
<%--    background-color: #0056b3;--%>
<%--  }--%>

<%--  .iconHover:hover{--%>
<%--    transform: scale(1.3);--%>
<%--    transform: rotateZ(12deg);--%>
<%--    cursor: pointer;--%>
<%--  }--%>


<%--</style>--%>
>>>>>>> 46fa08718adf1f29770fd389fe82ec88e6d6dc42
