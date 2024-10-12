<<<<<<< HEAD
<section>
    <h2>User Management</h2>

    <!-- User List Table -->
    <table id="userTable" border="1" width="100%">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone Number</th>
            <th>Address</th>
            <th>Children</th>
            <th>Salary</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <!-- User data will be dynamically inserted here by jQuery -->
        </tbody>
    </table>

    <!-- Feedback Section -->
    <div id="feedback"></div>


    <!-- jQuery and AJAX -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        // Fetch users when the page loads
        $(document).ready(function() {
            loadUsers();
        });

        // Function to load users and populate the table
        function loadUsers() {
            $.ajax({
                url: 'GetUsersForAdmin',  // The servlet to fetch user data
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    var users = data.users;
                    var userTableBody = '';

                    // Loop through each user and add a row to the table
                    $.each(users, function(index, user) {
                        userTableBody += `
                            <tr>
                                <td>\${user.id}</td>
                                <td>\${user.name}</td>
                                <td>\${user.email}</td>
                                <td><input type="text" id="phoneNumber-\${user.id}" value="\${user.phoneNumber}"></td>
                                <td><input type="text" id="adresse-\${user.id}" value="\${user.adresse}"></td>
                                <td><input type="number" id="childsnmbr-\${user.id}" value="\${user.childs}"></td>
                                <td>\${user.salaire}</td>
                                <td>
                                    <button onclick="updateUser(\${user.id})">Update</button>
                                </td>
                            </tr>
                        `;
                    });


        function updateUser(userId) {
            // Get the updated values from the input fields
            var phoneNumber = $('#phoneNumber-' + userId).val();
            var adresse = $('#adresse-' + userId).val();
            var childsnmbr = $('#childsnmbr-' + userId).val();

            $.ajax({
                url: 'ModifyUserAdmin' ,  // URL of the ModifyUser servlet
                method: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({
                    phoneNumber: phoneNumber,
                    adresse: adresse,
                    childsnmbr: parseInt(childsnmbr)
                }),
                success: function(response) {
                    $('#feedback').text('User updated successfully.');
                    loadUsers();  // Reload the users after a successful update
                },
                error: function(xhr, status, error) {
                    $('#feedback').text('Failed to update user: ' + error);
                }
            });
        }

    </script>
</section>
