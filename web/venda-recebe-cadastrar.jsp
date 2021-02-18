<%-- 
    Document   : venda-recebe-cadastrar
    Created on : 17/01/2021, 10:46:06
    Author     : Familia
--%>

<%@page import="classes.Prato"%>
<%@page import="classes.CardapioVenda"%>
<%@page import="classes.Cardapio"%>
<%@page import="classes.ItemVenda"%>
<%@page import="classes.Cliente"%>
<%@page import="classes.Venda"%>
<%@page import="utils.Web"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Venda" />
</jsp:include>

                <h1>Cadastro de Vendas</h1>
                <hr/>
                <%
                    request.setCharacterEncoding("UTF-8");
                    
                    Integer idCliente = Integer.parseInt(request.getParameter("idcliente"));
                    Integer qtdeCardapios = Integer.parseInt(request.getParameter("qtdeCardapios"));
                    LocalDate dataOrcamento = Web.valorDate(request.getParameter("dataorcamento")); // lê a data como String e converte no formato Date para o banco.
                    LocalDate dataPedido = Web.valorDate(request.getParameter("datapedido"));
                    LocalDate dataProducao = Web.valorDate(request.getParameter("dataproducao"));
                    Boolean producao = Web.valorCheckbox(request.getParameter("producao"));
                    
                    //dados da venda
                    Venda venda = new Venda();
                    venda.setDataOrcamento(dataOrcamento);
                    venda.setDataPedido(dataPedido);
                    venda.setDataProducao(dataProducao);
                    venda.setProducao(producao);
                    
                    Cliente cliente = new Cliente();
                    cliente = cliente.consultar(idCliente);
                    venda.setCliente(cliente);
                    
                    int idCardapio = 0;
                    for (int c = 1; c <= qtdeCardapios; c++) {
                        idCardapio = Integer.parseInt(request.getParameter("idcardapio" + c));
                        CardapioVenda cardapioVenda = new CardapioVenda();
                        cardapioVenda.setIdCardapio(idCardapio);
                        venda.adicionarCardapio(cardapioVenda);
                        int qtdePratos = Integer.parseInt(request.getParameter("qtdePratos" + c));
                        for (int p = 1; p <= qtdePratos; p++) {
                            int idPrato = Integer.parseInt(request.getParameter("idprato" + c + '_' + p));
                            int qtdeVenda = Integer.parseInt(request.getParameter("qtdevenda" + c + '_' + p));
                            //1º replace R$ - retira espaço em branco
                            //2º replace R$ - Java registra algum caracter diferente que o 1º replace não retira
                            String valor = request.getParameter("valortotal" + c + '_' + p);
                            float valorVenda = Float.parseFloat(valor.replace(",", ".").replace("R$ ", "").replace("R$ ", ""));
                            ItemVenda itemVenda = new ItemVenda();
                            itemVenda.setPrato(Prato.consultar(idPrato));
                            itemVenda.setQtdeVenda(qtdeVenda);
                            itemVenda.setValorVenda(valorVenda);
                            cardapioVenda.adicionarItem(itemVenda);
                        }
                    }
                    
                    try {
                        venda.salvar();
                        out.write("<div class='alerta alerta-verde'>Venda Cadastrada com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage()+ "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>
