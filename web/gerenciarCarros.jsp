<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String usuarioLogado = (String) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.html");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/meucarango?useSSL=false&serverTimezone=UTC";
    String usuario = "root";
    String senha = "123456789";
    Connection conn = null;
    PreparedStatement stmt = null;

    String acao = request.getParameter("acao");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, usuario, senha);

        if ("cadastrar".equals(acao)) {
            String modelo = request.getParameter("modelo");
            String marca = request.getParameter("marca");
            int ano = Integer.parseInt(request.getParameter("ano"));
            double preco = Double.parseDouble(request.getParameter("preco"));

            stmt = conn.prepareStatement("INSERT INTO carros (modelo, marca, ano, preco) VALUES (?, ?, ?, ?)");
            stmt.setString(1, modelo);
            stmt.setString(2, marca);
            stmt.setInt(3, ano);
            stmt.setDouble(4, preco);
            stmt.executeUpdate();

        } else if ("excluir".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            stmt = conn.prepareStatement("DELETE FROM carros WHERE id = ?");
            stmt.setInt(1, id);
            stmt.executeUpdate();

        } else if ("alterar".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String modelo = request.getParameter("modelo");
            String marca = request.getParameter("marca");
            int ano = Integer.parseInt(request.getParameter("ano"));
            double preco = Double.parseDouble(request.getParameter("preco"));

            stmt = conn.prepareStatement("UPDATE carros SET modelo=?, marca=?, ano=?, preco=? WHERE id=?");
            stmt.setString(1, modelo);
            stmt.setString(2, marca);
            stmt.setInt(3, ano);
            stmt.setDouble(4, preco);
            stmt.setInt(5, id);
            stmt.executeUpdate();
        }

    } catch (Exception e) {
        out.println("<p style='color:red;'>Erro: " + e.getMessage() + "</p>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
  
    <meta charset="UTF-8">
  <title>Gerenciar Carros</title>
  <link rel="stylesheet" href="gerenciarCarro.css" />
  <style>
    body { font-family: Arial, sans-serif; background-color: black; padding: 20px; }
    h2 { text-align: center; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
    form { margin-top: 30px; }
    input, button { padding: 8px; margin: 5px; }
    .form-inline input { width: 20%; }
  </style>
</head>
<body>

<h2>Gerenciar Carros</h2>

<form method="post" action="gerenciarCarros.jsp">
  <input type="hidden" name="acao" value="cadastrar" />
  <input type="text" name="modelo" placeholder="Modelo" required />
  <input type="text" name="marca" placeholder="Marca" required />
  <input type="number" name="ano" placeholder="Ano" required />
  <input type="number" step="0.01" name="preco" placeholder="Preço" required />
  <button type="submit">Cadastrar Carro</button>
</form>

<%
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, usuario, senha);

        stmt = conn.prepareStatement("SELECT * FROM carros");
        ResultSet rs = stmt.executeQuery();
%>

<table>
  <tr>
    <th>ID</th>
    <th>Modelo</th>
    <th>Marca</th>
    <th>Ano</th>
    <th>Preço</th>
    <th>Ações</th>
  </tr>
<%
    while (rs.next()) {
%>
  <tr>
    <form method="post" action="gerenciarCarros.jsp">
      <td><%= rs.getInt("id") %><input type="hidden" name="id" value="<%= rs.getInt("id") %>" /></td>
      <td><input type="text" name="modelo" value="<%= rs.getString("modelo") %>" /></td>
      <td><input type="text" name="marca" value="<%= rs.getString("marca") %>" /></td>
      <td><input type="number" name="ano" value="<%= rs.getInt("ano") %>" /></td>
      <td><input type="number" step="0.01" name="preco" value="<%= rs.getDouble("preco") %>" /></td>
      <td>
        <button type="submit" name="acao" value="alterar">Alterar</button>
        <button type="submit" name="acao" value="excluir" onclick="return confirm('Tem certeza que deseja excluir?')">Excluir</button>
      </td>
    </form>
  </tr>
<%
    }
    rs.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("<p style='color:red;'>Erro ao listar: " + e.getMessage() + "</p>");
}
%>
</table>

<a href="index.jsp">← Voltar para o Início</a>

</body>
<img align="right" src="fundogerenciar.jpg" width="400" height="300">
</html>
