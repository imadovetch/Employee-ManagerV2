<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Offers Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="FullPage">
    <div class="Navbar">
        <h1 class="title">Job Offers Management</h1>
    </div>

    <form id="offreForm">
        <label for="description">Description:</label>
        <input type="text" id="description" name="description" required><br><br>

        <label for="jobType">Job Type:</label>
        <select id="jobType" name="jobType">
            <option value="Full-time">Full-time</option>
            <option value="Part-time">Part-time</option>
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
        max-width: 100%;
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
