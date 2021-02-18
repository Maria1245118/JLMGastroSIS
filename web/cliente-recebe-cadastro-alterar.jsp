<%-- 
    Document   : cliente-recebe-cadastro-alterar
    Created on : 08/01/2021, 12:19:08
    Author     :LUZIA
--%>

<%@page import="classes.Cliente"%>
<%@page import="java.time.LocalDate"%>
<%@page import="utils.Web"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Cliente" />
</jsp:include>
                <h1>Alteração de Dados no Cadastro de Cliente</h1>

                <%
                    Integer idcliente = Integer.parseInt(request.getParameter("idcliente"));
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
                    cliente.setIdCliente(idcliente);
                    cliente.setNome(nome.toUpperCase());
                    cliente.setTipo(tipo.toUpperCase());
                    cliente.setCpf_cnpj(cpf_cnpj);
                    cliente.setCep(cep);
                    cliente.setUf(uf.toUpperCase());
                    cliente.setCidade(cidade.toUpperCase());
                    cliente.setBairro(bairro);
                    cliente.setEndereco(endereco);
                    cliente.setNumero(numero);
                    cliente.setComplemento(complemento);
                    cliente.setTelefone1(telefone1);
                    cliente.setTelefone2(telefone2);
                    cliente.setEmail(email);
                    cliente.setDataNascimento(dataNascimento);
                    
                    try {
                        cliente.editar();
                        out.write("<div class='alerta alerta-verde'>Dados Alterados com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    } 
                %>
<jsp:include page = "footer.jsp"/>
