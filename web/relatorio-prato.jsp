<%-- 
    Document   : relatorio-prato
    Created on : 21 de jan de 2021, 14:30:07
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Produto"%>
<%@page import="classes.Ingrediente"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Prato"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Pratos" />
</jsp:include>
                <h1>Pratos</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    List <Prato> pratos = new ArrayList<>();
                    pratos = Prato.consultar();
                %>

                    <table class="tabela-relatorio"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Prato</th> <!-- Item do cabeçalho da tabela -->
                            <th class="centro">Rendimento</th>
                            <th class="centro">Tempo de Preparo</th>
                            <th class="direita">Preço do Prato</th>
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody > <!-- Indicação de início do corpo da tabela -->
                            <% for (Prato prato : pratos) { %>
                                <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                    <td class="esquerda"><%out.write(String.valueOf(prato.getNome()));%></td>
                                    <td class="centro"><%out.write(Web.inteiroParaString(prato.getRendimento()));%></td>
                                    <td class="centro"><%out.write(Web.inteiroParaString(prato.getTempoPreparo()));%></td>
                                    <td class="direita"><%out.write(Web.moedaParaString(prato.getValorPrato()));%></td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="padding-bottom: 10px;">
                                        <table class="tabela-relatorio">
                                            <thead>
                                                <th class="esquerda" style="width: 50%;">Produto</th>
                                                <th class="direita" style="width: 15%;">Quantidade</th>
                                                <th class="centro" style="width: 15%;">Un Medida</th>
                                                <th class="direita" style="width: 20%;">Valor</th>
                                            </thead>
                                        <%
                                            for (Ingrediente ingrediente : prato.getIngredientes()) {
                                            Produto produto = Produto.consultar(ingrediente.getIdproduto());
                                        %>
                                                <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                                    <td class="esquerda" style="width: 50%;"><%out.write(produto.getDescricaoProduto());%></td>
                                                    <td class="direita" style="width: 15%;"><%out.write(Web.floatParaString(ingrediente.getQtde()));%></td>
                                                    <td class="centro" style="width: 15%;"><%out.write(ingrediente.getUnMedida());%></td>
                                                    <td class="direita" style="width: 20%;"><%out.write(Web.moedaParaString(ingrediente.getValorIngrediente()));%></td>
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
                var vRelatorio = "relatorio-prato.jsp";
                window.print();
            }
        </script>
<jsp:include page = "footer-simples.jsp"/>
