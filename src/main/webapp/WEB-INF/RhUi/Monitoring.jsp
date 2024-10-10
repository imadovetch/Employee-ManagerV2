<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 09/10/2024
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="container">

    <div style="min-height:50%;max-height:50%;">
        <table class="Rh-table">
            <thead>
            <tr>
                <th>Employee</th>
                <th>Email</th>
                <th>Childs</th>
                <th>CongeDays</th>
                <th>AbscenceDays</th>
                <th>TotalSalary</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>

</section>
<div style="border:2px solid; min-height:50%; display:flex; width:100%;">

    <div style="width: 80%">
        <canvas id="myChart" style="width:100%;max-width:600px"></canvas>
    </div>
    <div style="width:40px; height: 100px;"> Conge</div>
</div>

<style>

    /* Existing container styling */
    .container {
        height: 100%;
        width: 90%;
        margin: 50px auto;
        border-radius: 15px;
        padding: 20px;
        background-color: #f7f7f7;
        box-shadow: 7px 7px 60px #bebebe, -7px -7px 60px #ffffff;
    }

    .Rh-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .Rh-table th, .Rh-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    .Rh-table th {
        background-color: #4CAF50;
        color: white;
    }

    .Rh-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
</style>

<script>
    var GLOBBALRhDATA;
    getMonitorringData()
    function getMonitorringData() {
        $.ajax({
            type: 'GET',
            url: 'GetEmployee',
            success: function(response) {
                console.log('Rh fetched succesly!', response);
                GLOBBALRhDATA =  response;
                displayRhData(response);

            },
            error: function(error) {
                console.error('Error fetching applications:', error);
                alert('Error fetching applications: ' + error.responseText);
            }
        });
    }
    function displayRhData(data) {
        let tableBody = '';
        console.log(data.name );
        data.forEach(function(data) {
            tableBody +=
                '<tr>' +
                '<td>' + data.EmployeeName + '</td>' +
                '<td>' + data.email + '</td>' +
                '<td>' + data.Childs + '</td>' +
                '<td>' + data.CongeDays + '</td>' +
                '<td>' + data.AbscenceDays + '</td>' +
                '<td>' + data.TotalSalary + '</td>' +
                '<td>' + "Report" + '</td>' +
                '</tr>';
        });

        document.querySelector(".Rh-table tbody").innerHTML = tableBody;
    }
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<script>
    const xValues = ["Italy", "France", "Spain", "USA", "Argentina"];
    const yValues = [55, 49, 44, 24, 15];
    const barColors = ["red", "green","blue","orange","brown"];

    new Chart("myChart", {
        type: "bar",
        data: {
            labels: xValues,
            datasets: [{
                backgroundColor: barColors,
                data: yValues
            }]
        },
        options: {
            legend: {display: false},
            title: {
                display: true,
                text: "World Wine Production 2018"
            }
        }
    });
</script>