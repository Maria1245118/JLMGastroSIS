<%-- 
    Document   : prato-recebe-cadastro-alterar
    Created on : 12/01/2021, 19:00:01
    Author     : LUZIA
--%>

<%@page import="classes.Ingrediente"%>
<%@page import="utils.Web"%>
<%@page import="classes.Prato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Prato" />
</jsp:include>
                <h1>Alteração de Dados no Cadastro de Prato</h1>

                 <%
                    Integer idprato = Integer.parseInt(request.getParameter("idprato"));
                    String nome = request.getParameter("nome");                    
                    Integer rendimento = Web.valorInteger(request.getParameter("rendimento"));
                    Integer tempopreparo = Web.valorInteger(request.getParameter("tempopreparo"));
                    String valorPratoTemp = request.getParameter("valorprato");
                    valorPratoTemp = valorPratoTemp.replace(",", ".").replace("R$ ", "").replace("R$ ", "");
                    Float precoPrato = Web.valorFloat(valorPratoTemp);
                    Float lucro = Web.valorFloat(request.getParameter("lucro"));
                    
                    Prato prato = new Prato();
                    prato.setIdPrato(idprato);
                    prato.setNome(nome.toUpperCase());
                    prato.setRendimento(rendimento);
                    prato.setTempoPreparo(tempopreparo);
                    prato.setValorPrato(precoPrato);
                    prato.setLucro(lucro);

                    //adiciona os ingredientes
                    int qtdeIngredientes = Integer.parseInt(request.getParameter("qtdeIngredientes"));
                    Integer idProduto;
                    Float qtde;
                    String unMedida;
                    Float valorIngrediente;
                    
                    for (int i = 1; i <= qtdeIngredientes; i++) {
                        String idProd = request.getParameter("idproduto" + i);
                        if (idProd != null && idProd != "") {
                            idProduto = Integer.parseInt(idProd);
                            qtde = Web.valorFloat(request.getParameter("qtde" + i));
                            unMedida = request.getParameter("unmedida" + i);
                            valorIngrediente = Float.parseFloat(request.getParameter("valoringrediente" + i));
                            Ingrediente ingrediente = new Ingrediente();
                            ingrediente.setIdproduto(idProduto);
                            ingrediente.setQtde(qtde);
                            ingrediente.setUnMedida(unMedida.toUpperCase());
                            ingrediente.setValorIngrediente(valorIngrediente);
                            prato.adicionarIngrediente(ingrediente);
                        }
                    }

                    try {
                        prato.editar();
                        out.write("<div class='alerta alerta-verde'>Prato Alterado com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    } 
                %>
<jsp:include page = "footer.jsp"/>
