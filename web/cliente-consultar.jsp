<%-- 
    Document   : cliente-consultar
    Created on : 08/01/2021, 12:55:42
    Author     : LUZIA
--%>

<%@page import="utils.Web"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Cliente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Relação de Clientes Cadastrados" />
</jsp:include>

                <h1>Relação de Clientes Cadastrados</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    String pesquisa = request.getParameter("pesquisa");
                    String txtPesquisa = "";
                    List <Cliente> clientes = null;
                    if (pesquisa == null || "".equals(pesquisa)) {
                        clientes= Cliente.consultar();
                    }
                    else {
                        txtPesquisa = request.getParameter("txtPesquisa").toUpperCase();
                        Cliente cliente = null;
                        switch(pesquisa){
                            case "idcliente":
                                cliente = Cliente.consultar(Integer.parseInt(txtPesquisa));
                                clientes = new ArrayList<>();
                                clientes.add(cliente);
                                break;
                            case "nome":
                                clientes = Cliente.consultarNome(txtPesquisa);
                                break;
                            case "tipo":
                                clientes = Cliente.consultarTipo(txtPesquisa);
                                break;
                        }
                    }
                %>

                <form method="POST" class="form-pesquisa">
                    <label>Pesquisar: </label>
                    <select class="form-campo" name="pesquisa">
                        <option value="" <%out.write("".equals(pesquisa) || pesquisa == null ? " selected='selected'" : "");%> > </option> <!-- retorna a lista completa cadastrada -->
                        <option value="idcliente" <%out.write("idcliente".equals(pesquisa) ? " selected='selected'" : "");%> >Código</option> <!-- fixa a opção de consulta no código após busca -->
                        <option value="nome" <%out.write("nome".equals(pesquisa) ? " selected='selected'" : "");%> >Cliente</option>
                        <option value="tipo" <%out.write("tipo".equals(pesquisa) ? " selected='selected'" : "");%> >Tipo (PF / PJ)</option>
                    </select>
                    <input class="form-campo" type="text" name="txtPesquisa" value="<%out.write(txtPesquisa);%>"/>
                    <button type="submit" class="btn btn-azul btn-sm"><i class="fas fa-search"></i> Buscar</button>
                </form>
                    
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="direita">Código</th> <!-- Item do cabeçalho da tabela -->
                        <th class="esquerda">Nome</th>
                        <th class="centro">Tipo</th>
                        <th class="direita">CPF/CNPJ</th> 
                        <th class="direita">Telefone</th>
                        <th class="direita">Telefone2</th>
                        <th class="esquerda">E-Mail</th>
                        <th class="centro">Data Nasc / Cliente desde:</th>
                        <th class="centro">Ações</th> 
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                        <% for (Cliente cli : clientes) { %>
                            <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                <td class="direita"><%out.write(String.valueOf(cli.getIdCliente()));%></td>
                                <td class="esquerda"><%out.write(cli.getNome());%></td> 
                                <td class="centro"><%out.write(cli.getTipo());%></td>
                                <td class="direita"><%out.write(cli.getCpf_cnpj());%></td>
                                <td class="direita"><%out.write(cli.getTelefone1());%></td>
                                <td class="direita"><%out.write(cli.getTelefone2());%></td>
                                <td class="esquerda"><%out.write(cli.getEmail());%></td>
                                <td class="centro"><%out.write(Web.dataParaString(cli.getDataNascimento()));%></td> 
                                <td class="centro"><%out.write("<a href=cliente-cadastro-alterar.jsp?idcliente="+String.valueOf(cli.getIdCliente())
                                        +"><i class='fas fa-edit' title='Editar'></i></a>");%>&nbsp;&nbsp;&nbsp;<%out.write("<a href=\"javascript:if(confirm('Confirma Exclusão?')){document.location='cliente-excluir.jsp?"
                                        + "idcliente="+String.valueOf(cli.getIdCliente())+"';}\"><i class='fas fa-trash-alt' title='Excluir'></i></a>");%></td>
                            </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                        <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                </table> <!-- Indicação do final da tabela -->

                <div class="grupo-botoes">
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                </div>
<jsp:include page = "footer.jsp"/>
