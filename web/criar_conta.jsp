<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Conta Criada</title>
  <link rel="stylesheet" href="Criarconta.css">
</head>
<body>
<div class="criar-container">

<%! 
public static String hashSenha(String senha) throws Exception {
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] hash = md.digest(senha.getBytes("UTF-8"));
    StringBuilder hexString = new StringBuilder();
    for (byte b : hash) {
        String hex = Integer.toHexString(0xff & b);
        if (hex.length() == 1) hexString.append('0');
        hexString.append(hex);
    }
    return hexString.toString();
}
%>

<%
  String nome = request.getParameter("nome");
  String email = request.getParameter("email");
  String senha = request.getParameter("senha");
  String confirmarSenha = request.getParameter("confirmar_senha");

  if (nome == null || email == null || senha == null || confirmarSenha == null) {
%>
    <h2>Preencha todos os campos!</h2>
    <a href="Criarconta.html">Voltar</a>
<%
  } else if (!senha.equals(confirmarSenha)) {
%>
    <h2>As senhas não coincidem!</h2>
 
<%
  } else {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/meucarango", "root", "123456789");

      PreparedStatement check = conn.prepareStatement("SELECT * FROM usuarios WHERE email = ?");
      check.setString(1, email);
      ResultSet rs = check.executeQuery();

      if (rs.next()) {
%>
        <h2>Este e-mail já está cadastrado!</h2>
       
<%
      } else {
        String senhaHash = hashSenha(senha);
        PreparedStatement stmt = conn.prepareStatement("INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)");
        stmt.setString(1, nome);
        stmt.setString(2, email);
        stmt.setString(3, senhaHash);

        int resultado = stmt.executeUpdate();
        if (resultado > 0) {
%>
          <h2>Conta criada com sucesso!</h2>
          <a href="Login.html">Fazer login</a>
<%
        } else {
%>
          <h2>Erro ao criar a conta.</h2>
         
<%
        }

        stmt.close();
      }

      rs.close();
      check.close();
      conn.close();
    } catch (Exception e) {
%>
      <h2>Erro: <%= e.getMessage() %></h2>
<%
    }
  }
%>


<form action="index.html" method="get">
  <button type="submit" class="btn-voltar">Voltar para o Início</button>
</form>

<form action="Criarconta.html" method="get">
  <button type="submit" class="btn-tentar">Tentar novamente</button>
</form>
</div>
</body>
</html>
