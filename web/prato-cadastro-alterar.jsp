<%-- 
    Document   : prato-cadastro-alterar
    Created on : 12/01/2021, 18:22:31
    Author     : LUZIA
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Ingrediente"%>
<%@page import="java.util.List"%>
<%@page import="classes.Produto"%>
<%@page import="classes.Prato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Pratos" />
</jsp:include>
<%
    String idprato = request.getParameter("idprato");
    Prato prato = new Prato();
    if (idprato != null) {
        prato = prato.consultar(Integer.parseInt(idprato));
    }

    Produto produto = new Produto();
    List<Produto> produtos = produto.consultar();
%>

                <h1>Alteração de Dados no Cadastro de Pratos</h1>
                
                <form action="prato-recebe-cadastro-alterar.jsp" method="POST" onsubmit="return enviarForm()">
                    <input type="hidden" name="qtdeIngredientes" id="qtdeIngredientes" value="1"/>
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    
                    <div class="form-grupo">
                        <label>Código</label>
                        <input class="form-campo form-campo-w250" type="text" name="idprato" readonly="true" value="<%out.write(String.valueOf(prato.getIdPrato()));%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Nome do Prato <span class="asterisco">*</span></label>
                        <input class="form-campo" type="text" name="nome" value="<%out.write(prato.getNome());%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroNome"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Rendimento <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250 txt-right" type="text" name="rendimento" placeholder="Porções" value="<%out.write(String.valueOf(prato.getRendimento()));%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroRend"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Tempo de Preparo <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250 txt-right" type="text" name="tempopreparo" placeholder="Em Minutos" value="<%out.write(String.valueOf(prato.getTempoPreparo()));%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroTempo"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Margem de Lucro (%) <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250 txt-right" type="text" name="lucro" id="lucro" placeholder="Somente Números" onchange="calcularTotal()" value="<%out.write(String.valueOf(prato.getLucro()));%>"/>
                        <div class="alerta alerta-vermelho d-none" id="erroLucro"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Preço do Prato</label>
                        <input class="form-campo form-campo-w250 txt-right" type="text" name="valorprato" id="valorprato" readonly="true" value="<%=Web.moedaParaString(prato.getValorPrato())%>"/>
                    </div>
                    
                    <div class="subform">
                        <div class="subform-header">
                            Ingredientes <span class="asterisco">*</span>
                        </div>
                        <div class="subform-body">
                            <table id="tabelaIngredientes">
                                <thead>
                                <th>Produto <span class="asterisco">*</span></th>
                                    <th class="txt-right">Quantidade <span class="asterisco">*</span></th>
                                    <th class="txt-center">Un Medida <span class="asterisco">*</span></th>
                                    <th class="txt-right">Valor do Ingrediente <span class="asterisco">*</span></th>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 1;
                                        for (Ingrediente ingrediente : prato.getIngredientes()) {
                                    %>
                                    <tr>
                                        <td> <!--Produto-->
                                            <select class="form-campo" name="idproduto<%=i%>">
                                                <option value=""></option>
                                                <%for (Produto pdt : produtos) {%>
                                                    <option value="<%out.write(String.valueOf(pdt.getIdProduto()));%>"
                                                            <%out.write(ingrediente.getIdproduto()==pdt.getIdProduto() ? " selected='selected'" : "");%>>
                                                        <%out.write(pdt.getDescricaoProduto());%>
                                                </option>
                                                <% } %>
                                            </select>
                                            <div class="alerta alerta-vermelho d-none" id="erroProduto<%=i%>" ></div>
                                        </td>
                                        <td> <!--Quantidade-->
                                            <input class="form-campo txt-right" type="text" name="qtde<%=i%>" value="<%=ingrediente.getQtde()%>"/>
                                            <div class="alerta alerta-vermelho d-none" id="erroQtde<%=i%>"></div>
                                        </td>
                                        <td> <!--Un Medida-->
                                            <input class="form-campo txt-center" type="text" name="unmedida<%=i%>" placeholder="Sigla" value="<%=ingrediente.getUnMedida()%>"/>
                                            <div class="alerta alerta-vermelho d-none" id="erroUn<%=i%>"></div>
                                        </td>
                                        <td>
                                            <input class="form-campo txt-right" type="text" name="valoringrediente<%=i%>" id="valoringrediente<%=i%>" onblur="calcularTotal()" value="<%=ingrediente.getValorIngrediente()%>"/>
                                            <div class="alerta alerta-vermelho d-none" id="erroValor<%=i%>"></div>
                                        </td>
                                    </tr>
                                    <%
                                        i++;
                                        }
                                    %>
                                </tbody>
                            </table>                            
                            <button type="button" class="btn btn-azul btn-sm btn-block" onclick="adicionar()"><i class="fas fa-plus"></i> Adicionar</button>
                        </div>
                    </div>                            

                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Alterar</button>
                    <button type="reset" class="btn btn-vermelho" onclick="document.location='prato-consultar.jsp';">Cancelar</button>
                    </div>
                </form>

        <script>
            function enviarForm() {
                var semErros = true;
                
                var nome = document.getElementsByName("nome");
                if (nome[0].value === "") {
                    document.getElementById("erroNome").innerHTML = "Informar o Nome do Prato";
                    document.getElementById("erroNome").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroNome").style = "";
                }
                
                var rend = document.getElementsByName("rendimento");
                if (rend[0].value === "") {
                    document.getElementById("erroRend").innerHTML = "Informar o Rendimento";
                    document.getElementById("erroRend").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroRend").style = "";
                }
                
                var tempo = document.getElementsByName("tempopeparo");
                if (tempo[0].value === "") {
                    document.getElementById("erroTempo").innerHTML = "Informar o Tempo de Preparo";
                    document.getElementById("erroTempo").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroTempo").style = "";
                }
                
                var lucro = document.getElementsByName("lucro");
                if (lucro[0].value === "") {
                    document.getElementById("erroLucro").innerHTML = "Informar o Percentual de Lucro";
                    document.getElementById("erroLucro").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroLucro").style = "";
                }
                
                return semErros;
            }

            function calcularTotal() {
                var qtdeIngrediente = document.getElementById('qtdeIngredientes').value;
                var precoPrato = 0;
                for (i = 1; i <= qtdeIngrediente; i++) {
                    if (document.getElementById('valoringrediente' + i).value != ''){
                        precoPrato += parseFloat(document.getElementById('valoringrediente' + i).value);
                    }
                }
                precoPrato *= (1 + (parseFloat(document.getElementById('lucro').value)/100));
                document.getElementById('valorprato').value = 'R$ ' + precoPrato.toFixed(2).replace('.', ',');
            }
            
            function adicionar() {
                document.getElementById('qtdeIngredientes').value = parseInt(document.getElementById('qtdeIngredientes').value) + 1; // incrementa a quantidade de itens do campo oculto (type hidden)
                var tr = document.createElement('tr'); // cria novo tr class selection da tabela
                tr.className = 'selection'; // define a classe da tr acima

                // montagem da lista para adicionar o produto
                var td = document.createElement('td'); // cria novo td da tabela
                var select = document.querySelector('select[name=idproduto1]').cloneNode(true); // clona a parte de select do produto
                select.name = 'idproduto' + document.getElementById('qtdeIngredientes').value; // define o name do elemento clonado
                select.selectedIndex = 0; // seleciona o option vazio no select
                select.className = 'form-campo';
                var divErro = document.createElement('div'); // cria novo label para a mensagem de Erro
                divErro.id = 'erroProduto' + document.getElementById('qtdeIngredientes').value; // define o novo id para o novo labelErro
                divErro.className = 'alerta alerta-vermelho d-none'; // cria novo class error
                td.appendChild(select); // anexa o select ao td
                td.appendChild(divErro); // anexa o labelErro ao td
                tr.appendChild(td); // anexa todos os itens de td acima no tr
                
                // montagem da lista para adicionar a quantidade
                var td = document.createElement('td');
                var input = document.createElement('input');
                input.type = 'text';
                input.name = 'qtde' + document.getElementById('qtdeIngredientes').value;
                input.className = 'form-campo txt-right';
                var divErro = document.createElement('div');
                divErro.id = 'erroQtde' + document.getElementById('qtdeIngredientes').value;
                divErro.className = 'alerta alerta-vermelho d-none'; // cria novo class error
                td.appendChild(input);
                td.appendChild(divErro);
                tr.appendChild(td);
                
                // montagem da lista para adicionar unidade de medida
                var td = document.createElement('td');
                var input = document.createElement('input');
                input.type = 'text';
                input.name = 'unmedida' + document.getElementById('qtdeIngredientes').value;
                input.className = 'form-campo txt-center';
                input.setAttribute('placeholder', 'Sigla');
                var divErro = document.createElement('div');
                divErro.id = 'erroUn' + document.getElementById('qtdeIngredientes').value;
                divErro.className = 'alerta alerta-vermelho d-none'; // cria novo class error
                td.appendChild(input);
                td.appendChild(divErro);
                tr.appendChild(td);
                
                //montagem da lista para adicionar o valor
                var td = document.createElement('td');
                var input = document.createElement('input');
                input.type = 'text';
                input.name = 'valoringrediente' + document.getElementById('qtdeIngredientes').value;
                input.id = 'valoringrediente' + document.getElementById('qtdeIngredientes').value;
                input.className = 'form-campo txt-right';
                input.setAttribute('onblur', 'calcularTotal()');
                var divErro = document.createElement('div');
                divErro.id = 'erroValor' + document.getElementById('qtdeIngredientes').value;
                divErro.className = 'alerta alerta-vermelho d-none'; // cria novo class error
                td.appendChild(input);
                td.appendChild(divErro);
                tr.appendChild(td);

                document.getElementById('tabelaIngredientes').appendChild(tr); // anexa nova linha na tabela, para os itens acima
            }
        </script>
<jsp:include page = "footer.jsp"/>
