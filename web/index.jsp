<%-- 
    Document   : index
    Created on : 21 de jan de 2021, 18:21:54
    Author     : Janine
--%>

<%@page import="classes.Prato"%>
<%@page import="classes.PratoCardapio"%>
<%@page import="classes.CardapioDia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Home" />
</jsp:include>
            
            <div class="cardapio">
            <%
                CardapioDia cardapioDia = null;
                try {
                    cardapioDia = CardapioDia.consultarData(LocalDate.now());
                } catch (Exception ex) {
                    out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                }
                if (cardapioDia != null) {
                    for(PratoCardapio pratoCardapio : cardapioDia.getCardapio().getPratos()) {
                        Prato prato = Prato.consultar(pratoCardapio.getIdPrato());
            %>
                        <p><%=prato.getNome()%></p>
            <%
                    }
                }
            %>
            </div>
<jsp:include page = "footer.jsp"/>