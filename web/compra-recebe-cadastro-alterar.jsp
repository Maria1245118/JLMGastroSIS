<%-- 
    Document   : compra-recebe-cadastro-alterar
    Created on : 2 de jan de 2021, 20:51:08
    Author     : Janine
--%>

<%@page import="classes.ItemCompra"%>
<%@page import="classes.Fornecedor"%>
<%@page import="classes.Compra"%>
<%@page import="java.time.LocalDate"%>
<%@page import="utils.Web"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Compra" />
</jsp:include>
                <h1>Alteração de Dados no Cadastro de Compra</h1>

                <%
                    Integer idCompra = Integer.parseInt(request.getParameter("idcompra"));
                    Integer idFornecedor = Integer.parseInt(request.getParameter("idfornecedor"));
                    LocalDate dataCotacao = Web.valorDate(request.getParameter("datacotacao"));
                    LocalDate dataCompra = Web.valorDate(request.getParameter("datacompra"));
                    LocalDate dataEntrada = Web.valorDate(request.getParameter("dataentrada"));
                    
                    //dados da compra
                    Compra compra = new Compra();
                    compra.setIdCompra(idCompra);
                    compra.setDataCotacao(dataCotacao);
                    compra.setDataCompra(dataCompra);
                    compra.setDataEntrada(dataEntrada);
                    
                    Fornecedor fornecedor = new Fornecedor();
                    fornecedor = fornecedor.consultar(idFornecedor);
                    compra.setFornecedor(fornecedor);
                    
                    //adiciona os itens da compra
                    int qtdeItens = Integer.parseInt(request.getParameter("qtdeItens"));
                    Integer idProduto;
                    Float qtdeCompra;
                    String unMedida;
                    Float valorCompra;
                    
                    for (int i = 1; i <= qtdeItens; i++) {
                        String idProd = request.getParameter("idproduto" + i);
                        if (idProd != null && idProd != "") {
                            idProduto = Integer.parseInt(idProd);
                            qtdeCompra = Web.valorFloat(request.getParameter("qtdecompra" + i));
                            unMedida = request.getParameter("unmedida" + i);
                            valorCompra = Web.valorFloat(request.getParameter("valorcompra" + i));
                            ItemCompra itemCompra = new ItemCompra();
                            itemCompra.setIdProduto(idProduto);
                            itemCompra.setQtdeCompra(qtdeCompra);
                            itemCompra.setUnMedida(unMedida.toUpperCase());
                            itemCompra.setValorCompra(valorCompra);
                            compra.adicionarItem(itemCompra);
                        }
                    }
                    
                    try {
                        compra.editar();
                        out.write("<div class='alerta alerta-verde'>Compra Alterada com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>
