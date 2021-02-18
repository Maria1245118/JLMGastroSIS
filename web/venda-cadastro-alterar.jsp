<%-- 
    Document   : venda-cadastro-alterar
    Created on : 15 de jan. de 2021, 11:19:40
    Author     : entra21
--%>

<%@page import="classes.ItemVenda"%>
<%@page import="classes.CardapioVenda"%>
<%@page import="java.util.List"%>
<%@page import="classes.Venda"%>
<%@page import="classes.Prato"%>
<%@page import="classes.PratoCardapio"%>
<%@page import="classes.Cardapio"%>
<%@page import="classes.Cliente"%>
<%@page import="utils.Web"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Vendas" />
</jsp:include>
<%
    String nUser=(String)session.getAttribute("usuario");

    //redireciona usuário para página de login
    if(nUser == null){
            response.sendRedirect("login.jsp");
    }
%>

                <h1>Cadastro de Vendas</h1>
                <h3>Cadastro de Pratos da Venda</h3>
                <%
                    request.setCharacterEncoding("UTF-8");
                    
                    String idVenda = request.getParameter("idvenda");
                    Venda vend = new Venda();
                    if (idVenda != null) {
                        vend = vend.consultar(Integer.parseInt(idVenda));
                    }
                    
                    Cardapio cardapio = new Cardapio();
                    List<Cardapio> cardapios = cardapio.consultar();
                %>
                
                <form action="venda-recebe-cadastro-alterar.jsp" method="POST" onsubmit="return enviarForm()">
                    <input type="hidden" name="qtdeCardapios" id="qtdeCardapios" value="<%=vend.getItensCardapioVenda().size()%>"/>
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    
                    <div class="form-grupo">
                        <label>Código</label>
                        <input class="form-campo form-campo-w250" type="text" name="idvenda" readonly="true" value="<%=vend.getIdVenda()%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Selecione o Cliente <span class="asterisco">*</span></label>                        
                        <input class="form-campo" type="text" name="nomecliente" readonly="true" value="<%=vend.getCliente().getNome()%>"/>
                        <input type="hidden" name="idcliente" readonly="true" value="<%=vend.getCliente().getIdCliente()%>"/>            
                    </div>
                    
                    <div class="form-grupo">
                        <label>Data do Orçamento</label>
                        <input class="form-campo form-campo-w250" type="date" name="dataorcamento" readonly="true" value="<%=vend.getDataOrcamento()%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Data do Pedido</label>
                        <input class="form-campo form-campo-w250" type="date" name="datapedido" readonly="true" value="<%=vend.getDataPedido()%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Data de Produção</label>
                        <input class="form-campo form-campo-w250" type="date" name="dataproducao" readonly="true" value="<%=vend.getDataProducao()%>"/>
                    </div>
                        
                    <div class="form-checkbox">
                        <input type="checkbox" name="producao" id="producao" readonly="true" value="<%out.write(vend.isProducao() ? " checked='checked'" : "");%>"/> 
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
                                int c = 1;
                                for (CardapioVenda cardapioVenda : vend.getItensCardapioVenda()) {
                                    cardapio = Cardapio.consultar(cardapioVenda.getIdCardapio());
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
                            <table id="tabelaPratos">
                                <thead>
                                    <th class="esquerda">Prato</th>
                                    <th class="direita">Quantidade *</th>                            
                                    <th class="direita">Valor do Prato</th>
                                    <th class="direita">Valor Total</th>
                                </thead>
                                <tbody>
                                <%
                                    int p = 1;
                                    for (ItemVenda item : cardapioVenda.getItens()) {
                                %>
                                    <tr>
                                        <td> <!--Pratos-->
                                            <input class="form-campo" type="text" name="nomeprato<%=c%>_<%=p%>" readonly="true" value="<%=item.getPrato().getNome()%>"/>
                                            <input type="hidden" name="idprato<%=c%>_<%=p%>" readonly="true" value="<%=item.getPrato().getIdPrato()%>"/>
                                        </td>
                                        <td> <!--Quantidade-->
                                            <input class="form-campo form-campo-w250 txt-right" type="text" id="qtdevenda<%=c%>_<%=p%>" name="qtdevenda<%=c%>_<%=p%>" value="<%=item.getQtdeVenda()%>" onchange="calculaSubtotal(<%=c%>,<%=p%>)"/>
                                            <div class="alerta alerta-vermelho d-none" id="erroQtde1"></div>
                                        </td>
                                        <td> <!--Valor do Prato-->
                                            <input class="form-campo form-campo-w250 txt-right" type="text" id="valorvenda<%=c%>_<%=p%>" name="valorvenda<%=c%>_<%=p%>" readonly="true" value="<%=Web.moedaParaString(item.getPrato().getValorPrato())%>"/>
                                        </td>
                                        <td> <!--Valor Total-->
                                            <input class="form-campo form-campo-w250 txt-right" type="text" id="valortotal<%=c%>_<%=p%>" name="valortotal<%=c%>_<%=p%>" readonly="true" value="<%=Web.moedaParaString(item.getValorVenda())%>"/>
                                        </td>
                                    <tr/>
                                
                                <% 
                                    p++;
                                    }
                                %>
                                </tbody>
                            </table>
                        <% 
                            c++;
                            }
                        %>
                    </div>
                </div>                        

                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Alterar</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='venda-consultar.jsp';"/>Cancelar</button>
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