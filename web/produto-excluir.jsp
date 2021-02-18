<%-- 
    Document   : produto-excluir
    Created on : 6 de jan de 2021, 17:34:39
    Author     : Janine
--%>

<%@page import="classes.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Produto Cadastrado" />
</jsp:include>
                <h1>Exclusão de Produto Cadastrado</h1>
                <%
                    String idProduto = request.getParameter("idproduto");
                    Produto prod = new Produto();
                    if (idProduto != null) {
                        prod = prod.consultar(Integer.parseInt(idProduto));
                        if (prod == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Produto Não Localizado");
                        } else {
                            try {
                                prod.excluir();
                                out.write("<div class='alerta alerta-verde'>Produto Excluído com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Produto" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>