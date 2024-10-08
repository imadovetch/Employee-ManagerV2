<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 08/10/2024
  Time: 12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Offre Submission</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<form id="offreForm">
    <label for="description">Description:</label>
    <input type="text" id="description" name="description"><br><br>

    <label for="jobType">Job Type:</label>
    <select id="jobType" name="jobType">
        <option value="Full-time">Full-time</option>
        <option value="Part-time">Part-time</option>
    </select><br><br>

    <label for="status">Status:</label>
    <select id="status" name="status">
        <option value="LIVE">LIVE</option>
        <option value="CLOSED">CLOSED</option>
    </select><br><br>

    <button type="submit">Submit</button>
</form>

<script>
    $(document).ready(function() {
        $('#offreForm').submit(function(event) {
            event.preventDefault();

            // Collect form data
            var formData = {
                description: $('#description').val(),
                jobType: $('#jobType').val(),
                status: $('#status').val()
            };

            // Make AJAX POST request
            $.ajax({
                type: 'POST',
                url: '/your-offre-endpoint',  // Replace with the actual URL endpoint of OffreController
                data: formData,
                success: function(response) {
                    console.log('Offer saved successfully!', response);
                    alert('Offer saved: ' + JSON.stringify(response));
                },
                error: function(error) {
                    console.error('Error saving offer:', error);
                }
            });
        });
    });
</script>

</body>
</html>
