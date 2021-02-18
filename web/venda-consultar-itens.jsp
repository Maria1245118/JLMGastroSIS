<%-- 
    Document   : venda-consultar-itens
    Created on : 17/01/2021, 10:00:02
    Author     : Familia
--%>

<%@page import="classes.Prato"%>
<%@page import="classes.PratoCardapio"%>
<%@page import="classes.CardapioVenda"%>
<%@page import="classes.Cardapio"%>
<%@page import="utils.Web"%>
<%@page import="classes.ItemVenda"%>
<%@page import="classes.Venda"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Relação de Itens de Vendas Cadastradas" />
</jsp:include>
                <h1>Relação de Itens de Vendas Cadastradas</h1>
                <%
                    int idVenda = Integer.parseInt(request.getParameter("idvenda"));
                    Venda venda = Venda.consultar(idVenda);
                %>

                <h3>Itens da Venda - Venda Nº <%=idVenda%></h3>
                        <%
                            float totalVenda = 0;
                            for (CardapioVenda cardapioVenda : venda.getItensCardapioVenda()) {
                                Cardapio cardapio = Cardapio.consultar(cardapioVenda.getIdCardapio());
                                totalVenda += cardapioVenda.getValorTotal();
                        %>
                        <table class="tabela-consulta" style="margin-bottom: 2px !important;"> <!-- Indicação do início da tabela -->
                            <thead> <!-- Indicação de início do cabeçalho da tabela -->
                                <tr>
                                    <th class="esquerda">Cardápio</th> <!-- Item do cabeçalho da tabela -->
                                    <th class="direita">Valor do Cardápio</th>
                                </tr>
                            </thead> <!-- Indicação de final do cabeçalho da tabela -->
                            <tbody> <!-- Indicação de início do corpo da tabela -->
                                        <tr> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                            <td class="esquerda"><%out.write(cardapio.getDescCardapio());%></td>
                                            <td class="direita"><%out.write(Web.moedaParaString(cardapioVenda.getValorTotal()));%></td>
                                        </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                            </tbody>
                        </table>

                        <table class="tabela-consulta"  style="margin-top: 2px !important;">
                            <thead>
                                <tr>
                                    <th class="esquerda">Prato</th>
                                    <th class="direita">Quantidade</th>                            
                                    <th class="direita">Valor do Prato</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                for (ItemVenda item : cardapioVenda.getItens()) {
                            %>        
                                    <tr>
                                        <td class="esquerda"><%out.write(item.getPrato().getNome());%></td>
                                        <td class="direita"><%out.write(Web.inteiroParaString(item.getQtdeVenda()));%></td>
                                        <td class="direita"><%out.write(Web.moedaParaString(item.getValorVenda()));%></td>
                                    </tr>
                            <% } %>
                            </tbody>
                        </table>

                        <% } %>
                        
                        <table class="tabela-consulta" style="width: 100%">
                            <tr>
                                <td id="total" style="text-align: right">
                                    <strong>Valor Total da Venda = <%out.write(Web.moedaParaString(totalVenda));%></strong>
                                </td>
                            </tr>
                        </table>
<jsp:include page = "footer.jsp"/>
