<%-- 
    Document   : compra-consultar
    Created on : 2 de jan de 2021, 20:50:10
    Author     : Janine
--%>

<%@page import="utils.DataHora"%>
<%@page import="utils.Web"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="classes.Compra"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Relação de Compras Cadastradas" />
</jsp:include>
                <h1>Relação de Compras Cadastradas</h1>
                <%
                    String pesquisa = request.getParameter("pesquisa");
                    String txtPesquisa = "";
                    List <Compra> compras = null;
                    if (pesquisa == null || "".equals(pesquisa)) {
                        compras = Compra.consultar();
                    }
                    else {
                        txtPesquisa = request.getParameter("txtPesquisa").toUpperCase();
                        Compra compra = null;
                        switch(pesquisa){
                            case "idcompra":
                                compra = Compra.consultar(Integer.parseInt(txtPesquisa));
                                compras = new ArrayList<>();
                                compras.add(compra);
                                break;
                            case "nomefornecedor":
                                compras = compra.consultarFornecedor(txtPesquisa);
                                break;
                            case "descricaoproduto":
                                compras = compra.consultarProduto(txtPesquisa);
                                break;
                        }
                    }
                %>                

                <form method="POST" class="form-pesquisa">
                    <label>Pesquisar: </label>
                    <select class="form-campo" name="pesquisa">
                        <option value="" <%out.write("".equals(pesquisa) || pesquisa == null ? " selected='selected'" : "");%> > </option> <!-- retorna a lista completa cadastrada -->
                        <option value="idcompra" <%out.write("idcompra".equals(pesquisa) ? " selected='selected'" : "");%> >Código</option> <!-- fixa a opção de consulta no código após busca -->
                        <option value="nomefornecedor" <%out.write("nomefornecedor".equals(pesquisa) ? " selected='selected'" : "");%> >Fornecedor</option>
                        <option value="descricaoproduto" <%out.write("descricaoproduto".equals(pesquisa) ? " selected='selected'" : "");%> >Produto</option>
                    </select>
                    <input class="form-campo" type="text" name="txtPesquisa" value="<%out.write(txtPesquisa);%>"/>
                    <button class="btn btn-azul btn-sm" type="submit"><i class="fas fa-search"></i> Buscar</button>
                </form>
                    
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="direita">Código</th> <!-- Item do cabeçalho da tabela -->
                        <th class="esquerda">Fornecedor</th> 
                        <th class="centro">Data de Cotação</th>
                        <th class="centro">Data de Compra</th>
                        <th class="centro">Data de Entrada</th> 
                        <th class="direita">Valor Total</th>
                        <th class="centro">Ações</th>
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody> <!-- Indicação de início do corpo da tabela -->
                        <% for (Compra compra : compras) { %>
                            <tr> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                <td class="direita"><%out.write(String.valueOf(compra.getIdCompra()));%></td>
                                <td class="esquerda"><%out.write(compra.getFornecedor().getNome());%></td>
                                <td class="centro"><%out.write(Web.dataParaString(compra.getDataCotacao()));%></td>
                                <td class="centro"><%out.write(Web.dataParaString(compra.getDataCompra()));%></td>
                                <td class="centro"><%out.write(Web.dataParaString(compra.getDataEntrada()));%></td>
                                <td class="direita"><%out.write(Web.moedaParaString(compra.getValorTotal()));%></td> 
                                <td class="centro"><a href="javascript:visualizarItens(<%=compra.getIdCompra()%>)"><i class="fas fa-list" title="Visualizar itens"></i></a>
                                    &nbsp;&nbsp;&nbsp;<%out.write("<a href=compra-cadastro-alterar.jsp?idcompra="+String.valueOf(compra.getIdCompra())
                                        +"><i class='fas fa-edit' title='Editar'></i></a>");%>&nbsp;&nbsp;&nbsp;<%out.write("<a href=\"javascript:if(confirm('Confirma Exclusão?')){document.location='compra-excluir.jsp?"
                                        + "idcompra="+String.valueOf(compra.getIdCompra())+"';}\"><i class='fas fa-trash-alt' title='Excluir'></i></a>");%></td>
                            </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                        <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                </table> <!-- Indicação do final da tabela -->
                
                <div class="grupo-botoes">
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';"/>Cancelar</button>
                </div>

        <script>
            function visualizarItens(idCompra) {
                var vItens = "compra-consultar-itens.jsp?idcompra=" + idCompra;
                window.open(vItens,'itensCompra','location=no,height=1800,width=1800,scrollbars=yes,status=yes,top=100,left=100');
            }
        </script>
<jsp:include page = "footer.jsp"/>
