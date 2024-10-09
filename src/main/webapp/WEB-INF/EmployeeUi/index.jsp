
<body>
<div class="Rhnavbar">
    <div onclick="SetPage(1)">
        ModifyProfile
    </div>
    <div onclick="SetPage(2)">
        Manage Offers
    </div>

</div>
<section id="Container" class="content-section">
    <div id="DefaultEmployee" class="Hidden">
        <jsp:include page="/WEB-INF/EmployeeUi/DefaultEmployee.jsp" />
    </div>
    <div id="modifprofil" class="Hidden">
        <jsp:include page="/WEB-INF/EmployeeUi/modifyProfil.jsp" />
    </div>
</section>
</body>


<style>
    .Rhnavbar {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        background-color: #f2f2f2;
        padding: 10px;
        display: flex;
        gap: 20px;
    }
    .Rhnavbar div {
        cursor: pointer;
        padding: 10px;
        background-color: #ddd;
        border-radius: 4px;
    }
    .content-section {
        width: 100%;
        height: 100%;
        background-color: #007bff;
        margin-top: 50px;
        padding: 20px;
    }
    .Hidden {
        display: none;
    }
    .Visible {
        display: block;
    }
</style>

<script>
    function SetPage(number) {
        // Hide all sections by default
        $('#modifprofil').addClass('Hidden').removeClass('Visible');


        // Show the relevant section based on the number
        if (number === 1) {
            $('#modifprofil').removeClass('Hidden').addClass('Visible');
        } else if (number === 2) {
            $('#manage').removeClass('Hidden').addClass('Visible');
        }
    }
</script>
