<%-- 
    Document   : cliente-recebe-cadastrar
    Created on : 07/01/2021, 11:58:25
    Author     : Luzia
--%>

<%@page import="classes.Cliente"%>
<%@page import="java.time.LocalDate"%>
<%@page import="utils.Web"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Clientes" />
</jsp:include>
                <h1>Cadastro de Clientes</h1>

                <%
                    String nome = request.getParameter("nome");
                    String tipo = request.getParameter("tipo");
                    String cpf_cnpj = request.getParameter("cpf_cnpj");
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
                    LocalDate dataNascimento = Web.valorDate(request.getParameter("datanascimento"));
                    
                    Cliente cliente = new Cliente();
                    cliente.setNome(nome.toUpperCase());
                    cliente.setTipo(tipo.toUpperCase());
                    cliente.setCpf_cnpj(cpf_cnpj);
                    cliente.setCep(cep);
                    cliente.setUf(uf.toUpperCase());
                    cliente.setCidade(cidade.toUpperCase());
                    cliente.setBairro(bairro.toUpperCase());
                    cliente.setEndereco(endereco.toUpperCase());
                    cliente.setNumero(numero);
                    cliente.setComplemento(complemento.toUpperCase());
                    cliente.setTelefone1(telefone1);
                    cliente.setTelefone2(telefone2);
                    cliente.setEmail(email.toLowerCase());
                    cliente.setDataNascimento(dataNascimento);
                    
                    try {
                        cliente.salvar();
                        out.write("<div class='alerta alerta-verde'>Dados Cadastrados com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage()+ "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>
