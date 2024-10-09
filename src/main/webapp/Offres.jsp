<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body style="display: flex; justify-content: center; gap: 10px; align-items: center;">
<div>
    search and filter search by description and filter with Rh or Employee    the type of the offre
</div>
<div style="width: 40%; height: 80%; margin: auto;" id="Offres">
</div>
<div style="width: 40%; height: 80%; margin: auto;">
    <div id="DisplayOffrediv">
    </div>
</div>
<div style="position:absolute; top: 50px; left: 0; border: 1px solid black; padding: 10px;" id="ApplyForm" class="Hidden">
    <h3>Application Form</h3>
    <label for="name">Enter your name:</label><br>
    <input type="text" id="name" name="name"><br><br>

    <label for="motivationLetter">Enter your email:</label><br>
    <textarea id="email" name="motivationLetter" rows="4" cols="50"></textarea><br><br>


    <label for="motivationLetter">Enter your letter of motivation:</label><br>
    <textarea id="motivationLetter" name="motivationLetter" rows="4" cols="50"></textarea><br><br>

    <label for="cv">Upload your CV:</label><br>
    <input type="file" id="cv" name="cv"><br><br>

    <button onclick="Apply()">Submit</button>
</div>
</body>
</html>

<style>
    #ApplyForm {
        animation: fadeIn 0.5s; /* Add a fade-in effect for the form */
    }
    .Hidden {
        display: none;
    }
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }


</style>
<script>
    var OffresForpage = getOffers();

    function getOffers() {
        $.ajax({
            type: 'GET',
            url: 'GetOffres', // Corrected URL
            success: function(response) {
                console.log('Offers fetched successfully!', JSON.parse(response));
                OffresForpage =JSON.parse(response);
                displayOffers(JSON.parse(response));
            },
            error: function(error) {
                console.error('Error fetching offers:', error);
            }
        });

    }

    function displayOffers(offers) {
        var OffresDiv = $('#Offres');
        OffresDiv.empty();

        offers.forEach(function(offer,index) {
            let suboffer = offer.offre
            OffresDiv.append(`<div onclick="OffreDetails(\${index})">\${suboffer.type} - \${suboffer.description.substring(0, 10)}</div>`);
        });
    }

    function OffreDetails(id) {
        console.log('Selected Offer ID:', id);

        // Fetch the offer details by ID
        let offer = OffresForpage[id]; // Assuming OffresForpage is an array

        // Using + to concatenate strings for recruiter details
        let rhDetails =
            '<p><strong>Recruiter Name:</strong> ' + (offer.rhName || 'N/A') + '</p>' +
            '<p><strong>Recruiter Email:</strong> ' + (offer.rhEmail || 'N/A') + '</p>' +
            '<p><strong>Recruiter Phone:</strong> ' + (offer.rhPhone || 'N/A') + '</p>';

        // Using + for the main offer details
        let div =
            '<h3>Offer Details</h3>' +
            '<p><strong>Type:</strong> ' + offer.offre.type + '</p>' +
            '<p><strong>Description:</strong> ' + offer.offre.description + '</p>' +
            rhDetails + // Concatenate recruiter details
            '<button onclick="applyForOffer(' + offer.offre.id + ')">Apply</button>'; // Corrected button click logic

        $("#DisplayOffrediv").html(div);
    }

    var applymentid ;
    function applyForOffer(offerId) {
        console.log('Applying for offer ID:', offerId);
        applymentid = offerId
        $('#ApplyForm').removeClass('Hidden');
        $('#offerIdAply').val(offerId);

    }
    function Apply(){
        var formData = {
            name: $('#name').val(),
            email: $('#email').val(),
            offreId: applymentid,
            status: 'PENDING'
        };

        $.ajax({
            type: 'POST',
            url: 'AddAplyment',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                console.log('Application added successfully!', response);
                alert('Application added: ' + response);

                clearForm();
            },
            error: function(error) {
                console.error('Error adding application:', error);
                alert('Error adding application: ' + error.responseText);
            }
        });
    }
    function clearForm() {
        $('#name').val('');
        $('#email').val('');
        $('#cv').val('');
        $('#ApplyForm').addClass('Hidden');
    }

</script>
