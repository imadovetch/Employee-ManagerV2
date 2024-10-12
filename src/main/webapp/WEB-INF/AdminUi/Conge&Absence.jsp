<section class="absence-management">
    <h2>Manage Absences</h2>
    <div class="absence-actions">
        <button id="addAbsenceBtn" class="btn">Add Absence</button>
        <button id="justifyAbsenceBtn" class="btn">Justify Absence</button>
    </div>
    <div id="absenceForm" class="absence-form hidden">
        <h3 id="formTitle">Add Absence</h3>
        <form id="absenceManagementForm">
            <label for="userId">User ID:</label>
            <input type="text" id="userId" name="userId" required>

            <label for="absenceDate">Absence Date:</label>
            <input type="date" id="absenceDate" name="absenceDate" required>

            <label for="reason">Reason:</label>
            <textarea id="reason" name="reason" rows="4" required></textarea>

            <button type="submit" class="btn">Submit</button>
            <button type="button" class="btn cancel" id="cancelBtn">Cancel</button>
        </form>
    </div>
    <div id="feedback" class="feedback"></div>
</section>
<style>
    .absence-management {
        background-color: #f8f9fa;
        border-radius: 8px;
        padding: 20px;
        margin: 20px 0;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
        color: #333;
        margin-bottom: 20px;
    }

    .absence-actions {
        margin-bottom: 20px;
    }

    .btn {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 10px;
        transition: background-color 0.3s;
    }

    .btn:hover {
        background-color: #0056b3;
    }

    .absence-form {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .hidden {
        display: none;
    }

    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }

    input[type="text"],
    input[type="date"],
    textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ced4da;
        border-radius: 4px;
    }

    textarea {
        resize: none;
    }

    .feedback {
        margin-top: 20px;
        font-weight: bold;
        color: green; /* Change this color based on the success/error */
    }

</style>
<script>
    $(document).ready(function() {
        $('#addAbsenceBtn').click(function() {
            $('#formTitle').text('Add Absence');
            $('#absenceForm').removeClass('hidden');
        });

        $('#justifyAbsenceBtn').click(function() {
            $('#formTitle').text('Justify Absence');
            $('#absenceForm').removeClass('hidden');
        });

        $('#cancelBtn').click(function() {
            $('#absenceForm').addClass('hidden');
            $('#absenceManagementForm')[0].reset();
        });

        $('#absenceManagementForm').submit(function(event) {
            event.preventDefault(); // Prevent the form from submitting the default way

            // Get form data
            var userId = $('#userId').val();
            var absenceDate = $('#absenceDate').val();
            var reason = $('#reason').val();

            // Send data to the server (update the URL as necessary)
            $.ajax({
                url: 'API_ENDPOINT_HERE', // Replace with your API endpoint for adding/justifying absences
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    userId: userId,
                    absenceDate: absenceDate,
                    reason: reason
                }),
                success: function(response) {
                    $('#feedback').text('Absence managed successfully.').css('color', 'green');
                    $('#absenceForm').addClass('hidden');
                    $('#absenceManagementForm')[0].reset();
                },
                error: function(xhr, status, error) {
                    $('#feedback').text('Failed to manage absence: ' + error).css('color', 'red');
                }
            });
        });
    });

</script>