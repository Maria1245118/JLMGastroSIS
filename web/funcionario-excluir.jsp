<%-- 
    Document   : funcionario-excluir
    Created on : 12 de jan de 2021, 18:08:41
    Author     : Janine
--%>

<%@page import="classes.Funcionario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Exclusão de Funcionário Cadastrado" />
</jsp:include>
                <h1>Exclusão de Funcionário Cadastrado</h1>
                <%
                    String idFuncionario = request.getParameter("idfuncionario");
                    Funcionario func = new Funcionario();
                    if (idFuncionario != null) {
                        func = func.consultar(Integer.parseInt(idFuncionario));
                        if (func == null) {
                            out.write("<div class='alerta alerta-vermlelho'>Cadastro Não Localizado</div>");
                        } else {
                            try {
                                func.excluir();
                                out.write("<div class='alerta alerta-verde'>Cadastro Excluído com Sucesso</div>");
                            } catch (Exception ex) {
                                out.write("<div class='alerta alerta-vermlelho'>Erro ao Excluir Cadastro" + ex.getMessage() + "</div>");
                            }
                        }
                    }
                %>
<jsp:include page = "footer.jsp"/>