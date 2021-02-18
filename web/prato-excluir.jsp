<%-- 
    Document   : prato-excluir
    Created on : 12/01/2021, 19:50:50
    Author     : LUZIA
--%>

<%@page import="classes.Prato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Prato Cadastrado" />
</jsp:include>
                <h1>Exclusão de Prato Cadastrado</h1>

                <%
                    String idPrato = request.getParameter("idprato");
                    Prato prato = new Prato();
                    if (idPrato != null) {
                        prato = prato.consultar(Integer.parseInt(idPrato));
                        if (prato == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Prato Não Localizado</div>");
                        } else {
                            try {
                                prato.excluir();
                                out.write("<div class='alerta alerta-verde'>Prato Excluído com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Prato" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>