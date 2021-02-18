<%-- 
    Document   : produto-recebe-cadastrar
    Created on : 6 de jan de 2021, 10:49:15
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Produtos" />
</jsp:include>
                <h1>Cadastro de Produtos</h1>
                <%
                    String descricaoProduto = request.getParameter("descricaoproduto");
                    String unMedida = request.getParameter("unmedida");
                    
                    Produto produto = new Produto();
                    produto.setDescricaoProduto(descricaoProduto.toUpperCase());
                    produto.setUnMedida(unMedida.toUpperCase());
                    
                    try {
                        produto.salvar();
                        out.write("<div class='alerta alerta-verde'>Produto Cadastrado com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>
