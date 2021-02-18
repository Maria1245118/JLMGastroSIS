<%-- 
    Document   : cardapiodia-cadastro-alterar
    Created on : 1 de fev de 2021, 17:35:09
    Author     : Janine
--%>

<%@page import="java.util.List"%>
<%@page import="classes.Cardapio"%>
<%@page import="classes.CardapioDia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Cardápio do Dia" />
</jsp:include>
<%
    String idCardapioDia = request.getParameter("idcardapiodia");
    CardapioDia menuDia = new CardapioDia();
    if (idCardapioDia != null) {
        menuDia = menuDia.consultar(Integer.parseInt(idCardapioDia));
    }
    Cardapio menu = new Cardapio();
    List<Cardapio> menus = menu.consultar();
%>

                <h1>Alteração de Dados no Cadastro de Cardápio do Dia</h1>
                
                <form action="cardapiodia-recebe-cadastro-alterar.jsp" method="POST" onsubmit="return enviarForm()">
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    
                    <div class="form-grupo">
                        <label>Código</label>
                        <input class="form-campo form-campo-w250" type="text" name="idcardapiodia" readonly="true" value="<%out.write(String.valueOf(menuDia.getIdCardapioDia()));%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Selecione o Cardápio <span class="asterisco">*</span></label>
                        <select name="idcardapio" class="form-campo">
                            <option value=""></option>
                            <%for (Cardapio card : menus) {%>
                                <option value="<%out.write(String.valueOf(card.getIdCardapio()));%>"
                                <%out.write(menuDia.getCardapio().getIdCardapio()==card.getIdCardapio() ? " selected='selected'" : "");%>>
                                    <%out.write(card.getDescCardapio());%>
                                </option>
                            <% } %>
                        </select>
                        <div class="alerta alerta-vermelho d-none" id="erroIdCard"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Data <span class="asterisco">*</span></label>
                        <input type="date" name="datacardapio" class="form-campo form-campo-w250"  value="<%out.write(String.valueOf(menuDia.getDataCardapio()));%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroData"></div>
                    </div>
                    
                    <div class="grupo-botoes">
                        <button class="btn btn-verde" type="submit">Alterar</button>
                        <button class="btn btn-vermelho" type="reset" onclick="document.location='cardapiodia-consultar.jsp';"/>Cancelar</button>
                    </div>
                </form>
        <script>
            function enviarForm() {
                var semErros = true;

                var idcard = document.getElementsByName("idcardapio");
                if (idcard[0].value === "") {
                    document.getElementById("erroIdCard").innerHTML = "Informar o Código do Cardápio";
                    document.getElementById("erroIdCard").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroIdCard").style = "";
                }

                var data = document.getElementsByName("datacardapio");
                if (data[0].value === "") {
                    document.getElementById("erroData").innerHTML = "Informar a Data do Cardápio";
                    document.getElementById("erroData").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroData").style = "";
                }
                
                return semErros;
            }
        </script>
<jsp:include page = "footer.jsp"/>
