<%-- 
    Document   : relatorio-compra
    Created on : 15 de jan de 2021, 17:45:07
    Author     : Janine
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="utils.Web"%>
<%@page import="classes.Produto"%>
<%@page import="classes.ItemCompra"%>
<%@page import="classes.Compra"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Compras" />
</jsp:include>

                <h1>Compras</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    List <Compra> compras = new ArrayList<>();
                    compras = Compra.consultar();
                %>

                    <table class="tabela-relatorio"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Fornecedor</th>  <!-- Item do cabeçalho da tabela -->
                            <th class="centro">Data de Cotação</th>
                            <th class="centro">Data de Compra</th>
                            <th class="centro">Data de Entrada</th> 
                            <th class="direita">Valor Total</th>
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody> <!-- Indicação de início do corpo da tabela -->
                            <% for (Compra compra : compras) { %>
                                <tr> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                    <td class="esquerda"><%out.write(compra.getFornecedor().getNome());%></td>
                                    <td class="centro"><%out.write(Web.dataParaString(compra.getDataCotacao()));%></td>
                                    <td class="centro"><%out.write(Web.dataParaString(compra.getDataCompra()));%></td>
                                    <td class="centro"><%out.write(Web.dataParaString(compra.getDataEntrada()));%></td>
                                    <td class="direita"><%out.write(Web.moedaParaString(compra.getValorTotal()));%></td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="padding-bottom: 6px;">
                                        <table class="tabela-relatorio">
                                            <thead>
                                                <th class="esquerda" style="width: 50%;">Produto</th>
                                                <th class="direita" style="width: 15%;">Quantidade</th>
                                                <th class="centro" style="width: 15%;">Un Medida</th>
                                                <th class="direita" style="width: 20%;">Valor da Compra</th>
                                            </thead>                                
                                        <%
                                            for (ItemCompra item : compra.getItens()) {
                                                Produto produto = Produto.consultar(item.getIdProduto());
                                        %>
                                                 <tr> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                                    <td class="esquerda" style="width: 50%;"><%out.write(produto.getDescricaoProduto());%></td>
                                                    <td class="direita" style="width: 15%;"><%out.write(Web.floatParaString(item.getQtdeCompra()));%></td>
                                                    <td class="centro" style="width: 15%;"><%out.write(item.getUnMedida());%></td>
                                                    <td class="direita" style="width: 20%;"><%out.write(Web.moedaParaString(item.getValorCompra()));%></td>
                                                </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                                            <% } %>
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
                var vRelatorio = "relatorio-compra.jsp";
                window.print();
            }
        </script>
<jsp:include page = "footer-simples.jsp"/>
