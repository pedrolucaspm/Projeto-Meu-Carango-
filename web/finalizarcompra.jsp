<%@ page import="java.sql.*, org.json.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("usuarioLogado") == null) {
        response.sendRedirect("Login.html");
        return;
    }
%>
<html>
<head>
    <title>Finalizar Compra</title>
</head>
<body style="background:#111;color:#fff;font-family:sans-serif;padding:20px;">
    <h2>Processando Pedido...</h2>

<%
    String carrinhoJson = request.getParameter("carrinho");

    if (carrinhoJson == null || carrinhoJson.trim().isEmpty()) {
%>
        <p style="color:#f55;">Erro: Nenhum dado de carrinho recebido!</p>
<%
    } else {
        out.println("<pre>JSON recebido: " + carrinhoJson + "</pre>");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/meucarango", "root", "123456789");

            JSONArray carrinhoArray = new JSONArray(carrinhoJson);

            String sql = "INSERT INTO pedidos (nome, preco, marca, imagem) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            for (int i = 0; i < carrinhoArray.length(); i++) {
                JSONObject item = carrinhoArray.getJSONObject(i);
                String nome = item.getString("nome");
                double preco = item.getDouble("preco");
               
                String marca = item.has("marca") ? item.getString("marca") : "Desconhecida";
                String imagem = item.has("imagem") ? item.getString("imagem") : null;

                stmt.setString(1, nome);
                stmt.setDouble(2, preco);
                stmt.setString(3, marca);
                stmt.setString(4, imagem);
                stmt.executeUpdate();

                out.println("<p>Inserido: " + nome + " | " + preco + " | " + marca + " | " + imagem + "</p>");
            }
%>
            <p style="color:#0f0;">Pedido finalizado com sucesso!</p>
            <script>
                alert("Compra finalizada com sucesso!");
                localStorage.removeItem("carrinho");
                setTimeout(() => window.location.href = "index.html", 2000);
            </script>
<%
        } catch (Exception e) {
%>
            <p style="color:#f55;">Erro ao finalizar pedido: <%= e.getMessage() %></p>
            <pre><%= e.toString() %></pre>
<%
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch(Exception e) {}
            if (conn != null) try { conn.close(); } catch(Exception e) {}
        }
    }
%>
<form id="finalizarForm" action="finalizarcompra.jsp" method="post">
  <input type="hidden" name="carrinho" id="carrinhoInput" />
  <button type="submit">Finalizar Compra</button>
</form>

<script>
  
  document.getElementById('finalizarForm').addEventListener('submit', function(event) {
    var carrinho = localStorage.getItem('carrinho'); // Pega o JSON do carrinho
    if (!carrinho || carrinho === '[]') {
      event.preventDefault();
      alert('Carrinho vazio! Adicione produtos antes de finalizar.');
      return;
    }
    document.getElementById('carrinhoInput').value = carrinho;
  });
</script>

</body>
</html>
