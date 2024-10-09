<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 09/10/2024
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Test</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<h2>Login</h2>
<form id="loginForm">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<div id="responseMessage"></div>

<script>
    $(document).ready(function() {
        $('#loginForm').on('submit', function(event) {
            event.preventDefault(); // Prevent form submission

            // Get form data
            const email = $('#email').val();
            const password = $('#password').val();

            // Send AJAX request
            $.ajax({
                type: 'POST',
                url: 'login',
                data: {
                    email: email,
                    password: password
                },
                success: function(response) {
                    $('#responseMessage').text(response); // Display success message
                },
                error: function(xhr) {
                    if (xhr.status === 401) {
                        $('#responseMessage').text('Login failed. Invalid email or password.');
                    } else {
                        $('#responseMessage').text('An error occurred. Please try again later.');
                    }
                }
            });
        });
    });
</script>

</body>
</html>
