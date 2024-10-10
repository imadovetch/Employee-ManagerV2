<%--
  Created by IntelliJ IDEA.
  User: ycode
  Date: 08/10/2024
  Time: 12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Offre Submission</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="light">
    <div style="height: 10% ; width: 100%; display: flex; justify-content: end; align-items: center ">
        <div style="display: flex ; justify-content: space-between ; align-items:center ; width: 60%; margin-left: auto;">

        <div class="radio-inputs">
            <label class="radio">
                <input type="radio"    onclick="SetPage(3)"   name="radio" checked="">
                <span class="name">Monitoring</span>
            </label>
            <label class="radio">
                <input type="radio"onclick="SetPage(1)" name="radio">
                <span class="name">CreateOffre</span>
            </label>

            <label class="radio">
                <input type="radio" onclick="SetPage(2)" name="radio">
                <span class="name">ManageApplyments</span>
            </label>
        </div>

        <label class="switch" style="margin: 20px">
            <input type="checkbox" id="themeToggle">
            <span class="slider"></span>
        </label>

    </div></div>
<jsp:include page="/WEB-INF/RhUi/index.jsp" />

</body>
</html>
<style>

    .Hidden {
        display: none;
    }
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
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


    /* From Uiverse.io by Yaya12085 */
    .radio-inputs {
        position: relative;
        display: flex;
        flex-wrap: wrap;
        border-radius: 0.5rem;
        background-color: #EEE;
        box-sizing: border-box;
        box-shadow: 0 0 0px 1px rgba(0, 0, 0, 0.06);
        padding: 0.25rem;
        width: 300px;
        font-size: 14px;
    }

    .radio-inputs .radio {
        flex: 1 1 auto;
        text-align: center;
    }

    .radio-inputs .radio input {
        display: none;
    }

    .radio-inputs .radio .name {
        display: flex;
        cursor: pointer;
        align-items: center;
        justify-content: center;
        border-radius: 0.5rem;
        border: none;
        padding: .5rem 0;
        color: rgba(51, 65, 85, 1);
        transition: all .15s ease-in-out;
    }

    .radio-inputs .radio input:checked + .name {
        background-color: #fff;
        font-weight: 600;
    }
</style>

<script>
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
</script>