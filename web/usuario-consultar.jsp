<%-- 
    Document   : usuario-consultar
    Created on : 12 de jan de 2021, 21:21:08
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Relação de Usuários Cadastrados" />
</jsp:include>
            <h1>Relação de Usuários Cadastrados</h1>
                <%
                    String pesquisa = request.getParameter("pesquisa");
                    String txtPesquisa = "";
                    List <Usuario> usuarios = null;
                    if (pesquisa == null || "".equals(pesquisa)) {
                        usuarios = Usuario.consultar();
                    }
                    else {
                        txtPesquisa = request.getParameter("txtPesquisa").toUpperCase();
                        Usuario usuario = null;
                        usuarios = new ArrayList<>();
                        switch(pesquisa){
                            case "idUsuario":
                                usuario = Usuario.consultar(Integer.parseInt(txtPesquisa));
                                usuarios.add(usuario);
                                break;
                            case "nuser":
                                usuarios = Usuario.consultarUsuario(txtPesquisa);
                                break;
                            case "func":
                                usuarios = Usuario.consultarFuncionario(txtPesquisa);
                                break;
                        }
                    }
                %>

                <form method="POST" class="form-pesquisa">
                    <label>Pesquisar: </label>
                    <select class="form-campo" name="pesquisa">
                        <option value="" <% out.write("".equals(pesquisa) || pesquisa == null ? " selected='selected'" : "");%> > </option> <!-- retorna a lista completa cadastrada -->
                        <option value="idusuario" <% out.write("idusuario".equals(pesquisa) ? " selected='selected'" : "");%> >Código</option> <!-- fixa a opção de consulta no código após busca -->
                        <option value="nuser" <% out.write("nuser".equals(pesquisa) ? " selected='selected'" : "");%> >Usuário</option>
                        <option value="func" <% out.write("func".equals(pesquisa) ? " selected='selected'" : "");%> >Funcionário</option>
                    </select>
                    <input class="form-campo" type="text" name="txtPesquisa" value="<%out.write(txtPesquisa);%>"/>
                    <button class="btn btn-azul btn-sm" type="submit"><i class="fas fa-search"></i> Buscar</button>
                </form>
                    
                <table class="tabela-consulta"> <!-- Indicação do início da tabela -->
                    <thead> <!-- Indicação de início do cabeçalho da tabela -->
                        <th class="direita">Codigo</th> <!-- Item do cabeçalho da tabela -->
                        <th class="esquerda">Usuário</th>
                        <th class="esquerda">Funcionário</th>
                        <th class="esquerda">Email</th> 
                        <th class="centro">Ações</th> 
                    </thead> <!-- Indicação de final do cabeçalho da tabela -->
                    <tbody class="consulta"> <!-- Indicação de início do corpo da tabela -->
                        <% for (Usuario usuar : usuarios) { %>
                            <tr id="botao"> <!-- Indicação do início dos itens que formarão as linhas da tabela -->
                                <td class="direita"><%out.write(String.valueOf(usuar.getIdUsuario()));%></td>
                                <td class="esquerda"><%out.write(usuar.getNuser());%></td> 
                                <td class="esquerda"><%out.write(usuar.getFuncionario() != null ? usuar.getFuncionario().getNome() : "");%></td>
                                <td class="esquerda"><%out.write(usuar.getEmail());%></td>
                                <td class="centro"><%out.write("<a href=usuario-cadastro-alterar.jsp?idusuario="+String.valueOf(usuar.getIdUsuario())
                                        +"><i class='fas fa-edit' title='Editar'></i></a>");%>&nbsp;&nbsp;&nbsp;<%out.write("<a href=\"javascript:if(confirm('Confirma Exclusão?')){document.location='usuario-excluir.jsp?"
                                        + "idusuario="+String.valueOf(usuar.getIdUsuario())+"';}\"><i class='fas fa-trash-alt' title='Excluir'></i></a>");%></td>
                            </tr> <!-- Indicação do fim dos itens que formarão as linhas da tabela -->
                        <% } %>
                    </tbody> <!-- Indicação de final do corpo da tabela -->
                </table> <!-- Indicação do final da tabela -->

                <div class="grupo-botoes">
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                </div>
<jsp:include page = "footer.jsp"/>
