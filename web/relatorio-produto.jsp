<%-- 
    Document   : relatorio-produto
    Created on : 21 de jan de 2021, 14:29:55
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Produto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Produtos" />
</jsp:include>
                <h1>Produtos</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    List <Produto> produtos = new ArrayList<>();
                    produtos = Produto.consultar();
                %>

                    <table class="tabela-relatorio"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Produto</th> <!-- Item do cabeçalho da tabela -->
                            <th class="direita">Saldo Disponível</th>
                            <th class="centro">Un de Medida</th>
                            <th class="direita">Valor Última Compra</th>
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody> <!-- Indicação de início do corpo da tabela -->
                            <% for (Produto prod : produtos) { %>
                                <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                    <td class="esquerda"><%out.write(prod.getDescricaoProduto());%></td> 
                                    <td class="direita"><%out.write(Web.arredondaValor(prod.getQtdeProduto()));%></td>
                                    <td class="centro"><%out.write(prod.getUnMedida());%></td>
                                    <td class="direita"><%out.write(Web.moedaParaString(prod.getPrecoCompra()));%></td>
                                </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
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
                var vRelatorio = "relatorio-produto.jsp";
                window.print();
            }
        </script>
<jsp:include page = "footer-simples.jsp"/>