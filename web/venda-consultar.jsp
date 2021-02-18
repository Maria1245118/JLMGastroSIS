<%-- 
    Document   : venda-consultar
    Created on : 17/01/2021, 10:22:08
    Author     : Familia
--%>

<%@page import="utils.Web"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Venda"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Relação de Vendas Cadastradas" />
</jsp:include>
                <h1>Relação de Vendas Cadastradas</h1>
                <%
                    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação

                    String pesquisa = request.getParameter("pesquisa");
                    String txtPesquisa = "";
                    List <Venda> vendas = null;
                    if (pesquisa == null || "".equals(pesquisa)) {
                        vendas = Venda.consultar();
                    }
                    else {
                        txtPesquisa = request.getParameter("txtPesquisa").toUpperCase();
                        Venda venda = null;
                        switch(pesquisa){
                            case "idvenda":
                                venda = Venda.consultar(Integer.parseInt(txtPesquisa));
                                vendas = new ArrayList<>();
                                vendas.add(venda);
                                break;
                            case "nomecliente":
                                vendas = Venda.consultarCliente(txtPesquisa);
                                break;
/*                            case "descricaocardapio":
                                vendas = Venda.consultarCardapio(txtPesquisa);
                                break;
*/                            case "producao":
                                vendas = Venda.consultarProduzir(Web.stringParaBoolean(txtPesquisa));
                                break;
                        }
                    }
                %>

                
                <form class="form-pesquisa" method="POST">
                    <label>Pesquisar: </label>
                    <select class="form-campo" name="pesquisa">
                        <option value="" <%out.write("".equals(pesquisa) || pesquisa == null ? " selected='selected'" : "");%> > </option> <!-- retorna a lista completa cadastrada -->
                        <option value="idvenda" <%out.write("idvenda".equals(pesquisa) ? " selected='selected'" : "");%> >Código</option> <!-- fixa a opção de consulta no código após busca -->
                        <option value="nomecliente" <%out.write("nomecliente".equals(pesquisa) ? " selected='selected'" : "");%> >Cliente</option>
                        <option value="producao" <%out.write("producao".equals(pesquisa) ? " selected='selected'" : "");%> >Produção</option>
                    </select>
                    <input class="form-campo" type="text" name="txtPesquisa" value="<%out.write(txtPesquisa);%>"/>
                    <button type="submit" class="btn btn-azul btn-sm"><i class="fas fa-search"></i> Buscar</button>
                </form>
                    
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="direita">Código</th> <!-- Item do cabeçalho da tabela -->
                        <th class="esquerda">Cliente</th> 
                        <th class="centro">Data de Orçamento</th>
                        <th class="centro">Data de Pedido</th>
                        <th class="centro">Data de Produção</th> 
                        <th class="centro">Produção</th>
                        <th class="centro">Ações</th>
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody> <!-- Indicação de início do corpo da tabela -->
                        <% for (Venda venda : vendas) { %>
                            <tr> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                <td class="direita"><%out.write(String.valueOf(venda.getIdVenda()));%></td>
                                <td class="esquerda"><%out.write(venda.getCliente().getNome());%></td>
                                <td class="centro"><%out.write(Web.dataParaString(venda.getDataOrcamento()));%></td> <!-- recupera a data que está no banco e devolve String -->
                                <td class="centro"><%out.write(Web.dataParaString(venda.getDataPedido()));%></td>
                                <td class="centro"><%out.write(Web.dataParaString(venda.getDataProducao()));%></td>
                                <td class="centro"><%out.write(Web.booleanParaString(venda.isProducao()));%></td>
                                <td class="centro"><a href="javascript:visualizarItens(<%=venda.getIdVenda()%>)"><i class="fas fa-list" title="Visualizar itens"></i></a>&nbsp;&nbsp;&nbsp;
                                    <%out.write("<a href=venda-cadastro-alterar.jsp?idvenda="+String.valueOf(venda.getIdVenda())
                                        +"><i class='fas fa-edit' title='Editar'></i></a>");%>&nbsp;&nbsp;&nbsp;<%out.write("<a href=\"javascript:if(confirm('Confirma Exclusão?')){document.location='venda-excluir.jsp?"
                                        + "idvenda="+String.valueOf(venda.getIdVenda())+"';}\"><i class='fas fa-trash-alt' title='Excluir'></i></a>");%></td>
                            </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                        <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                </table> <!-- Indicação do final da tabela -->

                <div class="grupo-botoes">
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button
                </div>

        <script>
            function visualizarItens(idVenda) {
                var vItens = "venda-consultar-itens.jsp?idvenda=" + idVenda;
                window.open(vItens,'itensVenda','location=no,height=1800,width=1800,scrollbars=yes,status=yes,top=100,left=100');
            }
        </script>
<jsp:include page = "footer.jsp"/>
