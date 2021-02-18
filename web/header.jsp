<%-- 
    Document   : header
    Created on : 14 de fev. de 2021, 21:04:00
    Author     : Janine
--%>
<jsp:include page = "login-validar.jsp"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
    
    String tituloPagina = request.getParameter("tituloPagina");
%>
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
      <nav class="navbar">
        <div class="container">
        <a class="nome-sistema" href="#">JLM GastroSIS</a>
        <div class="d-flex">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item ativo">
              <a class="nav-link" href="./index.jsp">Home</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Cardápios <i class="fas fa-angle-down"></i></a>
              <div class="dropdown-menu" aria-labelledby="dropdown01">
                <a class="dropdown-item" href="./cardapio-cadastrar.jsp">Cadastro de cardápios</a>
                <a class="dropdown-item" href="./cardapio-consultar.jsp">Consulta de cardápios</a>
                <div class="divisor-menu"></div>
                <a class="dropdown-item" href="./cardapiodia-cadastrar.jsp">Cadastro de cardápios do dia</a>
                <a class="dropdown-item" href="./cardapiodia-consultar.jsp">Consulta de cardápios do dia</a>
                <div class="divisor-menu"></div>
                <a class="dropdown-item" href="./prato-cadastrar.jsp">Cadastro de pratos</a>
                <a class="dropdown-item" href="./prato-consultar.jsp">Consulta de pratos</a>           
              </div>        
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="dropdown02" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Produtos <i class="fas fa-angle-down"></i></a>
              <div class="dropdown-menu" aria-labelledby="dropdown02">
                <a class="dropdown-item" href="./produto-cadastrar.jsp">Cadastro de produtos</a>
                <a class="dropdown-item" href="./produto-consultar.jsp">Consulta de produtos</a>
                <div class="divisor-menu"></div>
                <a class="dropdown-item" href="./compra-cadastrar.jsp">Cadastro de compras</a>
                <a class="dropdown-item" href="./compra-consultar.jsp">Consulta de compras</a>
                <div class="divisor-menu"></div>
                <a class="dropdown-item" href="./venda-cadastrar.jsp">Cadastro de vendas</a>
                <a class="dropdown-item" href="./venda-consultar.jsp">Consulta de vendas</a>           
              </div>        
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="dropdown03" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Pessoas <i class="fas fa-angle-down"></i></a>
              <div class="dropdown-menu" aria-labelledby="dropdown03">
                <a class="dropdown-item" href="./cliente-cadastrar.jsp">Cadastro de clientes</a>
                <a class="dropdown-item" href="./cliente-consultar.jsp">Consulta de clientes</a>
                <div class="divisor-menu"></div>
                <a class="dropdown-item" href="./fornecedor-cadastrar.jsp">Cadastro de fornecedores</a>
                <a class="dropdown-item" href="./fornecedor-consultar.jsp">Consulta de fornecedores</a>
                <div class="divisor-menu"></div>
                <a class="dropdown-item" href="./funcionario-cadastrar.jsp">Cadastro de funcionários</a>
                <a class="dropdown-item" href="./funcionario-consultar.jsp">Consulta de funcionários</a>           
                <div class="divisor-menu"></div>
                <a class="dropdown-item" href="./usuario-cadastrar.jsp">Cadastro de usuários</a>
                <a class="dropdown-item" href="./usuario-consultar.jsp">Consulta de usuários</a>
              </div>        
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Relatórios <i class="fas fa-angle-down"></i></a>
              <div class="dropdown-menu" aria-labelledby="dropdown04">
                <a class="dropdown-item" href="./relatorio-venda.jsp">Vendas</a>
                <a class="dropdown-item" href="./relatorio-producao.jsp">Em produção</a>
                <a class="dropdown-item" href="./relatorio-produzir.jsp">Aguardando produção</a>
                <a class="dropdown-item" href="./relatorio-cliente.jsp">Clientes</a>
                <a class="dropdown-item" href="./relatorio-cardapio.jsp">Cardápios</a>
                <a class="dropdown-item" href="./relatorio-prato.jsp">Pratos</a>           
                <a class="dropdown-item" href="./relatorio-compra.jsp">Compras</a>
                <a class="dropdown-item" href="./relatorio-produto.jsp">Produtos</a>
                <a class="dropdown-item" href="./relatorio-fornecedor.jsp">Fornecedores</a>
                <a class="dropdown-item" href="./relatorio-funcionario.jsp">Funcionários</a>
                <a class="dropdown-item" href="./relatorio-usuario.jsp">Usuários</a>
              </div>        
            </li>
          </ul>
          <ul class="navbar-nav">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="dropdown05" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=session.getAttribute("nomeUsuario")%> <i class="fas fa-angle-down"></i></a>
              <div class="dropdown-menu" aria-labelledby="dropdown05">
                <a class="dropdown-item" href="./logout.jsp">Logout</a>
              </div>
            </li>
          </ul>
        </div>
      </div>
      </nav>
    </header>
    
    <main role="main" class="flex-shrink-0">
      <div class="container">