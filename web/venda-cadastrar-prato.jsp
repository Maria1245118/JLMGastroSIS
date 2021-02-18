<%-- 
    Document   : venda-cadastrar-prato
    Created on : 15 de jan. de 2021, 10:42:57
    Author     : entra21
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="classes.PratoCardapio"%>
<%@page import="classes.Prato"%>
<%@page import="classes.CardapioVenda"%>
<%@page import="utils.Web"%>
<%@page import="classes.Venda"%>
<%@page import="classes.Cardapio"%>
<%@page import="java.util.List"%>
<%@page import="classes.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Vendas" />
</jsp:include>

                <h1>Cadastro de Vendas</h1>
                <h3>Cadastro de Pratos da Venda</h3>
                <%
                    Integer idCliente = Integer.parseInt(request.getParameter("idcliente"));
                    Integer qtdeCardapios = Integer.parseInt(request.getParameter("qtdeCardapios"));
                    LocalDate dataOrcamento = Web.valorDate(request.getParameter("dataorcamento")); // lê a data como String e converte no formato Date para o banco.
                    LocalDate dataPedido = Web.valorDate(request.getParameter("datapedido"));
                    LocalDate dataProducao = Web.valorDate(request.getParameter("dataproducao"));
                    Boolean producao = Web.valorCheckbox(request.getParameter("producao"));
                    
                    Cliente cliente = Cliente.consultar(idCliente);
                %>

                
                <form action="venda-recebe-cadastrar.jsp" method="POST" onsubmit="return enviarForm()">
                    <input type="hidden" name="qtdeCardapios" id="qtdeCardapios" value="<%=qtdeCardapios%>"/>
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>                
                
                    <div class="form-grupo">
                        <label>Cliente</label>
                        <input class="form-campo" type="text" name="nomecliente" readonly="true" value="<%=cliente.getNome()%>"/>
                        <input type="hidden" name="idcliente" readonly="true" value="<%=cliente.getIdCliente()%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Data de Orçamento</label>
                        <input class="form-campo form-campo-w250 txt-right" type="date" name="dataorcamento" readonly="true" value="<%=dataOrcamento%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Data de Pedido</label>
                        <input class="form-campo form-campo-w250 txt-right" type="date" name="datapedido" readonly="true" value="<%=dataPedido%>"/>
                    </div>
                        
                    <div class="form-grupo">
                        <label>Data de Produção</label>
                        <input class="form-campo form-campo-w250 txt-right" type="date" name="dataproducao" readonly="true" value="<%=dataProducao%>"/>
                    </div>
                        
                    <div class="form-checkbox">
                        <input type="checkbox" name="producao" id="producao" readonly="true" <%out.write(producao ? " checked='checked'" : "");%>/> 
                        <label class="form-check-label" for="producao">
                            Produção                                                               
                        </label>                            
                    </div>
                    

                    <div class="subform">
                        <div class="subform-header">
                            Cardápios/Pratos
                        </div>
                        <div class="subform-body">
                        <%
                            int idCardapio = 0;
                            for (int c = 1; c <= qtdeCardapios; c++) {
                                idCardapio = Integer.parseInt(request.getParameter("idcardapio" + c));
                                Cardapio cardapio = Cardapio.consultar(idCardapio);
                        %>
                            <table id="tabelaCardapios">
                                <thead>
                                    <th class="esquerda">Cardápio(s)</th>
                                    <th class="direita">Valor do Cardápio</th>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="esquerda"><%out.write(cardapio.getDescCardapio());%>
                                            <input type="hidden" name="idcardapio<%=c%>" value="<%=cardapio.getIdCardapio()%>"/></td>
                                        <td class="direita"><%out.write(Web.moedaParaString(cardapio.getVTotal()));%></td>
                                    </tr>
                                </tbody>
                            </table>
                            <input type="hidden" name="qtdePratos<%=c%>" id="qtdePratos<%=c%>" value="<%=cardapio.getPratos().size()%>"/>
                                <%
                                    int p = 1;
                                    for (PratoCardapio pratoCardapio : cardapio.getPratos()) {
                                        Prato prato = Prato.consultar(pratoCardapio.getIdPrato());
                                %>
                                    <table id="tabelaPratos">
                                        <thead>
                                            <th class="esquerda">Prato</th>
                                            <th class="direita">Quantidade *</th>                            
                                            <th class="direita">Valor do Prato</th>
                                            <th class="direita">Valor Total</th>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td> <!--Pratos-->
                                                    <input class="form-campo" type="text" name="nomeprato<%=c%>_<%=p%>" readonly="true" value="<%=prato.getNome()%>"/>
                                                    <input type="hidden" name="idprato<%=c%>_<%=p%>" readonly="true" value="<%=prato.getIdPrato()%>"/>
                                                </td>
                                                <td> <!--Quantidade-->
                                                    <input class="form-campo txt-right" type="text" id="qtdevenda<%=c%>_<%=p%>" name="qtdevenda<%=c%>_<%=p%>" value="1" onchange="calculaSubtotal(<%=c%>,<%=p%>)"/>
                                                    <div class="alerta alerta-vermelho d-none" id="erroQtde1"></div>
                                                </td>
                                                <td> <!--Valor do Prato-->
                                                    <input class="form-campo txt-right" type="text" id="valorvenda<%=c%>_<%=p%>" name="valorvenda<%=c%>_<%=p%>" readonly="true" value="<%=Web.moedaParaString(prato.getValorPrato())%>"/>
                                                </td>
                                                <td> <!--Valor Total-->
                                                    <input class="form-campo txt-right" type="text" id="valortotal<%=c%>_<%=p%>" name="valortotal<%=c%>_<%=p%>" readonly="true" value="<%=Web.moedaParaString(prato.getValorPrato())%>"/>
                                                </td>
                                            <tr/>
                                        </tbody>
                                    </table>
                                <% 
                                    p++;
                                    }
                                %>
                        <% } %>
                        </div>
                    </div>
                        
                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Salvar</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                    </div>
                </form>
        <script>
            function enviarForm() {
                var semErros = true;
                
                var qtdeCardapios = document.getElementById('qtdeCardapios').value;
                for (cardapio = 1; cardapio <= qtdeCardapios; cardapio++) {
                    var qtdePratos = document.getElementById('qtdePratos' + cardapio).value;
                    for (prato = 1; prato <= qtdePratos; prato++) {
                        var qtdevenda = document.getElementById('qtdevenda' + cardapio + '_' + prato);
                        if (qtdevenda.value === '' || qtdevenda == 0) {
                            document.getElementById('erroQtde' + cardapio + '_' + prato).innerHTML = "Informar a Quantidade";
                            document.getElementById('erroQtde' + cardapio + '_' + prato).style = "display: block";
                            semErros = false;
                        }
                        else {
                            document.getElementById('erroQtde' + cardapio + '_' + prato).style = "";
                        }
                    }
                }
                return semErros;
            }
            
            function calculaSubtotal(c, p) {
                var qtdeVenda = document.getElementById('qtdevenda' + c + '_' + p).value;
                var valorVenda = document.getElementById('valorvenda' + c + '_' + p).value;
                document.getElementById('valortotal' + c + '_' + p).value = 
                    'R$ ' + (parseInt(qtdeVenda) * 
                    parseFloat(valorVenda.replace(',', '.').replace('R$', '').trim())).toFixed(2).replace('.', ',');
            }
        </script>
<jsp:include page = "footer.jsp"/>