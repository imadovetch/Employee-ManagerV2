<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Offers Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body style="display: flex">

<div class="FullPage">
    <div class="Navbar">
        <h1 class="title">Job Offers Management</h1>
    </div>

    <form id="offreForm">
        <label for="description">Description:</label>
        <input type="text" id="description" name="description" required><br><br>

        <label for="jobType">Job Type:</label>
        <select id="jobType" name="jobType">
            <option value="Rh">Rh</option>
            <option value="Employee">Part-time</option>
        </select><br><br>

        <label for="status">Status:</label>
        <select id="status" name="status">
            <option value="LIVE">LIVE</option>
            <option value="ENDED">ENDED</option>
        </select><br><br>

        <label for="offerId">Offer ID (for Modify/Delete):</label>
        <input type="text" id="offerId" name="offerId" placeholder="Enter Offer ID"><br><br>

        <button type="submit" id="addButton">Add</button>
        <button type="button" id="modifyButton">Modify</button>
        <button type="button" id="deleteButton">Delete</button>
        <button type="button" id="getButton">Get Offers</button>
    </form>

    <div id="results"></div>
</div>
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

<script>
    $(document).ready(function() {
        $('#offreForm').submit(function(event) {
            event.preventDefault();
            addOffer();
        });

        $('#modifyButton').click(function() {
            modifyOffer();
        });

        $('#deleteButton').click(function() {
            deleteOffer();
        });

        $('#getButton').click(function() {
            getOffers();
        });
    });


    function addOffer() {
        var formData = {
            description: $('#description').val(),
            jobType: $('#jobType').val(),
            status: $('#status').val()
        };

        $.ajax({
            type: 'POST',
            url: 'AddOffre',
            data: formData,
            success: function(response) {
                console.log('Offer saved successfully!', response);
                alert('Offer saved: ' + JSON.stringify(response));
            },
            error: function(error) {
                console.error('Error saving offer:', error);
            }
        });
    }

    function modifyOffer() {
        var formData = {
            status: $('#status').val()
        };

        $.ajax({
            type: 'PUT',
            url: 'ModifyOffre/1',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                console.log('Offer modified successfully!', response);
                alert('Offer modified: ' + JSON.stringify(response));
                clearForm();
            },
            error: function(error) {
                console.error('Error modifying offer:', error);
            }
        });
    }

    function deleteOffer() {
        var offerId = $('#offerId').val();

        $.ajax({
            type: 'DELETE',
            url: 'DeleteOffre/2',
            contentType: 'application/json',

            success: function(response) {
                console.log('Offer deleted successfully!', response);
                alert('Offer deleted: ' + JSON.stringify(response));
                clearForm();
            },
            error: function(error) {
                console.error('Error deleting offer:', error);
            }
        });
    }

    function getOffers() {
        $.ajax({
            type: 'GET',
            url: 'GetOffres', // Corrected URL
            success: function(response) {
                console.log('Offers fetched successfully!', response);
                displayOffers(response);
            },
            error: function(error) {
                console.error('Error fetching offers:', error);
            }
        });
    }

    function displayOffers(offers) {
        var resultsDiv = $('#results');
        resultsDiv.empty(); // Clear previous results

        offers.forEach(function(offer) {
            resultsDiv.append(`<div><strong>${offer.description}</strong> - Type: ${offer.jobType}, Status: ${offer.status}</div>`);
        });
    }

    function clearForm() {
        $('#description').val('');
        $('#jobType').val('Full-time');
        $('#status').val('LIVE');
        $('#offerId').val('');
    }
</script>

<style>
    .FullPage {
        padding: 0;
        margin: 0;
        height: 100vh;

        overflow: hidden;
        display: flex;
        flex-direction: column;
    }

    .Navbar {
        display: flex;
        height: 15%;
        width: 100%;
        margin: 30px;
        margin-top: 10px;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    .title {
        float: left;
        align-self: start;
    }

    /* Add additional styles here */
</style>

</body>
</html>
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