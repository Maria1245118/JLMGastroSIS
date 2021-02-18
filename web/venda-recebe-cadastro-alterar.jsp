<%-- 
    Document   : venda-recebe-cadastro-alterar
    Created on : 17/01/2021, 11:06:41
    Author     : Familia
--%>

    <%@page import="classes.Prato"%>
<%@page import="classes.CardapioVenda"%>
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
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Venda" />
</jsp:include>

                <h1>Alteração de Dados no Cadastro de Venda</h1>
                <hr/>
                <%
                    request.setCharacterEncoding("UTF-8");
                    
                    Integer idVenda = Integer.parseInt(request.getParameter("idvenda"));
                    Integer idCliente = Integer.parseInt(request.getParameter("idcliente"));
                    Integer qtdeCardapios = Integer.parseInt(request.getParameter("qtdeCardapios"));
                    LocalDate dataOrcamento = Web.valorDate(request.getParameter("dataorcamento")); // lê a data como String e converte no formato Date para o banco.
                    LocalDate dataPedido = Web.valorDate(request.getParameter("datapedido"));
                    LocalDate dataProducao = Web.valorDate(request.getParameter("dataproducao"));
                    Boolean producao = Web.valorCheckbox(request.getParameter("producao"));
                    
                    //dados da venda
                    Venda venda = Venda.consultar(idVenda);
                    venda.setDataOrcamento(dataOrcamento);
                    venda.setDataPedido(dataPedido);
                    venda.setDataProducao(dataProducao);
                    venda.setProducao(producao);
                    
                    Cliente cliente = new Cliente();
                    cliente = cliente.consultar(idCliente);
                    venda.setCliente(cliente);
                    
                    int c = 1;
                    for (CardapioVenda cardapioVenda : venda.getItensCardapioVenda()) {
                        int p = 1;
                        for (ItemVenda item : cardapioVenda.getItens()) {
                            int qtdeVenda = Integer.parseInt(request.getParameter("qtdevenda" + c + '_' + p));
                            //1º replace R$ - retira espaço em branco
                            //2º replace R$ - Java registra algum caracter diferente que o 1º replace não retira
                            String valor = request.getParameter("valortotal" + c + '_' + p);
                            float valorVenda = Float.parseFloat(valor.replace(",", ".").replace("R$ ", "").replace("R$ ", ""));
                            item.setQtdeVenda(qtdeVenda);
                            item.setValorVenda(valorVenda);
                            p++;
                        }
                        c++;
                    }
                    
                    try {
                        venda.editar();
                        out.write("<div class='alerta alerta-verde'>Venda Alterada com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>
