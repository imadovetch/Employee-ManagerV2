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
  <style>
    body {
      width: 100%;
      height: 100%;
      font-family: Arial, sans-serif;
    }

    .wrapper {
      width: 100%;
      max-width: 400px;
      margin: 50px auto;
      padding: 20px;
      background-color: #f7f7f7;
      box-shadow: 20px 20px 60px #bebebe, -20px -20px 60px #ffffff;
      border-radius: 15px;
      text-align: center;
    }

    .title {
      font-size: 24px;
      margin-bottom: 20px;
      color: #333;
    }

    .flip-card__form {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .flip-card__input {
      padding: 10px;
      border: 2px solid #ccc;
      border-radius: 10px;
      font-size: 16px;
      background-color: #e0e0e0;
      box-shadow: inset 5px 5px 10px #bebebe, inset -5px -5px 10px #ffffff;
    }

    .flip-card__btn {
      padding: 10px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      cursor: pointer;
      box-shadow: 5px 5px 15px #bebebe, -5px -5px 15px #ffffff;
    }

    .flip-card__btn:hover {
      background-color: #45a049;
    }

    .demande-conge-btn {
      padding: 10px 20px;
      background-color: #007BFF;
      color: white;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      cursor: pointer;
      box-shadow: 5px 5px 15px #bebebe, -5px -5px 15px #ffffff;
      margin-bottom: 20px;
    }

    .demande-conge-btn:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>

<div class="wrapper">
  <!-- Demande Conge Button -->
  <button class="demande-conge-btn" onclick="requestConge()">Demande Conge</button>

  <!-- Modify Profile Form -->
  <div class="modify-profile">
    <div class="title">Modify Profile</div>
    <div class="flip-card__form">
      <input class="flip-card__input" id="name" placeholder="Name" type="text">
      <input class="flip-card__input" id="email" placeholder="Email" type="email">
      <input class="flip-card__input" id="password" placeholder="Password" type="password">
      <input class="flip-card__input" id="children" placeholder="Number of Children" type="number">
      <button onclick="modifyProfile()" class="flip-card__btn">Save Changes</button>
    </div>
  </div>
</div>

<script>
  function requestConge() {

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

  function modifyProfile() {
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const children = document.getElementById('children').value;

    // Implement profile modification logic here, e.g., sending data to the server
    console.log('Profile Updated:', { name, email, password, children });
    alert('Profile modified successfully!');

  }
</script>

</body>
</html>
