<%-- 
    Document   : cliente-excluir
    Created on : 08/01/2021, 13:18:41
    Author     : LUZIA
--%>

<%@page import="classes.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Cliente Cadastrado" />
</jsp:include>
                <h1>Exclusão de Cliente Cadastrado</h1>
                <%
                    String idCliente = request.getParameter("idcliente");
                    Cliente cli = new Cliente();
                    if (idCliente != null) {
                        cli = cli.consultar(Integer.parseInt(idCliente));
                        if (cli == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Cadastro Não Localizado</div>");
                        } else {
                            try {
                                cli.excluir();
                                out.write("<div class='alerta alerta-verde'>Cadastro Excluído com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Cadastro" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>
