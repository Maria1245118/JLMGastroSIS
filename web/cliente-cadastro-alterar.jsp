<%-- 
    Document   : cliente-cadastro-alterar
    Created on : 08/01/2021, 12:37:48
    Author     : LUZIA
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Clientes" />
</jsp:include>
<%
    String idcliente = request.getParameter("idcliente");
    Cliente cli = new Cliente();
    if (idcliente != null) {
        cli = cli.consultar(Integer.parseInt(idcliente));
    }
%>
                <h1>Alteração de Dados no Cadastro de Clientes</h1>
                
                <form action="cliente-recebe-cadastro-alterar.jsp" method="POST" onsubmit="return enviarForm()">
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    
                    <div class="form-grupo">
                        <label>Código</label>
                        <input class="form-campo form-campo-w250" type="text" name="idcliente" readonly="true" value="<%out.write(String.valueOf(cli.getIdCliente()));%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Nome do Cliente <span class="asterisco">*</span></label>
                        <input class="form-campo" type="text" name="nome"  value="<%out.write(cli.getNome());%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroNome"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Tipo de Cadastro <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250" type="text" name="tipo" placeholder="PF / PJ" value="<%out.write(cli.getTipo());%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroTipo"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Nº do CPF/CNPJ <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w500" type="text" name="cpf_cnpj" placeholder="Somente Números" value="<%out.write(cli.getCpf_cnpj());%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroCpf_cnpj"></div>
                    </div>

                    <div class="form-grupo">
                        <label>CEP</label>
                        <input class="form-campo form-campo-w250" type="text" name="cep" placeholder="Somente Números" value="<%out.write(cli.getCep());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Estado</label>
                        <input class="form-campo form-campo-w250" type="text" name="uf" placeholder="Sigla" value="<%out.write(cli.getUf());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Município</label>
                        <input class="form-campo form-campo-w500" type="text" name="cidade" value="<%out.write(cli.getCidade());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Bairro</label>
                        <input class="form-campo form-campo-w500" type="text" name="bairro" value="<%out.write(cli.getBairro());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Endereço</label>
                        <input class="form-campo" type="text" name="endereco" value="<%out.write(cli.getEndereco());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Nº</label>
                        <input  class="form-campo form-campo-w250 t-right" type="text" name="numero" value="<%out.write(Web.inteiroParaString(cli.getNumero()));%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Complemento</label>
                        <input class="form-campo form-campo-w500" type="text" name="complemento" value="<%out.write(cli.getComplemento());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Telefone</label>
                        <input class="form-campo form-campo-w250" type="text" name="telefone1" placeholder="Somente Números" value="<%out.write(cli.getTelefone1());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Telefone 2</label>
                        <input class="form-campo form-campo-w250"  type="text" name="telefone2" placeholder="Somente Números" value="<%out.write(cli.getTelefone2());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Email</label>
                        <input class="form-campo form-campo-w500"  type="text" name="email" value="<%out.write(cli.getEmail());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Data Nasc/Cliente desde:</label>
                        <input class="form-campo form-campo-w250"  type="date" name="datanascimento" value="<%out.write(String.valueOf(cli.getDataNascimento()));%>"/>                        
                    </div>

                    <div class="grupo-botoes">
                        <button class="btn btn-verde" type="submit">Alterar</button>
                        <button class="btn btn-vermelho" type="reset" onclick="document.location='cliente-consultar.jsp';"/>Cancelar</button>
                    </div>
                </form>

        <script>
            function enviarForm() {
                var semErros = true;

                var nome = document.getElementsByName("nome");
                if (nome[0].value === "") {
                    document.getElementById("erroNome").innerHTML = "Informar o Nome do Cliente";
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
