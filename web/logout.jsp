<%-- 
    Document   : login
    Created on : 13/01/2021, 09:15:42
    Author     : Maria
--%>


<%  
    request.setCharacterEncoding("UTF-8"); //para n�o desconfigurar a acentua��o

    session.invalidate();
    %><jsp:forward page="login.jsp"/><%
%>  
