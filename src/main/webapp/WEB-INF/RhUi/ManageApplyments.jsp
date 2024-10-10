<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 09/10/2024
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="container">
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
    <table class="applicant-table">
        <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Motivation Letter</th>
            <th>CV</th>
            <th>Apply Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
</section>

<style>
    .container {
        width: 90%;
        margin: 50px auto;
        border-radius: 15px;
        padding: 20px;
        background-color: #f7f7f7;
        box-shadow: 20px 20px 60px #bebebe, -20px -20px 60px #ffffff;
    }

    .applicant-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .applicant-table th, .applicant-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    .applicant-table th {
        background-color: #4CAF50;
        color: white;
    }

    .applicant-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .accept-btn, .reject-btn {
        padding: 8px 12px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .accept-btn {
        background-color: #28a745;
        color: white;
    }

    .reject-btn {
        background-color: #dc3545;
        color: white;
    }

    .accept-btn:hover {
        background-color: #218838;
    }

    .reject-btn:hover {
        background-color: #c82333;
    }
</style>

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

                clearForm();
            },
            error: function(error) {
                console.error('Error adding application:', error);
                alert('Error adding application: ' + error.responseText);
            }
        });
    }

    function modifyApplication(offerId,status) {

        if (status) {
            $.ajax({
                type: 'PUT',
                url: 'ModifyAplyment/' + offerId,
                contentType: 'application/json',
                data: JSON.stringify({ status: status }),
                success: function(response) {
                    console.log('Application modified successfully!', response);
                    GLOBBALAPPLYMENTS = GLOBBALAPPLYMENTS.filter(e => e.id != offerId);
                    displayApplications(GLOBBALAPPLYMENTS)
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
    var GLOBBALAPPLYMENTS;
    function getApplications() {
        $.ajax({
            type: 'GET',
            url: 'GetAplyments',
            success: function(response) {
                console.log('Applications fetched succesly!', response);
                GLOBBALAPPLYMENTS =  response;
                displayApplications(response);

            },
            error: function(error) {
                console.error('Error fetching applications:', error);
                alert('Error fetching applications: ' + error.responseText);
            }
        });
    }
    function displayApplications(data) {
        let tableBody = '';
        console.log(data.name );
        data.forEach(function(data) {
            tableBody +=
                '<tr>' +
                '<td>' + data.name + '</td>' +
                '<td>' + data.email + '</td>' +
                '<td>' + data.Letter + '</td>' +
                '<td><a href="' + data.Cvpath + '">Download CV</a></td>' +
                '<td>' + data.applyDate + '</td>' +
                '<td>' +
                '<button class="accept-btn" onclick="modifyApplication(' + data.id + ', \'ACCEPTED\')">Accept</button>' +
                '<button class="reject-btn" onclick="modifyApplication(' + data.id + ', \'REJECTED\')">Reject</button>' +
                '</td>' +
                '</tr>';
        });

        document.querySelector(".applicant-table tbody").innerHTML = tableBody;
    }


    function clearForm() {
        $('#applicantName').val('');
        $('#applicantEmail').val('');
        $('#offerIdAply').val('');
    }
</script>