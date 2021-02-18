<%-- 
    Document   : relatorio-usuario
    Created on : 21 de jan de 2021, 14:27:36
    Author     : Janine
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="classes.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header-simples.jsp">
    <jsp:param name="tituloPagina" value="Usuários" />
</jsp:include>
                <h1>Usuários</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    List <Usuario> usuarios = new ArrayList<>();
                    usuarios = Usuario.consultar();
                %>

                    <table class="tabela-relatorio"> <!-- Indicação do início da tabela -->
                        <thead> <!-- Indicação de início do cabeçalho da tabela -->
                            <th class="esquerda">Usuário</th> <!-- Item do cabeçalho da tabela -->
                            <th class="esquerda">Funcionário</th>
                            <th class="esquerda">Email</th> 
                        </thead> <!-- Indicação de final do cabeçalho da tabela -->
                        <tbody> <!-- Indicação de início do corpo da tabela -->
                            <% for (Usuario usuar : usuarios) { %>
                                <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                    <td class="esquerda"><%out.write(usuar.getNuser());%></td> 
                                    <td class="esquerda"><%out.write(usuar.getFuncionario() != null ? usuar.getFuncionario().getNome() : "");%></td>
                                    <td class="esquerda"><%out.write(usuar.getEmail());%></td>
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
                var vRelatorio = "relatorio-usuario.jsp";
                window.print();
            }
        </script>
<jsp:include page = "footer-simples.jsp"/>
