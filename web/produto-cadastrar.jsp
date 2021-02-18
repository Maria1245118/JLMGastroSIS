<%-- 
    Document   : produto-cadastrar
    Created on : 6 de jan de 2021, 10:48:58
    Author     : Janine
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Produtos" />
</jsp:include>
                <h1>Cadastro de Produtos</h1>
                
                <form action="produto-recebe-cadastrar.jsp" method="POST" onsubmit="enviarForm()">
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>

                    <div class="form-grupo">
                        <label>Descrição do Produto <span class="asterisco">*</span></label>
                        <input class="form-campo" type="text" name="descricaoproduto"/>
                        <div class="alerta alerta-vermelho d-none" id="erroDesc"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Un Medida *</label>
                        <input class="form-campo form-campo-w250" type="text" name="unmedida" placeholder="Sigla"/>
                        <div class="alerta alerta-vermelho d-none" id="erroUn"></div>
                    </div>
                        
                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Salvar</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                    </div>
                </form>

        <script>
            function enviarForm() {
                var semErros = true;

                var desc = document.getElementsByName("descricaoproduto");
                if (desc[0].value === "") {
                    document.getElementById("erroDesc").innerHTML = "Informar a Descrição do Produto";
                    document.getElementById("erroDesc").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroDesc").style = "";
                }

                var un = document.getElementsByName("unmedida");
                if (un[0].value == "") {
                    document.getElementById("erroUn").innerHTML = "Informar a Unidade de Medida";
                    document.getElementById("erroUn").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroUn").style = "";
                }
                
                return semErros;
            }
        </script>
<jsp:include page = "footer.jsp"/>
