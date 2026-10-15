<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <link rel="stylesheet" href="Login.css" />
</head>
<body>
  <div class="login-container">

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
  String email = request.getParameter("email");
  String senha = request.getParameter("senha");

  if (email != null && senha != null) {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");

      String url = "jdbc:mysql://localhost:3306/meucarango?useSSL=false&serverTimezone=UTC";
      String usuario = "root";
      String senhaBanco = "123456789";
      Connection conn = DriverManager.getConnection(url, usuario, senhaBanco);

      // Converte a senha digitada para Hash SHA-256 antes de comparar
      String senhaHash = hashSenha(senha);

      String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";
      PreparedStatement stmt = conn.prepareStatement(sql);
      stmt.setString(1, email);
      stmt.setString(2, senhaHash); // Agora compara Hash com Hash!

      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        session.setAttribute("usuarioLogado", rs.getString("nome"));
        session.setAttribute("email", rs.getString("email"));
        response.sendRedirect("index.jsp");
        return;
      } else {
%>
        <h2>Email ou senha incorretos!</h2>
<%
      }

      rs.close();
      stmt.close();
      conn.close();
    } catch (Exception e) {
%>
      <h2>Erro ao conectar: <%= e.getMessage() %></h2>
<%
    }
  }
%>

    <form action="index.html" method="get">
      <button type="submit" class="btn-voltar">Voltar para o Início</button>
    </form>
    <form action="login.html" method="get">
      <button type="submit" class="btn-tentar">Tentar novamente</button>
    </form>
  </div>
</body>
</html>