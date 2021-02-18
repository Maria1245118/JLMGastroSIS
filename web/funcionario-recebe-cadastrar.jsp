<%-- 
    Document   : funcionario-recebe-cadastrar
    Created on : 12 de jan de 2021, 18:07:11
    Author     : Janine
--%>

<%@page import="classes.Funcionario"%>
<%@page import="java.time.LocalDate"%>
<%@page import="utils.Web"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Funcionários" />
</jsp:include>
            <h1>Cadastro de Funcionários</h1>
                <%
                    String nome = request.getParameter("nome");
                    String cpf = request.getParameter("cpf");
                    String cep = request.getParameter("cep");
                    String uf = request.getParameter("uf");
                    String cidade = request.getParameter("cidade");
                    String bairro = request.getParameter("bairro");
                    String endereco = request.getParameter("endereco");
                    Integer numero = Web.valorInteger(request.getParameter("numero"));
                    String complemento = request.getParameter("complemento");
                    String telefone1 = request.getParameter("telefone1");
                    String telefone2 = request.getParameter("telefone2");
                    String email = request.getParameter("email");
                    LocalDate dataNascimento = Web.valorDate(request.getParameter("dataNascimento"));
                    
                    Funcionario funcionario = new Funcionario();
                    funcionario.setNome(nome.toUpperCase());
                    funcionario.setCpf(cpf);
                    funcionario.setCep(cep);
                    funcionario.setUf(uf.toUpperCase());
                    funcionario.setCidade(cidade.toUpperCase());
                    funcionario.setBairro(bairro.toUpperCase());
                    funcionario.setEndereco(endereco.toUpperCase());
                    funcionario.setNumero(numero);
                    funcionario.setComplemento(complemento.toUpperCase());
                    funcionario.setTelefone1(telefone1);
                    funcionario.setTelefone2(telefone2);
                    funcionario.setEmail(email.toLowerCase());
                    funcionario.setDataNascimento(dataNascimento);
                    
                    try {
                        funcionario.salvar();
                        out.write("<div class='alerta alerta-verde'>Dados Cadastrados com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>