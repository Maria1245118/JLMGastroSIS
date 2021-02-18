<%-- 
    Document   : usuario-recebe-cadastro-alterar
    Created on : 12 de jan de 2021, 21:21:52
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Funcionario"%>
<%@page import="classes.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Usuário" />
</jsp:include>
            <h1>Alteração de Dados no Cadastro de Usuário</h1>
            <%
                    Integer idusuario = Integer.parseInt(request.getParameter("idusuario"));
                    String nuser = request.getParameter("nuser");
                    Integer idFuncionario = Web.valorInteger(request.getParameter("idfuncionario"));
                    String senha = request.getParameter("senha");
                    String email = request.getParameter("email");
                   
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(idusuario);
                    usuario.setNuser(nuser.toUpperCase());

                    if (idFuncionario != null && !"".equals(idFuncionario)) {
                        Funcionario funcionario = new Funcionario();
                        funcionario = funcionario.consultar(idFuncionario);
                        usuario.setFuncionario(funcionario);
                    }
                    
                    usuario.setSenha(senha);
                    usuario.setEmail(email.toLowerCase());
                    
                    try {
                        usuario.editar();
                        out.write("<div class='alerta alerta-verde'>Dados Alterados com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    } 
                %>
<jsp:include page = "footer.jsp"/>