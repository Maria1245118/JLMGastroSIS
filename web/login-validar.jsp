<%-- 
    Document   : login-validar
    Created on : 5 de fev de 2021, 21:49:57
    Author     : Janine
--%>


<%
    String nUser=(String)session.getAttribute("usuario");

    //redireciona usu�rio para p�gina de login
    if(nUser == null){
        %><jsp:forward page="login.jsp"/><%
    }
%>
