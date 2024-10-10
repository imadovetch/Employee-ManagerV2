<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 09/10/2024
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--        <form id="offreForm">--%>
<%--            <label for="description">Description:</label>--%>
<%--            <input type="text" id="description" name="description" required><br><br>--%>

<%--            <label for="jobType">Job Type:</label>--%>
<%--            <select id="jobType" name="jobType">--%>
<%--                <option value="Rh">Rh</option>--%>
<%--                <option value="Employee">Part-time</option>--%>
<%--            </select><br><br>--%>



<%--            <button type="submit" id="addButton">Add</button>--%>
<%--        </form>--%>





<div id="offreFormWrapper">
    <form id="offreForm" class="neumorphic-form">
        <label for="description">Description:</label>
        <input type="text" id="description" name="description" required><br><br>

        <label for="jobType">Job Type:</label>
        <select id="jobType" name="jobType">
            <option value="Rh">Rh</option>
            <option value="Part-time">Part-time</option>
        </select><br><br>

        <button type="submit" id="addButton">Add</button>
    </form>
</div>

<!-- Existing table and other content -->

<section class="container">
    <div onclick="getOffers()">update</div>
    <button id="toggleFormBtn">Show Form</button>
    <table class="Offres-table">
        <thead>
        <tr>
            <th>description</th>
            <th>publicationDate</th>
            <th>status</th>
            <th>type</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</section>

<style>
    /* Neumorphism form styling */
    .neumorphic-form {
        padding: 20px;
        background: #e0e0e0;
        border-radius: 20px;
        box-shadow: 4px 4px 60px #bebebe, -4px -4px 60px #ffffff;
        width: 300px;
    }

    .neumorphic-form input, .neumorphic-form select, .neumorphic-form button {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border-radius: 12px;
        background-color: #f0f0f0;
        border: none;
        box-shadow: inset 4px 4px 20px #bebebe, inset -4px -10px 20px #ffffff;
        outline: none;
    }

    .neumorphic-form button {
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
    }

    .neumorphic-form button:hover {
        background-color: #45a049;
    }

    /* Form container absolute positioning */
    #offreFormWrapper {
        position: absolute;
        top: 40%;
        left:30% ;
        display: none;
        border: 3px solid;
        border-radius: 30px;
    }

    /* Toggle button styling */
    #toggleFormBtn {

        background: #e0e0e0;
        border: none;
        padding: 10px 20px;
        width: fit-content;
        border-radius: 20px;
        box-shadow: 10px 10px 20px #bebebe, -10px -10px 20px #ffffff;
        cursor: pointer;
    }

    #toggleFormBtn:hover {
        background-color: #d4d4d4;
    }

    /* Existing container styling */
    .container {
        width: 90%;
        margin: 50px auto;
        border-radius: 15px;
        padding: 20px;
        background-color: #f7f7f7;
        box-shadow: 7px 7px 60px #bebebe, -7px -7px 60px #ffffff;
    }

    .Offres-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .Offres-table th, .Offres-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    .Offres-table th {
        background-color: #4CAF50;
        color: white;
    }

    .Offres-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
</style>


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
            status: "LIVE"
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

    function modifyOffer(Offreid) {
        var formData = {
            status: "ENDED"
        };

        $.ajax({
            type: 'PUT',
            url: 'ModifyOffre/' + Offreid,
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
            url: 'GetOffres',
            headers: {
                'token': '1' // Add custom header 'token' with value '1'
            },
            success: function(response) {
                console.log('Offers fetched successfully!', JSON.parse(response));
                displayOffers( JSON.parse(response));
            },
            error: function(error) {
                console.error('Error fetching offers:', error);
            }
        });
    }


    function displayOffers(data) {
        let tableBody = '';

        data.forEach(function(item) {

            let button = item.status === "ENDED"
                ? '<div>Ended</div>'
                : '<button class="accept-btn" onclick="modifyOffer(' + item.id + ')">End</button>';

            tableBody +=
                '<tr>' +
                '<td>' + item.description + '</td>' +
                '<td>' + item.publicationDate + '</td>' +
                '<td>' + item.status + '</td>' +
                '<td>' + item.type + '</td>' +
                '<td>' + button + '</td>' +  // Add the button or "Ended" message
                '</tr>';
        });

        // Insert the generated rows into the table body
        document.querySelector(".Offres-table tbody").innerHTML = tableBody;
    }

    function clearForm() {
        $('#description').val('');
        $('#jobType').val('Full-time');
        $('#status').val('LIVE');
        $('#offerId').val('');
    }


    document.getElementById('toggleFormBtn').addEventListener('click', function() {
        const formWrapper = document.getElementById('offreFormWrapper');
        if (formWrapper.style.display === 'none' || formWrapper.style.display === '') {
            formWrapper.style.display = 'block'; // Show form
            this.innerText = 'Hide Form';
        } else {
            formWrapper.style.display = 'none'; // Hide form
            this.innerText = 'Show Form';
        }
    });

</script>