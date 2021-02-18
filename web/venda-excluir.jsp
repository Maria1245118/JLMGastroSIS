<%-- 
    Document   : venda-excluir
    Created on : 17/01/2021, 10:40:55
    Author     : Familia
--%>

<%@page import="classes.Venda"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Venda Cadastrada" />
</jsp:include>
                <h1>Exclusão de Venda Cadastrada</h1>

                <%
                    request.setCharacterEncoding("UTF-8");

                    String idVenda = request.getParameter("idvenda");
                    Venda venda = new Venda();
                    if (idVenda != null) {
                        venda = venda.consultar(Integer.parseInt(idVenda));
                        if (venda == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Venda Não Localizada</div>");
                        } else {
                            try {
                                venda.excluir();
                                out.write("<div class='alerta alerta-verde'>Venda Excluída com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Venda" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>
