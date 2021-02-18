<%-- 
    Document   : funcionario-cadastrar
    Created on : 12 de jan de 2021, 18:06:44
    Author     : Janine
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Funcionários" />
</jsp:include>
            <h1>Cadastro de Funcionários</h1>

                <form action="funcionario-recebe-cadastrar.jsp" method="POST" onsubmit="return enviarForm()">
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                        
                    <div class="form-grupo">
                        <label>Nome do Funcionario <span class="asterisco">*</span></label>
                        <input class="form-campo" type="text" name="nome"/>
                        <div class="alerta alerta-vermelho d-none" id="erroNome"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Nº do CPF <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250"  type="text" name="cpf" placeholder="Somente Números"/>
                        <div class="alerta alerta-vermelho d-none" id="erroCpf"></div>
                    </div>

                    <div class="form-grupo">
                        <label>CEP</label>
                        <input class="form-campo form-campo-w250"  type="text" name="cep" placeholder="Somente Números"/>
                    </div>

                    <div class="form-grupo">
                        <label>Estado</label>
                        <input class="form-campo form-campo-w250"  type="text" name="uf" placeholder="Sigla"/>
                    </div>

                    <div class="form-grupo">
                        <label>Município</label>
                        <input class="form-campo form-campo-w500"  type="text" name="cidade"/>
                    </div>

                    <div class="form-grupo">
                        <label>Bairro</label>
                        <input class="form-campo form-campo-w500"  type="text" name="bairro"/>
                    </div>

                    <div class="form-grupo">
                        <label>Endereço</label>
                        <input class="form-campo"  type="text" name="endereco"/>
                    </div>

                    <div class="form-grupo">
                        <label>Nº</label>
                        <input class="form-campo form-campo-w250 t-right"  type="text" name="numero"/>
                    </div>

                    <div class="form-grupo">
                        <label>Complemento</label>
                        <input class="form-campo form-campo-w500"  type="text" name="complemento"/>
                    </div>

                    <div class="form-grupo">
                        <label>Telefone</label>
                        <input class="form-campo form-campo-w250"  type="text" name="telefone1" placeholder="Somente Números"/>
                    </div>

                    <div class="form-grupo">
                        <label>Telefone 2</label>
                        <input class="form-campo form-campo-w250"  type="text" name="telefone2" placeholder="Somente Números"/>
                    </div>

                    <div class="form-grupo">
                        <label>E-Mail</label>
                        <input class="form-campo form-campo-w500"  type="text" name="email"/>
                    </div>

                    <div class="form-grupo">
                        <label>Data de Nascimento </label>
                        <input class="form-campo form-campo-w250" type="date" name="dataNascimento"/>
                    </div>                        

                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Salvar</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';"/>Cancelar</button>
                    </div>
                </form>

            <script>
                function enviarForm() {
                    var semErros = true;

                    var nome = document.getElementsByName("nome");
                    if (nome[0].value === "") {
                        document.getElementById("erroNome").innerHTML = "Informar o Nome do Funcionario";
                        document.getElementById("erroNome").style = "display: block";
                        semErros = false;
                    }
                    else {
                        document.getElementById("erroNome").style = "";
                    }

                    var cpf = document.getElementsByName("cpf");
                    if (cpf[0].value === "") {
                        document.getElementById("erroCpf").innerHTML = "Informar o Nº do CPF";
                        document.getElementById("erroCpf").style = "display: block";
                        semErros = false;
                    }
                    else {
                        document.getElementById("erroCpf").style = "";
                    }
                    
                    return semErros;
                }
            </script>
<jsp:include page = "footer.jsp"/>