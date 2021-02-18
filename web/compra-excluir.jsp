<%-- 
    Document   : compra-excluir
    Created on : 2 de jan de 2021, 20:50:37
    Author     : Janine
--%>

<%@page import="classes.Compra"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Compra Cadastrada" />
</jsp:include>

                <h1>Exclusão de Compra Cadastrada</h1>

                <%
                    String idCompra = request.getParameter("idcompra");
                    Compra comp = new Compra();
                    if (idCompra != null) {
                        comp = comp.consultar(Integer.parseInt(idCompra));
                        if (comp == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Compra Não Localizada</div>");
                        } else {
                            try {
                                comp.excluir();
                                out.write("<div class='alerta alerta-verde'>Compra Excluída com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Compra" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>
