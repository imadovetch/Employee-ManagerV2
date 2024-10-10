<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 09/10/2024
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

<section class="container">
    <div style="cursor: pointer;" onclick="getMonitorringData()"><img width="48" height="48" src="https://img.icons8.com/pulsar-gradient/48/available-updates.png" alt="available-updates"/></div>

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
    <button id="bottone5"  onclick="DemandeConge()">Demande conge</button>
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

    #bottone5 {
        align-items: center;
        margin: 40px;
        background-color: #00cc45;
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: .25rem;
        box-shadow: rgba(0, 0, 0, 0.02) 0 1px 3px 0;
        box-sizing: border-box;
        color: rgba(0, 0, 0, 0.85);
        cursor: pointer;
        display: inline-flex;
        font-family: system-ui,-apple-system,system-ui,"Helvetica Neue",Helvetica,Arial,sans-serif;
        font-size: 16px;
        font-weight: 600;
        justify-content: center;
        line-height: 1.25;
        min-height: 3rem;
        padding: calc(.875rem - 1px) calc(1.5rem - 1px);
        text-decoration: none;
        transition: all 250ms;
        user-select: none;
        -webkit-user-select: none;
        touch-action: manipulation;
        vertical-align: baseline;
        width: auto;
    }

    #bottone5:hover,
    #bottone5:focus {
        border-color: rgba(0, 0, 0, 0.15);
        box-shadow: rgba(0, 0, 0, 0.1) 0 4px 12px;
        color: rgba(0, 0, 0, 0.65);
    }

    #bottone5:hover {
        transform: translateY(-1px);
    }

    #bottone5:active {
        background-color: #F0F0F1;
        border-color: rgba(0, 0, 0, 0.15);
        box-shadow: rgba(0, 0, 0, 0.06) 0 2px 4px;
        color: rgba(0, 0, 0, 0.65);
        transform: translateY(0);
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
            showStats(data)
        });

        document.querySelector(".Rh-table tbody").innerHTML = tableBody;
    }


    function showStats(data){
        const xValues = ["Employees", "Rhs","Offres", "Applyments","Mbalence * 1000"];
        const yValues = [data.Employeescount, data.Rhcount, data.Offrescount, data.Applymentscount,data.monthbalance / 1000];
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

    }


    function DemandeConge() {
        $.ajax({
            type: 'POST',
            url: 'AskForConge',
            headers:{
                "token":"1"  // anjibha mn cookie
            },
            success: function(response) {
              alert("ok for conge")

            },
            error: function(error) {
                console.error('Error fetching applications:', error);
                alert('Conge Marfoood ' + error.responseText);
            }
        });
    }
</script>


