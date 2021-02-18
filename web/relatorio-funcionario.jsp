<%-- 
    Document   : relatorio-funcionario
    Created on : 21 de jan de 2021, 14:30:31
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Funcionario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Funcionários" />
</jsp:include>
                <h1>Funcionários</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    List <Funcionario> funcionarios = new ArrayList<>();
                    funcionarios = Funcionario.consultar();
                %>

                    <table class="tabela-relatorio"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Funcionário</th> <!-- Item do cabeçalho da tabela -->
                            <th class="direita">CPF</th> 
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
                            <th class="centro">Data de Nascimento </th>
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody> <!-- Indicação de início do corpo da tabela -->
                            <% for (Funcionario func : funcionarios) { %>
                                <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                    <td class="esquerda"><%out.write(func.getNome()); %></td> 
                                    <td class="direita"><%out.write(func.getCpf()); %></td>
                                    <td class="direita"><%out.write(func.getCep());%></td>
                                    <td class="centro"><%out.write(func.getUf());%></td>
                                    <td class="esquerda"><%out.write(func.getCidade());%></td>
                                    <td class="esquerda"><%out.write(func.getBairro());%></td>
                                    <td class="esquerda"><%out.write(func.getEndereco());%></td>
                                    <td class="direita"><%out.write(Web.inteiroParaString(func.getNumero()));%></td>
                                    <td class="esquerda"><%out.write(func.getComplemento());%></td>
                                    <td class="direita"><%out.write(func.getTelefone1());%></td>
                                    <td class="direita"><%out.write(func.getTelefone2());%></td>
                                    <td class="esquerda"><%out.write(func.getEmail());%></td>
                                    <td class="centro"><%out.write(Web.dataParaString(func.getDataNascimento()));%></td> 
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
                var vRelatorio = "relatorio-funcionario.jsp";
                window.print();
            }
        </script>
<jsp:include page = "footer-simples.jsp"/>
