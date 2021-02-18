<%-- 
    Document   : usuario-excluir
    Created on : 12 de jan de 2021, 21:21:21
    Author     : Janine
--%>

<%@page import="classes.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Usuário Cadastrado" />
</jsp:include>
                <h1>Exclusão de Usuário Cadastrado</h1>
                <%
                    String idUsuario = request.getParameter("idusuario");
                    Usuario usuar = new Usuario();
                    if (idUsuario!= null) {
                        usuar = usuar.consultar(Integer.parseInt(idUsuario));
                        if (usuar == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Cadastro Não Localizado<div>");
                        } else {
                            try {
                                usuar.excluir();
                                out.write("<div class='alerta alerta-verde'Cadastro Excluído com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Cadastro" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>