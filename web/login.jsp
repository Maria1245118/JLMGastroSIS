<%-- 
    Document   : login
    Created on : 13/01/2021, 09:15:42
    Author     : Maria
--%>

<%@page import="classes.Usuario"%>
<%  
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

    String nuser = request.getParameter("nuser");
    String senha = request.getParameter("senha");
    String msgErro = ("");

    if ((nuser != null) && (senha != null) && !(nuser.isEmpty()) && !(senha.isEmpty())) {
        if (Usuario.podeLogar(nuser,senha)) {
            Usuario usuario = Usuario.consultar(nuser);
            String nomeUsuario = "";
            
            if (usuario.getFuncionario() == null) {
                nomeUsuario = nuser; // assume o login como o nome do usuário
            }
            else {
                nomeUsuario = usuario.getFuncionario().getNome().split(" ")[0]; // pega o primeiro nome do funcionário vinculado com o usuário
            }
            
            session.setAttribute("usuario", nuser);     
            session.setAttribute("nomeUsuario", nomeUsuario);
            %><jsp:forward page="index.jsp"/><% 
        } else {
            msgErro = "Usuário ou Senha Inválidos"; 
        } 
    }              
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">    
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>JLM GastroSIS - Login</title>
    <link href="./styles/estilos-login.css" rel="stylesheet">
    <link rel="icon" href="./imagens/Food.ico">
  </head>
  <body class="text-center">    
    <form class="form-login" method="post">
      <h1 id="nome-sistema">JLM GastroSIS</h1>
      <h1>Informe seus dados</h1>
      <input type="input" id="nuser" name="nuser" class="form-campo" placeholder="Usuário" required="" autofocus="">
      <input type="password" id="senha" name="senha" class="form-campo" placeholder="Senha" required="">
      <% if(!"".equals(msgErro)) { %>
      <div class="alerta alert-erro" id="erroAcesso" role="alert"><%=msgErro%></div>
      <% } %>
      <button class="botao" type="submit">Entrar</button>
      <p class="rodape">© 2020-2021 JLM GastroSIS</p>
    </form>
  </body>
</html>
