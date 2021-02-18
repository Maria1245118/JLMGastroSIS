<%-- 
    Document   : cardapio-consultar-pratos
    Created on : 21 de jan de 2021, 10:09:09
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Prato"%>
<%@page import="classes.PratoCardapio"%>
<%@page import="classes.Cardapio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Relação de Pratos de Cardápios Cadastrados" />
</jsp:include>

                <h1>Relação de Pratos de Cardápios Cadastrados</h1>
                <%
                    int idCardapio = Integer.parseInt(request.getParameter("idcardapio"));
                    Cardapio menu = Cardapio.consultar(idCardapio);
                %>

                <h3>Pratos do Cardápio - Cardápio Nº <%=idCardapio%></h3>
                
                    <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="direita">Código</th> <!-- Item do cabeçalho da tabela -->
                            <th class="esquerda">Prato</th>
                            <th class="direita">Rendimento</th>
                            <th class="direita">Tempo de Preparo</th>
                            <th class="direita">Preço do Prato</th> 
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                            <%
                                for (PratoCardapio prmenu : menu.getPratos()) {
                                    Prato prato = Prato.consultar(prmenu.getIdPrato());
                            %>
                                    <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                        <td class="direita"><%out.write(String.valueOf(prato.getIdPrato()));%></td>
                                        <td class="esquerda"><%out.write(prato.getNome());%></td>
                                        <td class="direita"><%out.write(Web.inteiroParaString(prato.getRendimento()));%></td>
                                        <td class="direita"><%out.write(Web.inteiroParaString(prato.getTempoPreparo()));%></td>
                                        <td class="direita"><%out.write(Web.moedaParaString(prato.getValorPrato()));%></td>
                                    </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                                <% } %>
                        </tbody> <!-- Indicação de final do corpo da tabela -->
                        <tfoot>
                            <tr>
                                <td colspan="5" class="direita">
                                    <strong>Valor Total do Cardápio = <%out.write(Web.moedaParaString(menu.getVTotal()));%></strong>
                                </td>
                            </tr>
                        </tfoot>
                    </table> <!-- Indicação do final da tabela -->
<jsp:include page = "footer.jsp"/>