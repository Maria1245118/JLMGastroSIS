<%-- 
    Document   : prato-consultar-ingredientes
    Created on : 17 de jan de 2021, 10:21:24
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Produto"%>
<%@page import="classes.Ingrediente"%>
<%@page import="classes.Prato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Relação de Ingredientes Cadastrados" />
</jsp:include>

                <h1>Relação de Ingredientes Cadastrados</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    int idPrato = Integer.parseInt(request.getParameter("idprato"));
                    Prato prato = Prato.consultar(idPrato);
                %>
                <hr/>
                <h3>Ingredientes do Prato Nº <%=idPrato%></h3>
                
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="esquerda">Produto</th> <!-- Item do cabeçalho da tabela -->
                        <th class="direita">Quantidade</th>
                        <th class="centro">Un Medida</th>
                        <th class="direita">Valor</th>
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                        <%
                            for (Ingrediente ingrediente : prato.getIngredientes()) {
                                Produto produto = Produto.consultar(ingrediente.getIdproduto());
                        %>
                        <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                            <td class="esquerda"><%out.write(produto.getDescricaoProduto());%></td>
                            <td class="direita"><%out.write(Web.floatParaString(ingrediente.getQtde()));%></td>
                            <td class="centro"><%out.write(ingrediente.getUnMedida());%></td>
                            <td class="direita"><%out.write(Web.floatParaString(ingrediente.getValorIngrediente()));%></td>
                        </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                            <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                    <tfoot>
                        <tr>
                            <td class="direita" colspan="4">
                                <strong>Valor Total dos Ingredientes = <%out.write(Web.moedaParaString(prato.getTotalIngrediente()));%></strong>
                            </td>
                        </tr>
                    </tfoot>
                </table> <!-- Indicação do final da tabela -->
<jsp:include page = "footer.jsp"/>
