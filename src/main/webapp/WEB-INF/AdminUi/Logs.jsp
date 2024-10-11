<section>
    <h1>Logs</h1>
    <table id="logsTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>Type</th>
            <th>Description</th>
            <th>Logged For</th>
            <th>Date</th>
        </tr>
        </thead>
        <tbody>
        <!-- Log rows will be inserted here dynamically -->
        </tbody>
    </table>
</section>

<script>
    // Fetch logs data from the API and populate the table
    fetch("GetLogs")
        .then(response => response.json())
        .then(data => {
            const logsTable = document.getElementById('logsTable').getElementsByTagName('tbody')[0];
            data.forEach(log => {
                const row = logsTable.insertRow();
                row.innerHTML = `
                    <td>\${log.id}</td>
                    <td>\${log.type}</td>
                    <td>\${log.description}</td>
                    <td>\${log.loggedFor}</td>
                    <td>\${new Date(log.date).toLocaleString()}</td>
                `;
            });
        })
        .catch(error => {
            console.error('Error fetching logs:', error);
        });
</script>

<style>
    section {
        width: 80%;
        margin: 40px auto;
        padding: 20px;
        background-color: #f0fdf4; /* Light green background */
        border-radius: 12px;
        box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.05), -4px -4px 8px rgba(255, 255, 255, 0.7); /* Minimized shadow */
    }

    h1 {
        text-align: center;
        color: #333;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        padding: 10px 15px;
        background-color: #ffffff; /* White cells */
        border: 1px solid #d3f9d8; /* Light green border */
        text-align: left;
        color: #333;
    }

    th {
        background-color: #bbf7d0; /* Light green for table header */
        font-weight: bold;
    }

    tbody tr:hover {
        background-color: #e6fffa; /* Light green highlight on hover */
    }
</style>
