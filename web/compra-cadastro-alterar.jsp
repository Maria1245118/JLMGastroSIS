<%-- 
    Document   : compra-cadastro-alterar
    Created on : 2 de jan de 2021, 20:49:44
    Author     : Janine
--%>

<%@page import="classes.ItemCompra"%>
<%@page import="classes.Compra"%>
<%@page import="java.util.List"%>
<%@page import="classes.Fornecedor"%>
<%@page import="classes.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Alteração de Dados no Cadastro de Compras" />
</jsp:include>
<%
    String idcompra = request.getParameter("idcompra");
    Compra comp = new Compra();
    if (idcompra != null) {
        comp = comp.consultar(Integer.parseInt(idcompra));
    }

    Fornecedor fornecedor = new Fornecedor();
    List<Fornecedor> fornecedores = fornecedor.consultar();

    Produto produto = new Produto();
    List<Produto> produtos = produto.consultar();
%>

                <h1>Alteração de Dados no Cadastro de Compras</h1>
                
                <form action="compra-recebe-cadastro-alterar.jsp" method="POST" onsubmit="return enviarForm()">
                    <input type="hidden" name="qtdeItens" id="qtdeItens" value="<%=comp.getItens().size()%>"/>
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    
                    <div class="form-grupo">
                        <label>Código</label>
                        <input class="form-campo form-campo-w250" type="text" name="idcompra" readonly="true" value="<%out.write(String.valueOf(comp.getIdCompra()));%>"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Selecione o Fornecedor <span class="asterisco">*</span></label>
                            <select class="form-campo" name="idfornecedor">
                                <option value=""></option>
                                <%for (Fornecedor fornec : fornecedores) {%>
                                    <option value="<%out.write(String.valueOf(fornec.getIdFornecedor()));%>"
                                        <%out.write(comp.getFornecedor().getIdFornecedor()==fornec.getIdFornecedor() ? " selected='selected'" : "");%>>
                                        <%out.write(fornec.getNome());%>
                                    </option>
                                <%}%>
                            </select>
                        <div class="alerta alerta-vermelho d-none" id="erroFornec"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Data de Cotação</label>
                        <input class="form-campo form-campo-w250" type="date" name="datacotacao" value="<%out.write(String.valueOf(comp.getDataCotacao()));%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Data de Compra</label>
                        <input class="form-campo form-campo-w250" type="date" name="datacompra" value="<%out.write(String.valueOf(comp.getDataCompra()));%>"/>
                    </div>

                    <div class="form-grupo">
                        <label>Data de Entrada</label>
                        <input class="form-campo form-campo-w250" type="date" name="dataentrada" value="<%out.write(String.valueOf(comp.getDataEntrada()));%>"/>
                    </div>                      
                    
                    <div class="subform">
                        <div class="subform-header">
                            Itens <span class="asterisco">*</span>
                        </div>
                        <div class="subform-body">
                            <table id="tabelaItens">
                                <thead>
                                    <th>Produto <span class="asterisco">*</span></th>
                                    <th class="txt-right">Quantidade <span class="asterisco">*</span></th>
                                    <th class="txt-center">Un Medida <span class="asterisco">*</span></th>
                                    <th class="txt-right">Valor do Item <span class="asterisco">*</span></th>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 1;
                                        for (ItemCompra item : comp.getItens()) {
                                    %>
                                    <tr>
                                        <td> <!--Produto-->
                                            <select class="form-campo" name="idproduto<%=i%>">
                                                <option value=""></option>
                                                <%for (Produto pdt : produtos) {%>
                                                    <option value="<%out.write(String.valueOf(pdt.getIdProduto()));%>"
                                                        <%out.write(item.getIdProduto()==pdt.getIdProduto() ? " selected='selected'" : "");%>>
                                                        <%out.write(pdt.getDescricaoProduto());%>
                                                    </option>
                                                <%}%>
                                            </select>
                                            <div class="alerta alerta-vermelho d-none" id="erroProduto<%=i%>"></div>
                                        </td>
                                        <td> <!--Quantidade-->
                                            <input class="form-campo txt-right" type="text" name="qtdecompra<%=i%>" value="<%=item.getQtdeCompra()%>"/>
                                            <div class="alerta alerta-vermelho d-none" id="erroQtde<%=i%>"></div>
                                        </td>
                                        <td> <!--Un Medida-->
                                            <input class="form-campo txt-center" type="text" name="unmedida<%=i%>" placeholder="Sigla"/ value="<%=item.getUnMedida()%>">
                                            <div class="alerta alerta-vermelho d-none" id="erroUn<%=i%>"></div>
                                        </td>
                                        <td> <!--Valor do Item-->
                                            <input class="form-campo txt-right" type="text" name="valorcompra<%=i%>" value="<%=item.getValorCompra()%>"/>
                                            <div class="alerta alerta-vermelho d-none" id="erroValor<%=i%>"></div>
                                        </td>
                                    <tr/>
                                    <% 
                                        i++;
                                        }
                                    %>
                                </tbody>
                            </table>
                            <button type="button" class="btn btn-azul btn-block btn-sm" onclick="adicionar()"/><i class="fas fa-plus"></i> Adicionar</button>
                        </div>
                    </div>                                                

                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Alterar</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='compra-consultar.jsp';">Cancelar</button>
                    </div>
                </form>

        <script>
            function enviarForm() {
                var semErros = true;

                var idfornecedor = document.getElementsByName("idfornecedor");
                if (idfornecedor[0].value === "") {
                    document.getElementById("erroFornec").innerHTML = "Informar o Fornecedor";
                    document.getElementById("erroFornec").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroFornec").style = "";
                }
                
                var qtdeItens = document.getElementById('qtdeItens').value;
                for (item = 1; item <= qtdeItens; item++) {
                    var idproduto = document.getElementById('idproduto' + item);
                    if (idproduto.selectedIndex > 0) {
                        var qtdecompra = document.getElementById('qtdecompra' + item);
                        if (qtdecompra.value === '' || qtdecompra == 0) {
                            document.getElementById('erroQtde' + item).innerHTML = "Informar a Quantidade";
                            document.getElementById('erroQtde' + item).style = "display: block";
                            semErros = false;
                        }
                        else {
                            document.getElementById('erroQtde' + item).style = "";
                        }
                        
                        var unmedida = document.getElementById('unmedida' + item);
                        if (unmedida.value ==='' || unmedida == 0) {
                            document.getElementById('erroUn' + item).innerHTML = "Informar a Unidade de Medida";
                            document.getElementById('erroUn' + item).style = "display: block";
                            semErros = false;
                        }
                        else {
                            document.getElementById('erroUn' + item).style = "";
                        }
                        
                        var valorcompra = document.getElementById('valorcompra' + item);
                        if (valorcompra.value === '' || valorcompra == 0) {
                            document.getElementById('erroValor' + item).innerHTML = "Informar o Valor do Item";
                            document.getElementById('erroValor' + item).style = "display: block";
                            semErros = false;
                        }
                        else {
                            document.getElementById('erroValor' + item).style = "";
                        }
                    }
                }
                 return semErros;
            }
            
            function adicionar() {
                document.getElementById('qtdeItens').value = parseInt(document.getElementById('qtdeItens').value) + 1; // incrementa a quantidade de itens do campo oculto (type hidden)
                var tr = document.createElement('tr'); // cria novo tr class selection da tabela
                tr.className = 'selection'; // define a classe da tr acima

                // montagem da lista para adicionar o produto
                var td = document.createElement('td'); // cria novo td da tabela
                var select = document.querySelector('select[name=idproduto1]').cloneNode(true); // clona a parte de select do produto
                select.name = 'idproduto' + document.getElementById('qtdeItens').value; // define o name do elemento clonado
                select.selectedIndex = 0; // seleciona o option vazio no select
                select.className = 'form-campo';
                var divErro = document.createElement('div'); // cria novo label para a mensagem de Erro
                divErro.id = 'erroProduto' + document.getElementById('qtdeItens').value; // define o novo id para o novo labelErro
                divErro.className = 'alerta alerta-vermelho d-none';
                td.appendChild(select); // anexa o select ao td
                td.appendChild(divErro); // anexa o labelErro ao td
                tr.appendChild(td); // anexa todos os itens de td acima no tr
                
                // montagem da lista para adicionar a quantidade
                var td = document.createElement('td');
                var input = document.createElement('input');
                input.type = 'text';
                input.name = 'qtdecompra' + document.getElementById('qtdeItens').value;
                input.className = 'form-campo txt-right';
                var divErro = document.createElement('div');
                divErro.id = 'erroQtde' + document.getElementById('qtdeItens').value;
                divErro.className = 'alerta alerta-vermelho d-none';
                td.appendChild(input);
                td.appendChild(divErro);
                tr.appendChild(td);
                
                // montagem da lista para adicionar unidade de medida
                var td = document.createElement('td');
                var input = document.createElement('input');
                input.type = 'text';
                input.name = 'unmedida' + document.getElementById('qtdeItens').value;
                input.className = 'form-campo txt-center';
                input.setAttribute('placeholder', 'Sigla')
                var divErro = document.createElement('div');
                divErro.id = 'erroUn' + document.getElementById('qtdeItens').value;
                divErro.className = 'alerta alerta-vermelho d-none';
                td.appendChild(input);
                td.appendChild(divErro);
                tr.appendChild(td);

                // montagem da lista para adicionar o valor
                var td = document.createElement('td');
                var input = document.createElement('input');
                input.type = 'text';
                input.name = 'valorcompra' + document.getElementById('qtdeItens').value;
                input.className = 'form-campo txt-right';
                var divErro = document.createElement('div');
                divErro.id = 'erroValor' + document.getElementById('qtdeItens').value;
                divErro.className = 'alerta alerta-vermelho d-none';
                td.appendChild(input);
                td.appendChild(divErro);
                tr.appendChild(td);

                document.getElementById('tabelaItens').appendChild(tr); // anexa nova linha na tabela, para os itens acima
            }
        </script>
<jsp:include page = "footer.jsp"/>