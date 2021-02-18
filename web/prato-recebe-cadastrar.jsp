<%-- 
    Document   : prato-recebe-cadastrar
    Created on : 12/01/2021, 18:05:06
    Author     : luzia
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Ingrediente"%>
<%@page import="classes.Prato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Pratos" />
</jsp:include>
                <h1>Cadastro de Pratos</h1>

                <%
                    String nome = request.getParameter("nome");                    
                    Integer rendimento = Web.valorInteger(request.getParameter("rendimento"));
                    Integer tempopreparo = Web.valorInteger(request.getParameter("tempopreparo"));
                    String valorPratoTemp = request.getParameter("valorprato");
                    valorPratoTemp = valorPratoTemp.replace(",", ".").replace("R$ ", "");
                    Float precoPrato = Web.valorFloat(valorPratoTemp);
                    Float lucro = Web.valorFloat(request.getParameter("lucro"));
                   
                    //dados do prato
                    Prato prato = new Prato();
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
                        prato.salvar();
                        out.write("<div class='alerta alerta-verde'>Prato Cadastrado com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>