<%-- 
    Document   : produto-consultar
    Created on : 6 de jan de 2021, 17:34:19
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Produto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Relação de Produtos Cadastrados" />
</jsp:include>
                <h1>Relação de Produtos Cadastrados</h1>
                <%
                    String pesquisa = request.getParameter("pesquisa");
                    String txtPesquisa = "";
                    List <Produto> produtos = null;
                    if (pesquisa == null || "".equals(pesquisa)) {
                        produtos = Produto.consultar();
                    }
                    else {
                        txtPesquisa = request.getParameter("txtPesquisa").toUpperCase();
                        Produto produto = null;
                        switch(pesquisa){
                            case "idproduto":
                                produto = Produto.consultar(Integer.parseInt(txtPesquisa));
                                produtos = new ArrayList<>();
                                produtos.add(produto);
                                break;
                            case "descricaoproduto":
                                produtos = Produto.consultarProduto(txtPesquisa);
                                break;
                        }
                    }
                %>

                <form method="POST" class="form-pesquisa">
                    <label>Pesquisar: </label>
                    <select class="form-campo" name="pesquisa">
                        <option value="" <%out.write("".equals(pesquisa) || pesquisa == null ? " selected='selected'" : "");%> > </option> <!-- retorna a lista completa cadastrada -->
                        <option value="idproduto" <%out.write("idproduto".equals(pesquisa) ? " selected='selected'" : "");%> >Código</option> <!-- fixa a opção de consulta no código após busca -->
                        <option value="descricaoproduto" <%out.write("descricaoproduto".equals(pesquisa) ? " selected='selected'" : "");%> >Produto</option>
                    </select>
                    <input class="form-campo"  type="text" name="txtPesquisa" value="<%out.write(txtPesquisa);%>"/>
                    <button class="btn btn-azul btn-sm" type="submit"><i class="fas fa-search"></i> Buscar</button>
                </form>
                    
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="direita">Código</th> <!-- Item do cabeçalho da tabela -->
                        <th class="esquerda">Descrição do Produto</th>
                        <th class="direita">Estoque</th>
                        <th class="centro">Un de Medida</th>
                        <th class="centro">Ações</th> 
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                        <% for (Produto prod : produtos) { %>
                            <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                <td class="direita"><%out.write(String.valueOf(prod.getIdProduto()));%></td>
                                <td class="esquerda"><%out.write(prod.getDescricaoProduto());%></td> 
                                <td class="direita"><%out.write(Web.arredondaValor(prod.getQtdeProduto()));%></td>
                                <td class="centro"><%out.write(prod.getUnMedida());%></td>
                                <td class="centro"><%out.write("<a href=produto-cadastro-alterar.jsp?idproduto="+String.valueOf(prod.getIdProduto())
                                        +"><i class='fas fa-edit' title='Editar'></i></a>");%>&nbsp;&nbsp;&nbsp;<%out.write("<a href=\"javascript:if(confirm('Confirma Exclusão?')){document.location='produto-excluir.jsp?"
                                        + "idproduto="+String.valueOf(prod.getIdProduto())+"';}\"><i class='fas fa-trash-alt' title='Excluir'></i></a>");%></td>
                            </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                        <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                </table> <!-- Indicação do final da tabela -->

                <div class="grupo-botoes">
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                </div>
<jsp:include page = "footer.jsp"/>
