<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<html id="htmlloader">
<head>
    <title>Title</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body style="display: flex; flex-direction: column;" class="light">
<div style="height: 10% ; width: 100%; display: flex; justify-content: end; align-items: center ">
    <div onclick="ShowLoginFrom()" style="width: 10px; height: 40px ; background-color: #4CAF50">

    </div>
    <div style="display: flex ; justify-content: space-around ; align-items: center ; width: 60%; margin-left: auto;">

        <input placeholder="Searth the internet..." type="text" name="text" class="searchinput">
        <select id="typeFilter" onchange="filterOffers()">
            <option value="">All</option>
            <option value="Rh">Rh</option>
            <option value="Employee">Employee</option>
        </select>
    </div>
    <label class="switch" style="margin: 20px">
        <input type="checkbox" id="themeToggle">
        <span class="slider"></span>
    </label>
</div>
<div   style=" height: 90% ; width: 90%; margin: auto; display: flex;  justify-content: space-around;  align-items: center;  " >

    <div class="wrapper">

        <div class="flip-card__front">
            <div class="title">Log in</div>
            <div class="flip-card__form" action="">
                <input class="flip-card__input" id="emailloging"  placeholder="Email" type="email">
                <input class="flip-card__input" id="passwordloging" placeholder="Password" type="password">
                <button onclick="loginfun()" class="flip-card__btn">Let`s go!</button>
            </div>
        </div>

    </div>



    <div style="overflow-y:auto;width: 50%; height: 90%; margin: auto; background-color: var(--one-color); border: 5px; border-radius: 15px  0  0 15px; border-right: 7px solid #494949;"  id="Offres"  >
    </div>
    <div style="width: 50%; height: 90%; margin: auto; background-color: var(--second-color); border: 5px;border-radius:   0 15px 15px 0 ;"class="neumorphic-card">
        <div id="DisplayOffrediv" >
        </div>
    </div>
    <div style="position:absolute; top: 50px; left: 0; border: 1px solid black; padding: 10px;" id="ApplyForm" class="Hidden">
        <h3>Application Form</h3>
        <label for="name">Enter your name:</label><br>
        <input type="text" id="name" name="name"><br><br>

        <label for="motivationLetter">Enter your email:</label><br>
        <textarea id="email" name="email" rows="4" cols="50"></textarea><br><br>


        <label for="motivationLetter">Enter your letter of motivation:</label><br>
        <textarea id="motivationLetter" name="motivationLetter" rows="4" cols="50"></textarea><br><br>

        <label for="cv">Upload your CV:</label><br>
        <input type="file" id="cv" name="cv"><br><br>

        <button onclick="Apply()">Submit</button>
    </div>
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
    @keyframes transition {
        from { transform: translateX(-100%); }
        to { transform: translateX(0); }
    }

    :root {
        --one-color: rgba(232, 232, 232, 1);

    }

    body.light {
        --one-color: rgba(232, 232, 232, 1);
        --second-color: rgba(232, 232, 232, 1);
        background-image: url('https://www.virtualbox.org/graphics/patterned-background.png');
        min-height: 90vh;
    }

    body.dark {
        --one-color:  #494949;
        --second-color: #c1c1c1;
        background-image: url('https://lvlhack.com/lvlhack/Main/storage/files/BHjhPni1rppatterned-background%20(1).png');
        min-height: 90vh;
    }


    .switch {
        font-size: 17px;
        position: relative;
        display: inline-block;
        width: 3.5em;
        height: 2em;
    }

    /* Hide default HTML checkbox */
    .switch input {
        opacity: 0;
        width: 0;
        height: 0;
    }

    /* The slider */
    .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #ccc;
        box-shadow: inset 2px 5px 10px rgba(0,0,0,0.3);
        transition: .4s;
        border-radius: 5px;
    }

    .slider:before {
        position: absolute;
        content: "";
        height: 1.4em;
        width: 0.1em;
        border-radius: 0px;
        left: 0.3em;
        bottom: 0.3em;
        background-color: white;
        transition: .4s;
    }

    input:checked + .slider {
        background-color: #171717;
        box-shadow: inset 2px 5px 10px rgb(0, 0, 0);
    }

    input:checked + .slider:before {
        transform: translateX(2.8em) rotate(360deg);
    }

    .card {
        width: 190px;
        height: 254px;
        border-radius: 50px;
        background: #e0e0e0;
        box-shadow: 20px 20px 60px #bebebe,
        -20px -20px 60px #ffffff;
    }

    .offretag{
        border-bottom: 1px solid ;
        min-height: 40px;
        padding: 5%;
        background: var(--second-color);
        box-shadow: 20px 20px 60px #bebebe,
        -20px -20px 60px #ffffff;

    }
    .offretag:hover{
        cursor:pointer;
    }
    .offretag.active {
        transform: scale(1.1);
    }
    #Offres::-webkit-scrollbar {
        width: 10px; /* Width of the scrollbar */
    }

    #Offres::-webkit-scrollbar-thumb {
        background-color: darkgrey; /* Color of the scroll thumb */
        border-radius: 10px; /* Roundness of the scroll thumb */
    }

    #Offres::-webkit-scrollbar-track {
        background-color: lightgrey; /* Color of the track (scrollbar background) */
        border-radius: 10px;
    }

    /* Firefox scrollbar customization */
    #Offres {
        scrollbar-color: darkgrey lightgrey; /* Thumb color | Track color */
        scrollbar-width: thin; /* Make scrollbar thinner */
    }

    /* Neumorphism Styles */
    .neumorphic-card {
        background: var(--second-color);

        box-shadow: 2px 2px 15px rgba(150, 150, 150, 0.5),
        -2px -2px 15px rgba(255, 255, 255, 0.7); /* Shadow for neumorphism effect */
         /* Padding inside the card */

        transition: all 0.3s ease;

    }

    .neumorphic-card:hover {
        box-shadow: 2px 2px 10px rgba(150, 150, 150, 0.7),
        -2px -2px 10px rgba(255, 255, 255, 0.9); /* Darker shadow on hover */
    }

    .neumorphic-button {
        background: #e0e0e0; /* Background color for button */
        border: none; /* No border */
        border-radius: 10px; /* Rounded corners */
        padding: 10px 20px; /* Padding inside the button */
        cursor: pointer; /* Pointer cursor on hover */
        box-shadow: 2px 2px 10px rgba(150, 150, 150, 0.5),
        -2px -2px 10px rgba(255, 255, 255, 0.7); /* Shadow for button */
        transition: all 0.3s ease; /* Smooth transition for effects */
    }

    .neumorphic-button:hover {
        box-shadow: 2px 2px 5px rgba(150, 150, 150, 0.7),
        -2px -2px 5px rgba(255, 255, 255, 0.9); /* Darker shadow on hover */
    }


    /* From Uiverse.io by ErzenXz */
    .searchinput{
        width: 100%;
        max-width: 220px;
        height: 36px;
        padding: 12px;
        border-radius: 12px;
        border: 1.5px solid lightgrey;
        outline: none;
        transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
        box-shadow: 0px 0px 20px -18px;
    }

    .searchinput:hover {
        border: 2px solid lightgrey;
        box-shadow: 0px 0px 20px -17px;
    }

    .searchinput:active {
        transform: scale(0.95);
    }

    .searchinput:focus {
        border: 2px solid grey;
    }






    .wrapper {
        position: absolute;
        top: 20%;
        left: 1%;
        --input-focus: #2d8cf0;
        --font-color: #323232;
        --font-color-sub: #666;
        --bg-color: #fff;
        --bg-color-alt: #666;
        --main-color: #323232;
        animation: transition 0.5s; /* Add a fade-in effect for the form */

    }

    /* card */

    .flip-card__inner {
        width: 300px;
        height: 350px;
        position: relative;
        background-color: transparent;
        perspective: 1000px;
        /* width: 100%;
        height: 100%; */
        text-align: center;
        transition: transform 0.8s;
        transform-style: preserve-3d;
    }

    .toggle:checked ~ .flip-card__inner {
        transform: rotateY(180deg);
    }

    .toggle:checked ~ .flip-card__front {
        box-shadow: none;
    }

    .flip-card__front, .flip-card__back {
        padding: 20px;
        position: absolute;
        display: flex;
        flex-direction: column;
        justify-content: center;
        -webkit-backface-visibility: hidden;
        backface-visibility: hidden;
        background: lightgrey;
        gap: 20px;
        border-radius: 5px;
        border: 2px solid var(--main-color);
        box-shadow: 4px 4px var(--main-color);
    }

    .flip-card__back {
        width: 100%;
        transform: rotateY(180deg);
    }

    .flip-card__form {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 20px;
    }

    .title {
        margin: 20px 0 20px 0;
        font-size: 25px;
        font-weight: 900;
        text-align: center;
        color: var(--main-color);
    }

    .flip-card__input {
        width: 250px;
        height: 40px;
        border-radius: 5px;
        border: 2px solid var(--main-color);
        background-color: var(--bg-color);
        box-shadow: 4px 4px var(--main-color);
        font-size: 15px;
        font-weight: 600;
        color: var(--font-color);
        padding: 5px 10px;
        outline: none;
    }

    .flip-card__input::placeholder {
        color: var(--font-color-sub);
        opacity: 0.8;
    }

    .flip-card__input:focus {
        border: 2px solid var(--input-focus);
    }

    .flip-card__btn:active, .button-confirm:active {
        box-shadow: 0px 0px var(--main-color);
        transform: translate(3px, 3px);
    }

    .flip-card__btn {
        margin: 20px 0 20px 0;
        width: 120px;
        height: 40px;
        border-radius: 5px;
        border: 2px solid var(--main-color);
        background-color: var(--bg-color);
        box-shadow: 4px 4px var(--main-color);
        font-size: 17px;
        font-weight: 600;
        color: var(--font-color);
        cursor: pointer;
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

    function loginfun() {

        const email = document.getElementById('emailloging').value;
        const pass = document.getElementById('passwordloging').value;

        $.ajax({
            type: 'POST',
            url: 'login',
            data: { email: email, password: pass }, // Use 'data' instead of 'body'
            success: function(response) {
                console.log('Login successful!', response);
                localStorage.setItem("id",response.id)
                if(response.type === "Rh"){
                    window.location.href = "Rh.jsp"
                }else if(response.type === "Employee"){
                    window.location.href = "Employee.jsp"
                }
            },
            error: function(error) {
                console.error('Error during login:', error);
                // Handle error (e.g., show an error message to the user)
            }
        });
    }

    function displayOffers(offers) {
        var OffresDiv = $('#Offres');
        OffresDiv.empty();

        offers.forEach(function(offer,index) {
            let suboffer = offer.offre
            OffresDiv.append(`<div class="offretag" onclick="OffreDetails(\${index})">\${suboffer.type} - \${suboffer.description.substring(0, 10)}</div>`);
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
            '<div style="padding: 10px;" class="">' + // Neumorphic card container
            '<h3>Offer Details</h3>' +
            '<p><strong>Type:</strong> ' + offer.offre.type + '</p>' +
            '<p><strong>Description:</strong> ' + offer.offre.description + '</p>' +
            rhDetails + // Concatenate recruiter details
            '<button class="neumorphic-button" onclick="applyForOffer(' + offer.offre.id + ')">Apply</button>' + // Neumorphic button
            '</div>'; // Close neumorphic card container

        $("#DisplayOffrediv").html(div);
    }


    var applymentid ;
    function applyForOffer(offerId) {
        console.log('Applying for offer ID:', offerId);
        applymentid = offerId
        $('#ApplyForm').removeClass('Hidden');
        $('#offerIdAply').val(offerId);

    }
    function Apply() {

        var formData = new FormData();

        // Append form data fields
        formData.append('name', $('#name').val());
        formData.append('email', $('#email').val());
        formData.append('offreId', applymentid);
        formData.append('lettremotivation', $('#motivationLetter').val());
        formData.append('status', 'PENDING');

        // Append file (CV)
        var cvFile = $('#cv')[0].files[0];
        if (cvFile) {
            formData.append('cv', cvFile);
        }

        $.ajax({
            type: 'POST',
            url: 'AddAplyment',
            contentType: false, // Let jQuery handle this automatically
            processData: false, // Required for FormData
            data: formData,
            success: function(response) {
                console.log('Application added successfully!', response);
                alert('Application added: ' + response);
                OffresForpage = OffresForpage.filter(e => e.offre.id != applymentid);

                displayOffers(OffresForpage);
                OffreDetails(0)
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


    <%--function filterOffers() {--%>
    <%--    var searchQuery = $('#searchInput').val().toLowerCase();--%>
    <%--    var selectedType = $('#typeFilter').val();--%>

    <%--    // Filter based on search and type--%>
    <%--    var filteredOffers = OffresForpage.filter(function(offer) {--%>
    <%--        var suboffer = offer.offre;--%>
    <%--        var matchesSearch = suboffer.description.toLowerCase().includes(searchQuery);--%>
    <%--        var matchesType = selectedType === "" || suboffer.type === selectedType;--%>
    <%--        return matchesSearch && matchesType;--%>
    <%--    });--%>

    <%--    displayOffers(filteredOffers); // Display the filtered results--%>
    <%--}--%>

    <%--function displayOffers(offers) {--%>
    <%--    var OffresDiv = $('#Offres');--%>
    <%--    OffresDiv.empty();--%>

    <%--    if (offers.length === 0) {--%>
    <%--        OffresDiv.append('<div>No offers found.</div>');--%>
    <%--    } else {--%>
    <%--        offers.forEach(function(offer, index) {--%>
    <%--            let suboffer = offer.offre;--%>
    <%--            OffresDiv.append(`<div onclick="OffreDetails(${index})">${suboffer.type} - ${suboffer.description.substring(0, 10)}</div>`);--%>
    <%--        });--%>
    <%--    }--%>
    <%--}--%>

    var coler = 'light';


    document.getElementById('themeToggle').addEventListener('change', function() {
        if (this.checked) {
            coler = 'dark';
            document.body.className = coler;
        } else {
            coler = 'light';
            document.body.className = coler;
        }

        console.log("Theme set to: " + coler);
    });





    function  ShowLoginFrom(){
        $(".wrapper").toggleClass("Hidden");

    }

</script>
