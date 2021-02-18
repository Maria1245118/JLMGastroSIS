<%-- 
    Document   : funcionario-cadastro-alterar
    Created on : 12 de jan de 2021, 18:07:38
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Funcionario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Funcionários" />
</jsp:include>
<%
    String idfuncionario = request.getParameter("idfuncionario");
    Funcionario func = new Funcionario();
    if (idfuncionario != null) {
        func = func.consultar(Integer.parseInt(idfuncionario));
    }
%>
            <h1>Alteração de Dados no Cadastro de Funcionários</h1>
            
                <form action="funcionario-recebe-cadastro-alterar.jsp" method="POST" onsubmit="return enviarForm()">
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                        
                    <div class="form-grupo">
                        <label>Código</label></td>
                        <input class="form-campo form-campo-w250" type="text" name="idfuncionario" readonly="true" value="<%out.write(String.valueOf(func.getIdFuncionario()));%>"/>
                    </div>                    
                    
                    <div class="form-grupo">
                        <label>Nome do Funcionario <span class="asterisco">*</span></label>
                        <input class="form-campo" type="text" name="nome" value="<%out.write(func.getNome());%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroNome"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Nº do CPF <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250"  type="text" name="cpf" placeholder="Somente Números" value="<%out.write(func.getCpf());%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroCpf"></div>
                    </div>

                    <div class="form-grupo">
                        <label>CEP</label>
                        <input class="form-campo form-campo-w250"  type="text" name="cep" placeholder="Somente Números" value="<%out.write(func.getCep());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Estado</label>
                        <input class="form-campo form-campo-w250"  type="text" name="uf" placeholder="Sigla" value="<%out.write(func.getUf());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Município</label>
                        <input class="form-campo form-campo-w500"  type="text" name="cidade" value="<%out.write(func.getCidade());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Bairro</label>
                        <input class="form-campo form-campo-w500"  type="text" name="bairro" value="<%out.write(func.getBairro());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Endereço</label>
                        <input class="form-campo"  type="text" name="endereco" value="<%out.write(func.getEndereco());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Nº</label>
                        <input class="form-campo form-campo-w250 t-right"  type="text" name="numero" value="<%out.write(Web.inteiroParaString(func.getNumero()));%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Complemento</label>
                        <input class="form-campo form-campo-w500"  type="text" name="complemento" value="<%out.write(func.getComplemento());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Telefone</label>
                        <input class="form-campo form-campo-w250"  type="text" name="telefone1" placeholder="Somente Números" value="<%out.write(func.getTelefone1());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Telefone 2</label>
                        <input class="form-campo form-campo-w250"  type="text" name="telefone2" placeholder="Somente Números" value="<%out.write(func.getTelefone2());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>E-Mail</label>
                        <input class="form-campo form-campo-w500"  type="text" name="email" value="<%out.write(func.getEmail());%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Data de Nascimento </label>
                        <input class="form-campo form-campo-w250" type="date" name="dataNascimento" value="<%out.write(String.valueOf(func.getDataNascimento()));%>"/>
                    </div>                        

                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Alterar</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='funcionario-consultar.jsp';"/>Cancelar</button>
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
