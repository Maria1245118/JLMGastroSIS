<%-- 
    Document   : relatorio-fornecedor
    Created on : 21 de jan de 2021, 14:30:47
    Author     : Janine
--%>


<%@page import="utils.Web"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Fornecedor"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Fornecedores" />
</jsp:include>

                <h1>Fornecedores</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    List <Fornecedor> fornecedores = new ArrayList<>();
                    fornecedores = Fornecedor.consultar();
                %>

                    <table class="tabela-relatorio"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Fornecedor</th> <!-- Item do cabeçalho da tabela -->
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
                            <th class="centro">Fornecedor desde: </th>
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody> <!-- Indicação de início do corpo da tabela -->
                            <% for (Fornecedor fornec : fornecedores) { %>
                                <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                    <td class="esquerda"><%out.write(fornec.getNome());%></td> 
                                    <td class="centro"><%out.write(fornec.getTipo());%></td>
                                    <td class="direita"><%out.write(fornec.getCpf_cnpj());%></td>
                                    <td class="direita"><%out.write(fornec.getCep());%></td>
                                    <td class="centro"><%out.write(fornec.getUf());%></td>
                                    <td class="esquerda"><%out.write(fornec.getCidade());%></td>
                                    <td class="esquerda"><%out.write(fornec.getBairro());%></td>
                                    <td class="esquerda"><%out.write(fornec.getEndereco());%></td>
                                    <td class="direita"><%out.write(Web.inteiroParaString(fornec.getNumero()));%></td>
                                    <td class="esquerda"><%out.write(fornec.getComplemento());%></td>
                                    <td class="direita"><%out.write(fornec.getTelefone1());%></td>
                                    <td class="direita"><%out.write(fornec.getTelefone2());%></td>
                                    <td class="esquerda"><%out.write(fornec.getEmail());%></td>
                                    <td class="centro"><%out.write(Web.dataParaString(fornec.getDataCadastro()));%></td> 
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
                var vRelatorio = "relatorio-fornecedor.jsp";
                window.print();
            }
        </script>
<jsp:include page = "footer-simples.jsp"/>
