<%-- 
    Document   : compra-consultar-itens
    Created on : 15 de jan de 2021, 17:45:07
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Produto"%>
<%@page import="classes.ItemCompra"%>
<%@page import="classes.Compra"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Relação de Itens das Compras Cadastradas" />
</jsp:include>

                <h1>Relação de Itens das Compras Cadastradas</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    int idCompra = Integer.parseInt(request.getParameter("idcompra"));
                    Compra compra = Compra.consultar(idCompra);
                %>
                <h3>Itens da Compra Nº <%=idCompra%></h3>
                    <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Produto</th> <!-- Item do cabeçalho da tabela -->
                            <th class="centro">Quantidade</th>
                            <th class="centro">Un Medida</th>
                            <th class="direita">Valor</th> 
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                            <%
                                for (ItemCompra item : compra.getItens()) {
                                    Produto produto = Produto.consultar(item.getIdProduto());
                            %>
                                    <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                        <td class="esquerda"><%out.write(produto.getDescricaoProduto());%></td>
                                        <td class="centro"><%out.write(Web.floatParaString(item.getQtdeCompra()));%></td>
                                        <td class="centro"><%out.write(item.getUnMedida());%></td>
                                        <td class="direita"><%out.write(Web.moedaParaString(item.getValorCompra()));%></td>
                                    </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                                <% } %>
                        </tbody> <!-- Indicação de final do corpo da tabela -->
                        <tfoot>
                            <tr>
                                <td class="direita" colspan="4">
                                    <strong>Valor Total da Compra = <%out.write(Web.moedaParaString(compra.getValorTotal()));%></strong>
                                </td>
                            </tr>
                        </tfoot>
                    </table> <!-- Indicação do final da tabela -->
<jsp:include page = "footer.jsp"/>
