<%-- 
    Document   : fornecedor-consultar
    Created on : 30 de dez de 2020, 16:36:09
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Fornecedor"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Relação de Fornecedores Cadastrados" />
</jsp:include>

                <h1>Relação de Fornecedores Cadastrados</h1>
                <%
                    String pesquisa = request.getParameter("pesquisa");
                    String txtPesquisa = "";
                    List <Fornecedor> fornecedores = null;
                    if (pesquisa == null || "".equals(pesquisa)) {
                        fornecedores = Fornecedor.consultar();
                    }
                    else {
                        txtPesquisa = request.getParameter("txtPesquisa").toUpperCase();
                        Fornecedor fornecedor = null;
                        switch(pesquisa){
                            case "idfornecedor":
                                fornecedor = Fornecedor.consultar(Integer.parseInt(txtPesquisa));
                                fornecedores = new ArrayList<>();
                                fornecedores.add(fornecedor);
                                break;
                            case "nome":
                                fornecedores = Fornecedor.consultarNome(txtPesquisa);
                                break;
                            case "tipo":
                                fornecedores = Fornecedor.consultarTipo(txtPesquisa);
                                break;
                        }
                    }
                %>

                <form method="POST" class="form-pesquisa">
                    <label>Pesquisar: </label>
                    <select class="form-campo" name="pesquisa">
                        <option value="" <%out.write("".equals(pesquisa) || pesquisa == null ? " selected='selected'" : "");%> > </option> <!-- retorna a lista completa cadastrada -->
                        <option value="idfornecedor" <%out.write("idfornecedor".equals(pesquisa) ? " selected='selected'" : "");%> >Código</option> <!-- fixa a opção de consulta no código após busca -->
                        <option value="nome" <%out.write("nome".equals(pesquisa) ? " selected='selected'" : "");%> >Fornecedor</option>
                        <option value="tipo" <%out.write("tipo".equals(pesquisa) ? " selected='selected'" : "");%> >Tipo (PF / PJ)</option>
                    </select>
                    <input class="form-campo" type="text" name="txtPesquisa" value="<%out.write(txtPesquisa);%>"/>
                    <button class="btn btn-azul btn-sm" type="submit"><i class="fas fa-search"></i> Buscar</button>
                </form>
                    
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="direita">Código</th> <!-- Item do cabeçalho da tabela -->
                        <th class="esquerda">Nome do Fornecedor</th>
                        <th class="centro">Tipo</th>
                        <th class="direita">CPF/CNPJ</th> 
                        <th class="direita">Telefone</th>
                        <th class="direita">Telefone 2</th>
                        <th class="esquerda">E-Mail</th>
                        <th class="centro">Fornecedor desde: </th>
                        <th class="centro">Ações</th> 
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                        <% for (Fornecedor fornec : fornecedores) { %>
                            <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                <td class="direita"><%out.write(String.valueOf(fornec.getIdFornecedor()));%></td>
                                <td class="esquerda"><%out.write(fornec.getNome());%></td> 
                                <td class="centro"><%out.write(fornec.getTipo());%></td>
                                <td class="direita"><%out.write(fornec.getCpf_cnpj());%></td>
                                <td class="direita"><%out.write(fornec.getTelefone1());%></td>
                                <td class="direita"><%out.write(fornec.getTelefone2());%></td>
                                <td class="esquerda"><%out.write(fornec.getEmail());%></td>
                                <td class="centro"><%out.write(Web.dataParaString(fornec.getDataCadastro()));%></td> 
                                <td class="centro"><%out.write("<a href=fornecedor-cadastro-alterar.jsp?idfornecedor="+String.valueOf(fornec.getIdFornecedor())
                                        +"><i class='fas fa-edit' title='Editar'></i></a>");%>&nbsp;&nbsp;&nbsp;<%out.write("<a href=\"javascript:if(confirm('Confirma Exclusão?')){document.location='fornecedor-excluir.jsp?"
                                        + "idfornecedor="+String.valueOf(fornec.getIdFornecedor())+"';}\"><i class='fas fa-trash-alt' title='Excluir'></i></a>");%></td>
                            </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                        <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                </table> <!-- Indicação do final da tabela -->
                    
                <div class="grupo-botoes">
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                </div>
<jsp:include page = "footer.jsp"/>