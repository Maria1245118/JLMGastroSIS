<%-- 
    Document   : cardapio-consultar
    Created on : 8 de jan de 2021, 08:14:59
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Cardapio"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Relação de Cardápios Cadastrados" />
</jsp:include>

                <h1>Relação de Cardápios Cadastrados</h1>
                <%
                    String pesquisa = request.getParameter("pesquisa");
                    String txtPesquisa = "";
                    List <Cardapio> cardapios = null;
                    if (pesquisa == null || "".equals(pesquisa)) {
                        cardapios = Cardapio.consultar();
                    }
                    else {
                        txtPesquisa = request.getParameter("txtPesquisa").toUpperCase();
                        Cardapio cardapio = null;
                        switch(pesquisa){
                            case "idcardapio":
                                cardapio = Cardapio.consultar(Integer.parseInt(txtPesquisa));
                                cardapios = new ArrayList<>();
                                cardapios.add(cardapio);
                                break;
                            case "desccardapio":
                                cardapios = Cardapio.consultarCardapio(txtPesquisa);
                                break;
                            case "buffetinterno":
                                cardapios = Cardapio.consultarBuffet(Web.stringParaBoolean(txtPesquisa));
                                break;
                            case "prato":
                                cardapios = Cardapio.consultarPrato(txtPesquisa);
                                break;
                        }
                    }
                %>

                <form method="POST" class="form-pesquisa">
                    <label>Pesquisar: </label>
                    <select class="form-campo" name="pesquisa">
                        <option value="" <%out.write("".equals(pesquisa) || pesquisa == null ? " selected='selected'" : "");%> > </option> <!-- retorna a lista completa cadastrada -->
                        <option value="idcardapio" <%out.write("idcardapio".equals(pesquisa) ? " selected='selected'" : "");%> >Código</option> <!-- fixa a opção de consulta no código após busca -->
                        <option value="desccardapio" <%out.write("desccardapio".equals(pesquisa) ? " selected='selected'" : "");%> >Cardápio</option>
                        <option value="prato"<%out.write("prato".equals(pesquisa) ? " selected='selected'" : "");%> >Prato</option>
                        <option value="buffetinterno"<%out.write("buffetinterno".equals(pesquisa) ? " selected='selected'" : "");%> >Buffet Interno</option>
                    </select>
                    <input class="form-campo" type="text" name="txtPesquisa" value="<%out.write(txtPesquisa);%>"/>
                    <button class="btn btn-azul btn-sm" type="submit"><i class="fas fa-search"></i> Buscar</button>
                </form>
                    
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="direita">Código</th> <!-- Item do cabeçalho da tabela -->
                        <th class="esquerda">Cardápio</th>
                        <th class="direita">Nº de Pessoas</th> 
                        <th class="direita">Preço por Pessoa</th>
                        <th class="direita">Preço do Cardápio</th>
                        <th class="centro">Buffet Interno</th>
                        <th class="centro">Ações</th> 
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                        <% for (Cardapio menu : cardapios) { %>
                            <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                <td class="direita"><%out.write(String.valueOf(menu.getIdCardapio()));%></td>
                                <td class="esquerda"><%out.write(menu.getDescCardapio());%></td>
                                <td class="direita"><%out.write(Web.inteiroParaString(menu.getQtdePessoas()));%></td>
                                <td class="direita"><%out.write(Web.moedaParaString(menu.getValorUnitario()));%></td>
                                <td class="direita"><%out.write(Web.moedaParaString(menu.getValorTotal()));%></td>
                                <td class="centro"><%out.write(Web.booleanParaString(menu.isBuffetInterno()));%></td>
                                <td class="centro"><a href="javascript:visualizarPratos(<%=menu.getIdCardapio()%>)"><i class="fas fa-list" title="Visualizar pratos"></i></a>&nbsp;&nbsp;&nbsp;<%out.write("<a href=cardapio-cadastro-alterar.jsp?idcardapio="+String.valueOf(menu.getIdCardapio())
                                        +"><i class='fas fa-edit' title='Editar'></i></a>");%>&nbsp;&nbsp;&nbsp;<%out.write("<a href=\"javascript:if(confirm('Confirma Exclusão?')){document.location='cardapio-excluir.jsp?"
                                        + "idcardapio="+String.valueOf(menu.getIdCardapio())+"';}\"><i class='fas fa-trash-alt' title='Excluir'></i></a>");%></td>
                            </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                        <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                </table> <!-- Indicação do final da tabela -->

                <div class="grupo-botoes">
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                </div>

        <script>
            function visualizarPratos(idCardapio) {
                var vPratos = "cardapio-consultar-pratos.jsp?idcardapio=" + idCardapio;
                window.open(vPratos,'pratosCardapio','location=no,height=1800,width=1800,scrollbars=yes,status=yes,top=100,left=100');
            }
        </script>
<jsp:include page = "footer.jsp"/>