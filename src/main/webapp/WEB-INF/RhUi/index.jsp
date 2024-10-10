
<div   style="height: 90% ; width: 100%; margin: auto; display: flex;  justify-content: space-around;  align-items: center; " >


<section  class="content-section">
    <div id="create" class="Hidden">
        <jsp:include page="/WEB-INF/RhUi/CreateOffre.jsp" />
    </div>
    <div id="manage" class="Hidden">
        <jsp:include page="/WEB-INF/RhUi/ManageApplyments.jsp" />
    </div>
    <div id="monitoring" class="">
        <jsp:include page="/WEB-INF/RhUi/Monitoring.jsp" />
    </div>
</section>

</div>

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
        $('#create').addClass('Hidden').removeClass('Visible');
        $('#manage').addClass('Hidden').removeClass('Visible');
        $('#monitoring').addClass('Hidden').removeClass('Visible');

        // Show the relevant section based on the number
        if (number === 1) {
            $('#create').removeClass('Hidden').addClass('Visible');
        } else if (number === 2) {
            $('#manage').removeClass('Hidden').addClass('Visible');
        } else if (number === 3) {
            $('#monitoring').removeClass('Hidden').addClass('Visible');
        }
    }
</script>
