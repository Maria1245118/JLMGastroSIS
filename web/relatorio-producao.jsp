<%-- 
    Document   : relatorio-producao
    Created on : 15 de jan de 2021, 17:45:07
    Author     : Janine
--%>

<%@page import="classes.CardapioVenda"%>
<%@page import="classes.Cardapio"%>
<%@page import="classes.ItemVenda"%>
<%@page import="utils.Web"%>
<%@page import="classes.Venda"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Vendas em Produção" />
</jsp:include>
                <h1>Vendas em Produção</h1>
                <%
                    List <Venda> vendas = new ArrayList<>();
                    vendas = Venda.consultarProduzir(true);
                %>

                    <table class="tabela-relatorio"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Cliente</th>  <!-- Item do cabeçalho da tabela -->
                            <th class="centro">Data de Produção</th> 
                            <th class="centro">Produção</th>
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody> <!-- Indicação de início do corpo da tabela -->
                            <% for (Venda venda : vendas) { %>
                                <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                    <td class="esquerda"><%out.write(venda.getCliente().getNome());%></td>
                                    <td class="centro"><%out.write(Web.dataParaString(venda.getDataProducao()));%></td>
                                    <td class="centro"><%out.write(Web.booleanParaString(venda.isProducao()));%></td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="padding-bottom: 10px;">
                                        <table style="border-bottom: 1px solid black; border-top: 1px dashed black; width: 100%;">
                                            <thead>
                                                <th class="esquerda" style="width: 50%;">Cardápio</th>
                                                <th class="direita" style="width: 50%;">Valor do Cardápio</th>
                                            </thead>
                                        <%
                                            float totalVenda = 0;
                                            for (CardapioVenda cardapioVenda : venda.getItensCardapioVenda()) {
                                                Cardapio cardapio = Cardapio.consultar(cardapioVenda.getIdCardapio());
                                                totalVenda += cardapioVenda.getValorTotal();
                                        %>
                                                     <tr id="botao" > <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                                        <td class="esquerda" style="width: 50%;"><%out.write(cardapio.getDescCardapio());%></td>
                                                        <td class="direita" style="width: 50%;"><%out.write(Web.moedaParaString(cardapioVenda.getValorTotal()));%></td>
                                                    </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                                                <br/>
                                                <tr>
                                                    <td colspan="2" style="padding-bottom: 10px;">
                                                <table class="tabela-relatorio">
                                                    <thead>
                                                        <tr>
                                                            <th class="esquerda" style="width: 50%">Prato</th>
                                                            <th class="direita" style="width: 20%">Quantidade</th>                            
                                                            <th class="direita" style="width: 30%">Valor do Prato</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <%
                                                        for (ItemVenda item : cardapioVenda.getItens()) {
                                                    %>        
                                                            <tr id="botao">
                                                                <td class="esquerda" style="width: 50%"><%out.write(item.getPrato().getNome());%></td>
                                                                <td class="direita" style="width: 20%"><%out.write(Web.inteiroParaString(item.getQtdeVenda()));%></td>
                                                                <td class="direita" style="width: 30%"><%out.write(Web.moedaParaString(item.getValorVenda()));%></td>
                                                            </tr>
                                                    <% } %>
                                                    </tbody>
                                                </table>
                                                <br/>
                                                <br/>
                                                <br/>
                                                <% } %>
                                            <tr>
                                                <td colspan="5" id="total" style="text-align: right; border-bottom: 2px solid black">
                                                    <strong>Valor Total da Venda = <%out.write(Web.moedaParaString(totalVenda));%></strong>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody> <!-- Indicação de final do corpo da tabela -->
                    </table> <!-- Indicação do final da tabela -->

                    <div class="grupo-botoes">
                        <button type="button" class="btn btn-verde btn-sm" onclick="gerarRelatorio()">Imprimir</button>
                        <button type="reset" class="btn btn-verde btn-sm" onclick="document.location='index.jsp';">Cancelar</button>
                    </div>
        <script>
            function gerarRelatorio() {
                var vRelatorio = "relatorio-producao.jsp";
                window.print();
            }
        </script>
<jsp:include page = "footer-simples.jsp"/>

