<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 09/10/2024
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section>
    <div class="FullPage">
        <div class="Navbar">
            <h1 class="title">Job Application Management</h1>
        </div>

        <form id="Applymentform">
            <label for="applicantName">Applicant Name:</label>
            <input type="text" id="applicantName" name="applicantName" required><br><br>

            <label for="applicantEmail">Applicant Email:</label>
            <input type="email" id="applicantEmail" name="applicantEmail" required><br><br>

            <label for="offerIdAply">Offer ID:</label>
            <input type="text" id="offerIdAply" name="offerIdAply" placeholder="Enter Offer ID for Application" required><br><br>

            <button type="submit" id="addButtonAply">Add Application</button>
            <button type="button" id="modifyButtonAply">Modify Application</button>
            <button type="button" id="getButtonAply">Get Applications</button>
        </form>

        <div id="resultsAply"></div>
    </div>



</section>
<script>
    $(document).ready(function() {
        $('#Applymentform').submit(function(event) {
            event.preventDefault();
            addApplication();
        });

        $('#modifyButtonAply').click(function() {
            modifyApplication();
        });

        $('#getButtonAply').click(function() {
            getApplications();
        });
    });

    function addApplication() {
        var formData = {
            name: $('#applicantName').val(),
            email: $('#applicantEmail').val(),
            offreId: $('#offerIdAply').val(),
            status: 'PENDING' // Default status for new applications
        };

        $.ajax({
            type: 'POST',
            url: 'AddAplyment',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                console.log('Application added successfully!', response);
                alert('Application added: ' + response);
                clearForm();
            },
            error: function(error) {
                console.error('Error adding application:', error);
                alert('Error adding application: ' + error.responseText);
            }
        });
    }

    function modifyApplication() {
        var offerId = $('#offerIdAply').val(); // Using Offer ID to find application
        var status = prompt("Enter new status for the application (e.g., ACCEPTED, REJECTED):");

        if (status) {
            $.ajax({
                type: 'PUT',
                url: 'ModifyAplyment/' + offerId,
                contentType: 'application/json',
                data: JSON.stringify({ status: status }),
                success: function(response) {
                    console.log('Application modified successfully!', response);
                    alert('Application modified: ' + response);
                },
                error: function(error) {
                    console.error('Error modifying application:', error);
                    alert('Error modifying application: ' + error.responseText);
                }
            });
        } else {
            alert('Status cannot be empty.');
        }
    }

    function getApplications() {
        $.ajax({
            type: 'GET',
            url: 'GetAplyments', // Adjust this URL if necessary
            success: function(response) {
                console.log('Applications fetched successfully!', response);
                displayApplications(JSON.parse(response)); // Assuming response is a JSON array
            },
            error: function(error) {
                console.error('Error fetching applications:', error);
                alert('Error fetching applications: ' + error.responseText);
            }
        });
    }

    function displayApplications(applications) {
        var resultsDiv = $('#resultsAply');
        resultsDiv.empty(); // Clear previous results

        applications.forEach(function(application) {
            resultsDiv.append(`<div><strong>${application.name}</strong> - Email: ${application.email}, Status: ${application.status}, Offer ID: ${application.offreId}</div>`);
        });
    }

    function clearForm() {
        $('#applicantName').val('');
        $('#applicantEmail').val('');
        $('#offerIdAply').val('');
    }
</script>