<%-- 
    Document   : fornecedor-excluir
    Created on : 30 de dez de 2020, 16:36:22
    Author     : Janine
--%>

<%@page import="classes.Fornecedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Fornecedor Cadastrado" />
</jsp:include>

                <h1>Exclusão de Fornecedor Cadastrado</h1>
                <%
                    String idFornecedor = request.getParameter("idfornecedor");
                    Fornecedor fornec = new Fornecedor();
                    if (idFornecedor != null) {
                        fornec = fornec.consultar(Integer.parseInt(idFornecedor));
                        if (fornec == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Cadastro Não Localizado</div>");
                        } else {
                            try {
                                fornec.excluir();
                                out.write("<div class='alerta alerta-verde'>Cadastro Excluído com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Cadastro" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>
