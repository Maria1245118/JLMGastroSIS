<%-- 
    Document   : header
    Created on : 14 de fev. de 2021, 21:04:00
    Author     : Janine
--%>
<jsp:include page = "login-validar.jsp"/>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
    
    String tituloPagina = request.getParameter("tituloPagina");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>JLM GastroSIS - <%=tituloPagina%></title>
        <link href="./styles/fontawesome/css/fontawesome.css" rel="stylesheet">
        <link href="./styles/fontawesome/css/solid.css" rel="stylesheet">
        <link href="./styles/estilos-geral.css" rel="stylesheet">
        <link rel="icon" href="./imagens/Food.ico">
    </head>
    <body>    
    <header>          
    <main role="main" class="flex-shrink-0">
      <div class="container">