<%-- 
    Document   : cardapiodia-consultar
    Created on : 2 de fev de 2021, 11:18:50
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Cardapio"%>
<%@page import="classes.CardapioDia"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Relação de Cardápios do Dia Cadastrados" />
</jsp:include>

                <h1>Relação de Cardápios do Dia Cadastrados</h1>
                <%
                    String pesquisa = request.getParameter("pesquisa");
                    String txtPesquisa = "";
                    List <CardapioDia> menusDia = null;
                    if (pesquisa == null || "".equals(pesquisa)) {
                        menusDia = CardapioDia.consultar();
                    }
                    else {
                        txtPesquisa = request.getParameter("txtPesquisa").toUpperCase();
                        CardapioDia menuDia = null;
                        switch(pesquisa){
                            case "idcardapiodia":
                                menuDia = CardapioDia.consultar(Integer.parseInt(txtPesquisa));
                                menusDia = new ArrayList<>();
                                menusDia.add(menuDia);
                                break;
                            case "idcardapio":
                                menuDia = CardapioDia.consultarIdCardapio(Integer.parseInt(txtPesquisa));
                                break;
                        }
                    }
                %>

                <form method="POST" class="form-pesquisa">
                    <label>Pesquisar: </label>
                    <select class="form-campo" name="pesquisa">
                        <option value="" <%out.write("".equals(pesquisa) || pesquisa == null ? " selected='selected'" : "");%> > </option> <!-- retorna a lista completa cadastrada -->
                        <option value="idcardapiodia" <%out.write("idcardapiodia".equals(pesquisa) ? " selected='selected'" : "");%> >Código</option> <!-- fixa a opção de consulta no código após busca -->
                        <option value="idcardapio" <%out.write("idcardapio".equals(pesquisa) ? " selected='selected'" : "");%> >Cardápio</option>
                    </select>
                    <input class="form-campo" type="text" name="txtPesquisa" value="<%out.write(txtPesquisa);%>"/>
                    <button class="btn btn-azul btn-sm" type="submit"><i class="fas fa-search"></i> Buscar</button>
                </form>
                    
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="direita">Código</th> <!-- Item do cabeçalho da tabela -->
                        <th class="esquerda">Cardápio</th> 
                        <th class="centro">Data do Cardápio</th>
                        <th class="centro">Ações</th> 
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                        <% for (CardapioDia menuDia : menusDia) { %>
                            <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                <td class="direita"><%out.write(String.valueOf(menuDia.getIdCardapioDia()));%></td>
                                <td class="esquerda"><%out.write(menuDia.getCardapio().getDescCardapio());%></td>
                                <td class="centro"><%out.write(Web.dataParaString(menuDia.getDataCardapio()));%></td>
                                <td class="centro"><%out.write("<a href=cardapiodia-cadastro-alterar.jsp?idcardapiodia="+String.valueOf(menuDia.getIdCardapioDia())
                                        +"><i class='fas fa-edit' title='Editar'></i></a>");%>&nbsp;&nbsp;&nbsp;<%out.write("<a href=\"javascript:if(confirm('Confirma Exclusão?')){document.location='cardapiodia-excluir.jsp?"
                                        + "idcardapiodia="+String.valueOf(menuDia.getIdCardapioDia())+"';}\"><i class='fas fa-trash-alt' title='Excluir'></i></a>");%></td>
                            </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                        <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                </table> <!-- Indicação do final da tabela -->

                <div class="grupo-botoes">
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';"/>Cancelar</button>
                </div>
<jsp:include page = "footer.jsp"/>