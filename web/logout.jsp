<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Invalida a sessão
    session.invalidate();

    // Redireciona para a página visual de logout (HTML bonito)
    response.sendRedirect("logout.html");
%>
