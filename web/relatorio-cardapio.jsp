<%-- 
    Document   : relatorio-cardapio
    Created on : 15 de jan de 2021, 17:45:07
    Author     : Janine
--%>

<%@page import="classes.Prato"%>
<%@page import="classes.PratoCardapio"%>
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
    <jsp:param name="tituloPagina" value="Cardápios" />
</jsp:include>

                <h1>Cardápios</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    List <Cardapio> cardapios = new ArrayList<>();
                    cardapios = Cardapio.consultar();
                %>
                    <table class="tabela-relatorio"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Cardápio</th> <!-- Item do cabeçalho da tabela -->
                            <th class="direita">Nº de Pessoas</th> 
                            <th class="direita">Preço por Pessoa</th>
                            <th class="direita">Preço do Cardápio</th>
                            <th class="centro">Buffet Interno</th>
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody> <!-- Indicação de início do corpo da tabela -->
                            <% for (Cardapio menu : cardapios) { %>
                                <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                    <td class="esquerda"><%out.write(menu.getDescCardapio());%></td>
                                    <td class="direita"><%out.write(Web.inteiroParaString(menu.getQtdePessoas()));%></td>
                                    <td class="direita"><%out.write(Web.moedaParaString(menu.getValorUnitario()));%></td>
                                    <td class="direita"><%out.write(Web.moedaParaString(menu.getValorTotal()));%></td>
                                    <td class="centro"><%out.write(Web.booleanParaString(menu.isBuffetInterno()));%></td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="padding-bottom: 10px;">
                                        <table class="tabela-relatorio">
                                            <thead>
                                                <th class="esquerda" style="width: 50%;">Prato</th>
                                                <th class="centro" style="width: 15%;">Rendimento</th>
                                                <th class="centro" style="width: 15%;">Tempo de Preparo</th>
                                                <th class="direita" style="width: 20%;">Preço do Prato</th>
                                            </thead>
                                            <%
                                                for (PratoCardapio prmenu : menu.getPratos()) {
                                                    Prato prato = Prato.consultar(prmenu.getIdPrato());
                                            %>
                                                     <tr id="botao" > <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                                        <td class="esquerda" style="width: 50%;"><%out.write(prato.getNome());%></td>
                                                        <td class="centro" style="width: 15%;"><%out.write(Web.inteiroParaString(prato.getRendimento()));%></td>
                                                        <td class="centro" style="width: 15%;"><%out.write(Web.inteiroParaString(prato.getTempoPreparo()));%></td>
                                                        <td class="direita" style="width: 20%;"><%out.write(Web.moedaParaString(prato.getValorPrato()));%></td>
                                                    </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                                                <% } %>
                                        </table>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody> <!-- Indicação de final do corpo da tabela -->
                    </table> <!-- Indicação do final da tabela -->
                    <hr/>
                    <div class="grupo-botoes">
                        <button type="button" class="btn btn-verde btn-sm" onclick="gerarRelatorio()">Imprimir</button>
                        <button type="reset" class="btn btn-verde btn-sm" onclick="document.location='index.jsp';">Cancelar</button>
                    </div>
        <script>
            function gerarRelatorio() {
                var vRelatorio = "relatorio-cardapio.jsp";
                window.print();
            }
        </script>
<jsp:include page = "footer-simples.jsp"/>