<%-- 
    Document   : fornecedor-recebe-cadastro-alterar
    Created on : 30 de dez de 2020, 15:41:44
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
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Fornecedor" />
</jsp:include>

                <h1>Alteração de Dados no Cadastro de Fornecedor</h1>

                <%
                    Integer idfornecedor = Integer.parseInt(request.getParameter("idfornecedor"));
                    String nome = request.getParameter("nome");
                    String tipo = request.getParameter("tipo");
                    String cpf_cnpj = request.getParameter("cpf_cnpj");
                    String cep = request.getParameter("cep");
                    String uf = request.getParameter("uf");
                    String cidade = (request.getParameter("cidade"));
                    String bairro = request.getParameter("bairro");
                    String endereco = request.getParameter("endereco");
                    Integer numero = Web.valorInteger(request.getParameter("numero"));
                    String complemento = request.getParameter("complemento");
                    String telefone1 = request.getParameter("telefone1");
                    String telefone2 = request.getParameter("telefone2");
                    String email = request.getParameter("email");
                    LocalDate dataCadastro = Web.valorDate(request.getParameter("datacadastro"));
                    
                    Fornecedor fornecedor = new Fornecedor();
                    fornecedor.setIdFornecedor(idfornecedor);
                    fornecedor.setNome(nome.toUpperCase());
                    fornecedor.setTipo(tipo.toUpperCase());
                    fornecedor.setCpf_cnpj(cpf_cnpj);
                    fornecedor.setCep(cep);
                    fornecedor.setUf(uf.toUpperCase());
                    fornecedor.setCidade(cidade.toUpperCase());
                    fornecedor.setBairro(bairro);
                    fornecedor.setEndereco(endereco);
                    fornecedor.setNumero(numero);
                    fornecedor.setComplemento(complemento);
                    fornecedor.setTelefone1(telefone1);
                    fornecedor.setTelefone2(telefone2);
                    fornecedor.setEmail(email);
                    fornecedor.setDataCadastro(dataCadastro);
                    
                    try {
                        fornecedor.editar();
                        out.write("<div class='alerta alerta-verde'>Dados Alterados com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    } 
                %>
<jsp:include page = "footer.jsp"/>