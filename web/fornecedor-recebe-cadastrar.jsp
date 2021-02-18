<%-- 
    Document   : fornecedor-recebe-cadastrar
    Created on : 30 de dez de 2020, 15:40:32
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Fornecedor"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Fornecedores" />
</jsp:include>
                <h1>Cadastro de Fornecedores</h1>

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
                    LocalDate dataCadastro = Web.valorDate(request.getParameter("datacadastro"));
                    
                    Fornecedor fornecedor = new Fornecedor();
                    fornecedor.setNome(nome.toUpperCase());
                    fornecedor.setTipo(tipo.toUpperCase());
                    fornecedor.setCpf_cnpj(cpf_cnpj);
                    fornecedor.setCep(cep);
                    fornecedor.setUf(uf.toUpperCase());
                    fornecedor.setCidade(cidade.toUpperCase());
                    fornecedor.setBairro(bairro.toUpperCase());
                    fornecedor.setEndereco(endereco.toUpperCase());
                    fornecedor.setNumero(numero);
                    fornecedor.setComplemento(complemento.toUpperCase());
                    fornecedor.setTelefone1(telefone1);
                    fornecedor.setTelefone2(telefone2);
                    fornecedor.setEmail(email.toLowerCase());
                    fornecedor.setDataCadastro(dataCadastro);
                    
                    try {
                        fornecedor.salvar();
                        out.write("<div class='alerta alerta-verde'>Dados Cadastrados com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>