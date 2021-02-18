<%-- 
    Document   : usuario-cadastrar
    Created on : 12 de jan de 2021, 21:20:35
    Author     : Janine
--%>

<%@page import="java.util.List"%>
<%@page import="classes.Funcionario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Usuários" />
</jsp:include>
<%
    Funcionario funcionario = new Funcionario();
    List<Funcionario> funcionarios = funcionario.consultar();
%>
            <h1>Cadastro de Usuários</h1>
                
                <form action="usuario-recebe-cadastrar.jsp" method ="POST" onsubmit="return enviarForm()">
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>

                    <div class="form-grupo">
                        <label>Usuário <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250" type="text" name="nuser"/>
                        <div class="alerta alerta-vermelho d-none" id="erroNuser"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Selecione o Funcionário</label>                            
                        <select class="form-campo" name="idfuncionario">
                            <option value=""></option>
                            <%for (Funcionario func : funcionarios) {%>
                                <option value="<%out.write(String.valueOf(func.getIdFuncionario()));%>">
                                    <%out.write(func.getNome());%>
                                </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-grupo">
                        <label>Senha <span class="asterisco">*</span></label>
                        <input class="form-campo  form-campo-w250" type="text" name="senha"/>
                        <div class="alerta alerta-vermelho d-none" id="erroSenha"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Email <span class="asterisco">*</span></label>
                        <input class="form-campo" type="text" name="email"/>
                        <div class="alerta alerta-vermelho d-none" id="erroEmail"></div>
                    </div>                        

                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Salvar</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';"/>Cancelar</button>
                    </div>
                </form>

        <script>
            function enviarForm(){
                var semErros = true;

                var nuser = document.getElementsByName("nuser");
                if(nuser[0].value === ""){
                    document.getElementById("erroNuser").innerHTML = "Informar o Usuário";
                    document.getElementById("erroNuser").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroNuser").style = "";
                }

                var senha = document.getElementsByName("senha");
                if(senha[0].value === ""){
                    document.getElementById("erroSenha").innerHTML = "Informar a Senha";
                    document.getElementById("erroSenha").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroSenha").style = "";
                }

                var email = document.getElementsByName("email");
                if(email[0].value === ""){
                    document.getElementById("erroEmail").innerHTML = "Informar o E-Mail"
                    document.getElementById("erroEmail").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroEmail").style = "";
                }                
                
                return semErros;
            }
        </script>
<jsp:include page = "footer.jsp"/>
