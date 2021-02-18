<%-- 
    Document   : login
    Created on : 13/01/2021, 09:15:42
    Author     : Maria
--%>


<%  
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

    session.invalidate();
    %><jsp:forward page="login.jsp"/><%
%>  
