<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 09/10/2024
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf.min.js"></script>
<div onclick="getApplications()">refreach</div>
<section class="container">


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
<%--<div id="pdfCanvasContainer" >--%>
<%--    <canvas id="pdfCanvas"></canvas>--%>
<%--</div>--%>
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
        margin: 4px;
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
    getApplications();
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
                '<td> <div class="display:flex;justify-content:center;align-items:center;" onclick="displayPDF(\'http://localhost:8080' + data.cvUrl + '\')" ><img width="30" height="30" src="https://img.icons8.com/3d-fluency/30/pdf.png" alt="pdf"/></div></td>' +
                '<td>' + data.applyDate + '</td>' +
                '<td >' +
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

    async function displayPDF(pdfUrl) {
        // Set the worker source
        pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf.worker.min.js';

        // Correct the PDF URL by replacing spaces with %20
        const correctedUrl = pdfUrl.replace(/ /g, '%20');

        console.log(correctedUrl);

        const loadingTask = pdfjsLib.getDocument(correctedUrl); // Use the corrected URL directly

        try {
            const pdf = await loadingTask.promise;
            const page = await pdf.getPage(1); // Display the first page of the PDF
            const scale = 1.5; // Scale the PDF for better visibility
            const viewport = page.getViewport({ scale: scale });

            const canvas = document.getElementById('pdfCanvas');
            const context = canvas.getContext('2d');
            canvas.height = viewport.height;
            canvas.width = viewport.width;

            const renderContext = {
                canvasContext: context,
                viewport: viewport
            };
            await page.render(renderContext).promise; // Render the PDF page to the canvas
        } catch (error) {
            console.error('Error loading PDF:', error);
        }
    }



</script>