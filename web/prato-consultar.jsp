<%-- 
    Document   : prato-consultar
    Created on : 12/01/2021, 19:14:00
    Author     : luzia
--%>

<%@page import="utils.Web"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Prato"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Relação de Pratos Cadastrados" />
</jsp:include>

                <h1>Relação de Pratos Cadastrados</h1>
                <%
                    String pesquisa = request.getParameter("pesquisa");
                    String txtPesquisa = "";
                    List <Prato> pratos = null;
                    if (pesquisa == null || "".equals(pesquisa)) {
                        pratos = Prato.consultar();
                    }
                    else {
                        txtPesquisa = request.getParameter("txtPesquisa").toUpperCase();
                        Prato prato = null;
                        switch(pesquisa){
                            case "idprato":
                                prato = Prato.consultar(Integer.parseInt(txtPesquisa));
                                pratos = new ArrayList<>();
                                pratos.add(prato);
                                break;
                            case "nomeprato":
                                pratos = prato.consultarNome(txtPesquisa);
                                break;
                            case "descricaoproduto":
                                pratos = prato.consultarProduto(txtPesquisa);
                                break;
                        }
                    }
                %>

                <form method="POST" class="form-pesquisa">
                    <label>Pesquisar: </label>
                    <select class="form-campo" name="pesquisa">
                        <option value="" <%out.write("".equals(pesquisa) || pesquisa == null ? " selected='selected'" : "");%> > </option> <!-- retorna a lista completa cadastrada -->
                        <option value="idprato" <%out.write("idprato".equals(pesquisa) ? " selected='selected'" : "");%> >Código</option> <!-- fixa a opção de consulta no código após busca -->
                        <option value="nomeprato"<%out.write("nomeprato".equals(pesquisa) ? " selected='selected'" : "");%> >Prato</option>
                        <option value="descricaoproduto"<%out.write("descricaoproduto".equals(pesquisa) ? " selected='selected'" : "");%> >Produto</option>
                    </select>
                    <input class="form-campo" type="text" name="txtPesquisa" value="<%out.write(txtPesquisa);%>"/>
                    <button class="btn btn-azul btn-sm" type="submit"><i class="fas fa-search"></i> Buscar</button>
                </form>
                    
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="direita">Código</th> <!-- Item do cabeçalho da tabela -->
                        <th class="esquerda">Prato</th>
                        <th class="direita">Rendimento</th>
                        <th class="direita">Tempo de Preparo</th>
                        <th class="direita">Preço do Prato</th>
                        <th class="direita">Margem de Lucro</th>
                        <th class="centro">Ações</th>
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                        <% for (Prato prato : pratos) { %>
                            <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                <td class="direita"><%out.write(String.valueOf(prato.getIdPrato()));%></td>
                                <td class="esquerda"><%out.write(String.valueOf(prato.getNome()));%></td>
                                <td class="direita"><%out.write(Web.inteiroParaString(prato.getRendimento()) + " porções");%></td>
                                <td class="direita"><%out.write(Web.inteiroParaString(prato.getTempoPreparo()) + " minutos");%></td>
                                <td class="direita"><%out.write(Web.moedaParaString(prato.getValorPrato()));%></td>
                                <td class="direita"><%out.write(Web.floatParaString(prato.getLucro()) + " %");%></td>
                                <td class="centro"><a href="javascript:visualizarIngredientes(<%=prato.getIdPrato()%>)"><i class="fas fa-list" title="Visualizar ingredientes"></i></a>&nbsp;&nbsp;&nbsp;<%out.write("<a href=prato-cadastro-alterar.jsp?idprato="+String.valueOf(prato.getIdPrato())
                                        +"><i class='fas fa-edit' title='Editar'></i></a>");%>&nbsp;&nbsp;&nbsp;<%out.write("<a href=\"javascript:if(confirm('Confirma Exclusão?')){document.location='prato-excluir.jsp?"
                                        + "idprato="+String.valueOf(prato.getIdPrato())+"';}\"><i class='fas fa-trash-alt' title='Excluir'></i></a>");%></td>
                            </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                        <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                </table> <!-- Indicação do final da tabela -->

                <div class="grupo-botoes">
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                </div>

        <script>
            function visualizarIngredientes(idPrato) {
                var vIngredientes = "prato-consultar-ingredientes.jsp?idprato=" + idPrato;
                window.open(vIngredientes,'ingredientes','location=no,heigh=1800,width=1800,scrollbars=yes,status=yes,top=100,left=100');
            }
        </script>
<jsp:include page = "footer.jsp"/>