<%-- 
    Document   : cardapiodia-excluir
    Created on : 2 de fev de 2021, 11:19:04
    Author     : Janine
--%>

<%@page import="classes.CardapioDia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Cardápio do Dia Cadastrado" />
</jsp:include>
                <h1>Exclusão de Cardápio do Dia Cadastrado</h1>

                <%
                    String idCardapioDia = request.getParameter("idcardapiodia");
                    CardapioDia menuDia = new CardapioDia();
                    if (idCardapioDia != null) {
                        menuDia = menuDia.consultar(Integer.parseInt(idCardapioDia));
                        if (menuDia == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Cardápio do Dia Não Localizado</div>");
                        } else {
                            try {
                                menuDia.excluir();
                                out.write("<div class='alerta alerta-verde'>Cardápio do Dia Excluído com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Cardápio do Dia" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>