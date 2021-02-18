<%-- 
    Document   : fornecedor-cadastro-alterar
    Created on : 30 de dez de 2020, 15:20:56
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Fornecedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Fornecedores" />
</jsp:include>
<%
    String idfornecedor = request.getParameter("idfornecedor");
    Fornecedor fornec = new Fornecedor();
    if (idfornecedor != null) {
        fornec = fornec.consultar(Integer.parseInt(idfornecedor));
    }
%>
                <h1>Alteração de Dados no Cadastro de Fornecedores</h1>
                
                <form action="fornecedor-recebe-cadastro-alterar.jsp" method="POST" onsubmit="enviarForm()">
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    
                    <div class="form-grupo">
                        <label>Código</label>
                        <input class="form-campo form-campo-w250" type="text" name="idfornecedor" readonly="true" value="<%out.write(String.valueOf(fornec.getIdFornecedor()));%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Nome do Fornecedor <span class="asterisco">*</span></label>
                        <input class="form-campo" type="text" name="nome" value="<%out.write(fornec.getNome());%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroNome"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Tipo de Cadastro <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250" type="text" name="tipo" placeholder="PF / PJ" value="<%out.write(fornec.getTipo());%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroTipo"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Nº do CPF/CNPJ <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w500" type="text" name="cpf_cnpj" placeholder="Somente Números" value="<%out.write(fornec.getCpf_cnpj());%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroCpf_cnpj"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>CEP</label>
                        <input class="form-campo form-campo-w250" type="text" name="cep" placeholder="Somente Números" value="<%out.write(fornec.getCep());%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Estado</label>
                        <input class="form-campo form-campo-w250" type="text" name="uf" placeholder="Sigla" value="<%out.write(fornec.getUf());%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Município</label>
                        <input class="form-campo form-campo-w500" type="text" name="cidade" value="<%out.write(fornec.getCidade());%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Bairro</label>
                        <input class="form-campo form-campo-w500" type="text" name="bairro" value="<%out.write(fornec.getBairro());%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Endereço</label>
                        <input class="form-campo" type="text" name="endereco" value="<%out.write(fornec.getEndereco());%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Nº</label>
                        <input class="form-campo form-campo-w250 t-right" type="text" name="numero" value="<%out.write(Web.inteiroParaString(fornec.getNumero()));%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Complemento</label>
                        <input class="form-campo form-campo-w500" type="text" name="complemento" value="<%out.write(fornec.getComplemento());%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Telefone</label>
                        <input class="form-campo form-campo-w250" type="text" name="telefone1" placeholder="Somente Números" value="<%out.write(fornec.getTelefone1());%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Telefone 2</label>
                        <input class="form-campo form-campo-w250" type="text" name="telefone2" placeholder="Somente Números" value="<%out.write(fornec.getTelefone2());%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>E-Mail</label>
                        <input class="form-campo" type="text" name="email" value="<%out.write(fornec.getEmail());%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Fornecedor desde: </label>
                        <input class="form-campo form-campo-w250" type="date" name="datacadastro" value="<%out.write(String.valueOf(fornec.getDataCadastro()));%>"/>
                    </div>

                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Alterar</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='fornecedor-consultar.jsp';">Cancelar</button>
                    </div>
                </form>

        <script>
            function enviarForm() {
                var semErros = true;
                
                var nome = document.getElementsByName("nome");
                if (nome[0].value === "") {
                    document.getElementById("erroNome").innerHTML = "Informar o Nome do Fornecedor";
                    document.getElementById("erroNome").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroNome").style = "";
                }
                
                var tipo = document.getElementsByName("tipo");
                if (tipo[0].value === "") {
                    document.getElementById("erroTipo").innerHTML = "Informar o Tipo de Cadastro";
                    document.getElementById("erroTipo").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroTipo").style = "";
                }
                
                var cpf_cnpj = document.getElementsByName("cpf_cnpj");
                if (cpf_cnpj[0].value === "") {
                    document.getElementById("erroCpf_cnpj").innerHTML = "Informar o Nº do CPF/CNPJ";
                    document.getElementById("erroCpf_cnpj").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroCpf_cnpj").style = "";
                }
                
                return semErros;
            }
        </script>
<jsp:include page = "footer.jsp"/>
