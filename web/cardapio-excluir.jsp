<%-- 
    Document   : cardapio-excluir
    Created on : 8 de jan de 2021, 08:15:16
    Author     : luzia
--%>

<%@page import="classes.Cardapio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Cardápio Cadastrado" />
</jsp:include>

                <h1>Exclusão de Cardápio Cadastrado</h1>

                <%
                    String idCardapio = request.getParameter("idcardapio");
                    Cardapio menu = new Cardapio();
                    if (idCardapio != null) {
                        menu = menu.consultar(Integer.parseInt(idCardapio));
                        if (menu == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Cardápio Não Localizado</div>");
                        } else {
                            try {
                                menu.excluir();
                                out.write("<div class='alerta alerta-verde'>Cardápio Excluído com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Cardápio" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>