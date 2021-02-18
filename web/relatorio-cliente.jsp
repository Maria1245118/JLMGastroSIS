<%-- 
    Document   : relatorio-cliente
    Created on : 21 de jan de 2021, 14:30:58
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="classes.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Clientes" />
</jsp:include>

                <h1>Clientes</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    List <Cliente> clientes = new ArrayList<>();
                    clientes = Cliente.consultar();
                %>

                    <table class="tabela-relatorio"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Cliente</th> <!-- Item do cabeçalho da tabela -->
                            <th class="centro">Tipo de Cadastro</th>
                            <th class="direita">CPF/CNPJ</th> 
                            <th class="direita">CEP</th> 
                            <th class="centro">Estado</th>
                            <th class="esquerda">Município</th> 
                            <th class="esquerda">Bairro</th>
                            <th class="esquerda">Endereço</th> 
                            <th class="direita">Nº</th>
                            <th class="esquerda">Complemento</th>
                            <th class="direita">Telefone</th>
                            <th class="direita">Telefone</th>
                            <th class="esquerda">E-Mail</th>
                            <th class="centro">Data de Nascimento</th>
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody> <!-- Indicação de início do corpo da tabela -->
                            <% for (Cliente cli : clientes) { %>
                                <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                    <td class="esquerda"><%out.write(cli.getNome());%></td> 
                                    <td class="centro"><%out.write(cli.getTipo());%></td>
                                    <td class="direita"><%out.write(cli.getCpf_cnpj());%></td>
                                    <td class="direita"><%out.write(cli.getCep());%></td>
                                    <td class="centro"><%out.write(cli.getUf());%></td>
                                    <td class="esquerda"><%out.write(cli.getCidade());%></td>
                                    <td class="esquerda"><%out.write(cli.getBairro());%></td>
                                    <td class="esquerda"><%out.write(cli.getEndereco());%></td>
                                    <td class="direita"><%out.write(Web.inteiroParaString(cli.getNumero()));%></td>
                                    <td class="esquerda"><%out.write(cli.getComplemento());%></td>
                                    <td class="direita"><%out.write(cli.getTelefone1());%></td>
                                    <td class="direita"><%out.write(cli.getTelefone2());%></td>
                                    <td class="esquerda"><%out.write(cli.getEmail());%></td>
                                    <td class="centro"><%out.write(Web.dataParaString(cli.getDataNascimento()));%></td> 
                                </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                            <% } %>
                        </tbody> <!-- Indicação de final do corpo da tabela -->
                    </table> <!-- Indicação do final da tabela -->

                    <div class="grupo-botoes">
                        <button type="button" class="btn btn-verde btn-sm" onclick="gerarRelatorio()">Imprimir</button>
                        <button type="reset" class="btn btn-verde btn-sm" onclick="document.location='index.jsp';">Cancelar</button>
                    </div>
        <script>
            function gerarRelatorio() {
                var vRelatorio = "relatorio-cliente.jsp";
                window.print();
            }
        </script>
<jsp:include page = "footer-simples.jsp"/>
