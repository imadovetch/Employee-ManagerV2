<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 09/10/2024
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section>
    Create nlkenvenv
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
</section>
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
                console.log('Offers fetched successfully!', JSON.parse(response));
                displayOffers( JSON.parse(response));
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