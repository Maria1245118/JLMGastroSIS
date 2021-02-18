<%-- 
    Document   : produto-recebe-cadastro-alterar
    Created on : 6 de jan de 2021, 15:50:12
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Produto" />
</jsp:include>
                <h1>Alteração de Dados no Cadastro de Produto</h1>

                <%
                    Integer idproduto = Integer.parseInt((request.getParameter("idproduto")));
                    String descricaoProduto = request.getParameter("descricaoproduto");
                    String unMedida = request.getParameter("unmedida");
                    
                    Produto produto = new Produto();
                    produto.setIdProduto(idproduto);
                    produto.setDescricaoProduto(descricaoProduto.toUpperCase());
                    produto.setUnMedida(unMedida.toUpperCase());
                    
                    try {
                        produto.editar();
                        out.write("<div class='alerta alerta-verde'>Produto Alterado com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>