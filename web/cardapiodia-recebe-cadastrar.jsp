<%-- 
    Document   : cardapiodia-recebe-cadastrar
    Created on : 1 de fev de 2021, 15:18:34
    Author     : Janine
--%>

<%@page import="classes.Cardapio"%>
<%@page import="classes.CardapioDia"%>
<%@page import="java.time.LocalDate"%>
<%@page import="utils.Web"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Cardápio do Dia" />
</jsp:include>
                <h1>Cadastro de Cardápio do Dia</h1>

                <%                   
                    Integer idCardapio = Web.valorInteger(request.getParameter("idcardapio"));
                    LocalDate dataCardapio = Web.valorDate(request.getParameter("datacardapio"));
                    
                    CardapioDia cardapioDia = new CardapioDia();
                    cardapioDia.setDataCardapio(dataCardapio);
                    
                    Cardapio cardapio = new Cardapio();
                    cardapio = cardapio.consultar(idCardapio);
                    cardapioDia.setCardapio(cardapio);
                    
                    try {
                        cardapioDia.salvar();
                        out.write("<div class='alerta alerta-verde'>Cardapio do Dia Cadastrado com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>
