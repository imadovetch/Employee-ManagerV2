<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Rh Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="Rhnavbar">
    <div onclick="SetPage(1)">
        Create Offer
    </div>
    <div onclick="SetPage(2)">
        Manage Offers
    </div>
    <div onclick="SetPage(3)">
        Monitoring
    </div>
</div>
<section id="Container" class="content-section">
<%--    <div id="create" class="Hidden">--%>
<%--        <jsp:include page="/WEB-INF/AdminUi/" />--%>
<%--    </div>--%>
    <div id="manage" class="Hidden">
        <jsp:include page="/WEB-INF/AdminUi/ManageEnployee.jsp" />
    </div>
    <div id="monitoring" class="Hidden">
        <jsp:include page="/WEB-INF/AdminUi/Logs.jsp" />
    </div>
</section>
</body>
</html>

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
