<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String usuarioLogado = (String) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.html");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/meucarango?useSSL=false&serverTimezone=UTC";
    String usuario = "root";
    String senhaBanco = "123456789";
    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, usuario, senhaBanco);
    } catch (Exception e) {
        out.println("<p style='color:red;'>Erro ao conectar ao banco: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Meu Carango - Página Inicial</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: black;
            margin: 30px;
        }
   .container {
    background-color: rgba(0, 0, 0, 0.3); 
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 0 25px rgba(255, 255, 255, 0.1); 
    max-width: 600px;
    margin: auto;
    text-align: center;
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px); 
    border: 1px solid rgba(255, 255, 255, 0.1); 
}
        a.button {
            display: inline-block;
            margin: 15px;
            padding: 10px 25px;
            background-color: #e60000; 
            color: white;
            text-decoration: none;
            border-radius: 8px;
        }
        a.button:hover {
            background-color: #990000; 
        }
        h1 {
            color: #333;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Bem-vindo, <%= usuarioLogado %>!</h1>
    <p>Escolha uma opção abaixo:</p>

    <a class="button" href="gerenciarCarros.jsp">Gerenciar Carros</a><br>
    <a class="button" href="carrinho.jsp">Visualizar Carrinho</a><br>
    <a class="button" href="logout.jsp">Sair</a>

</div>

</body>
 <img align="right" src="Nossas agências.png" width="400" height="300">
</html>

<%
    if (conn != null) {
        conn.close();
    }
%>