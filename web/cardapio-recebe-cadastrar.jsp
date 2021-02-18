<%-- 
    Document   : cardapio-recebe-cadastrar
    Created on : 8 de jan de 2021, 08:15:40
    Author     : Janine
--%>

<%@page import="classes.PratoCardapio"%>
<%@page import="classes.Cardapio"%>
<%@page import="utils.Web"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Cardápios" />
</jsp:include>
                <h1>Cadastro de Cardápios</h1>

                <%
                    String descCardapio = request.getParameter("desccardapio");
                    Integer qtdePessoas = Web.valorInteger(request.getParameter("qtdepessoas"));
                    String valorPessoaTemp = request.getParameter("valorunitario");
                    valorPessoaTemp = valorPessoaTemp.replace(",", ".").replace("R$ ", "");
                    Float precoPessoa = Web.valorFloat(valorPessoaTemp);
                    String valorTotalTemp = request.getParameter("valortotal");
                    valorTotalTemp = valorTotalTemp.replace(",", ".").replace("R$ ", "");
                    Float precoPrato = Web.valorFloat(valorTotalTemp);
                    Boolean buffetInterno = Web.valorCheckbox(request.getParameter("buffetinterno"));
                    
                    //dados do cardápio
                    Cardapio menu = new Cardapio();
                    menu.setDescCardapio(descCardapio.toUpperCase());
                    menu.setQtdePessoas(qtdePessoas);
                    menu.setValorUnitario(precoPessoa);
                    menu.setValorTotal(precoPrato);
                    menu.setBuffetInterno(buffetInterno);
                    
                    //adiciona os pratos do cardápio
                    int qtdePratos = Integer.parseInt(request.getParameter("qtdePratos"));
                    Integer idPrato;
                    
                    for (int i = 1; i <= qtdePratos; i++) {
                        String idPrt = request.getParameter("idprato" + i);
                        if (idPrt != null && idPrt != "") {
                            idPrato = Integer.parseInt(idPrt);
                            PratoCardapio item = new PratoCardapio();
                            item.setIdPrato(idPrato);
                            menu.adicionarPrato(item);
                        }
                    }
                    
                    try {
                        menu.salvar();
                        out.write("<div class='alerta alerta-verde'>Cardápio Cadastrado com Sucesso</div>");
                    } catch (Exception ex) {
                        out.write("<div class='alerta alerta-vermlelho'>Erro: " + ex.getMessage() + "</div>");
                    }
                %>
<jsp:include page = "footer.jsp"/>
