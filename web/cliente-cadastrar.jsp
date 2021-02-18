<%-- 
    Document   : cliente-cadastrar
    Created on : 07/01/2021, 11:39:54
    Author     : Luzia
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Clientes" />
</jsp:include>
                <h1>Cadastro de Clientes</h1>
                
                <form action="cliente-recebe-cadastrar.jsp" method="POST" onsubmit="return enviarForm()">
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    
                    <div class="form-grupo">
                        <label>Nome do Cliente <span class="asterisco">*</span></label>
                        <input class="form-campo" type="text" name="nome"/>
                        <div class="alerta alerta-vermelho d-none" id="erroNome"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Tipo de Cadastro <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250" type="text" name="tipo" placeholder="PF / PJ"/>
                        <div class="alerta alerta-vermelho d-none" id="erroTipo"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Nº do CPF/CNPJ <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w500" type="text" name="cpf_cnpj" placeholder="Somente Números"/>
                        <div class="alerta alerta-vermelho d-none" id="erroCpf_cnpj"></div>
                    </div>

                    <div class="form-grupo">
                        <label>CEP</label>
                        <input class="form-campo form-campo-w250" type="text" name="cep" placeholder="Somente Números"/>
                    </div>

                    <div class="form-grupo">
                        <label>Estado</label>
                        <input class="form-campo form-campo-w250" type="text" name="uf" placeholder="Sigla"/>
                    </div>

                    <div class="form-grupo">
                        <label>Município</label>
                        <input class="form-campo form-campo-w500" type="text" name="cidade"/>
                    </div>

                    <div class="form-grupo">
                        <label>Bairro</label>
                        <input class="form-campo form-campo-w500" type="text" name="bairro"/>
                    </div>

                    <div class="form-grupo">
                        <label>Endereço</label>
                        <input class="form-campo" type="text" name="endereco"/>
                    </div>

                    <div class="form-grupo">
                        <label>Nº</label>
                        <input  class="form-campo form-campo-w250 t-right" type="text" name="numero"/>
                    </div>

                    <div class="form-grupo">
                        <label>Complemento</label>
                        <input class="form-campo form-campo-w500" type="text" name="complemento"/>
                    </div>

                    <div class="form-grupo">
                        <label>Telefone</label>
                        <input class="form-campo form-campo-w250" type="text" name="telefone1" placeholder="Somente Números"/>
                    </div>

                    <div class="form-grupo">
                        <label>Telefone 2</label>
                        <input class="form-campo form-campo-w250"  type="text" name="telefone2" placeholder="Somente Números"/>
                    </div>

                    <div class="form-grupo">
                        <label>Email</label>
                        <input class="form-campo form-campo-w500"  type="text" name="email"/>
                    </div>

                    <div class="form-grupo">
                        <label>Data Nasc/Cliente desde:</label>
                        <input class="form-campo form-campo-w250"  type="date" name="datanascimento"/>                        
                    </div>

                    <div class="grupo-botoes">
                        <button class="btn btn-verde" type="submit">Salvar</button>
                        <button class="btn btn-vermelho" type="reset" onclick="document.location='index.jsp';"/>Cancelar</button>
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
