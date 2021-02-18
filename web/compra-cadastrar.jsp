<%-- 
    Document   : compra-cadastrar
    Created on : 2 de jan de 2021, 20:48:58
    Author     : Janine
--%>

<%@page import="classes.Produto"%>
<%@page import="classes.Fornecedor"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Compras" />
</jsp:include>
<%                  
    Fornecedor fornecedor = new Fornecedor();
    List<Fornecedor> fornecedores = fornecedor.consultar();

    Produto produto = new Produto();
    List<Produto> produtos = produto.consultar();
%>
                <h1>Cadastro de Compras</h1>
                
                <form action="compra-recebe-cadastrar.jsp" method="POST" onsubmit="return enviarForm()">
                    <input type="hidden" name="qtdeItens" id="qtdeItens" value="1"/>
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    
                    <div class="form-grupo">
                        <label>Selecione o Fornecedor <span class="asterisco">*</span></label>
                            <select class="form-campo" name="idfornecedor">
                                <option value=""></option>
                                <%for (Fornecedor fornec : fornecedores) {%>
                                    <option value="<%out.write(String.valueOf(fornec.getIdFornecedor()));%>">
                                        <%out.write(fornec.getNome());%>
                                    </option>
                                <%}%>
                            </select>
                        <div class="alerta alerta-vermelho d-none" id="erroFornec"></div>
                    </div>

                    <div class="form-grupo">
                        <label>Data de Cotação</label>
                        <input class="form-campo form-campo-w250" type="date" name="datacotacao"/>
                    </div>

                    <div class="form-grupo">
                        <label>Data de Compra</label>
                        <input class="form-campo form-campo-w250" type="date" name="datacompra"/>
                    </div>

                    <div class="form-grupo">
                        <label>Data de Entrada</label>
                        <input class="form-campo form-campo-w250" type="date" name="dataentrada"/>
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
                                    <tr>
                                        <td> <!--Produto-->
                                            <select class="form-campo" name="idproduto1">
                                                <option value=""></option>
                                                <%for (Produto pdt : produtos) {%>
                                                    <option value="<%out.write(String.valueOf(pdt.getIdProduto()));%>">
                                                        <%out.write(pdt.getDescricaoProduto());%>
                                                    </option>
                                                <%}%>
                                            </select>
                                            <div class="alerta alerta-vermelho d-none" id="erroProduto1"></div>
                                        </td>
                                        <td> <!--Quantidade-->
                                            <input class="form-campo txt-right" type="text" name="qtdecompra1"/>
                                            <div class="alerta alerta-vermelho d-none" id="erroQtde1"></div>
                                        </td>
                                        <td> <!--Un Medida-->
                                            <input class="form-campo txt-center" type="text" name="unmedida1" placeholder="Sigla"/>
                                            <div class="alerta alerta-vermelho d-none" id="erroUn1"></div>
                                        </td>
                                        <td> <!--Valor do Item-->
                                            <input class="form-campo txt-right" type="text" name="valorcompra1"/>
                                            <div class="alerta alerta-vermelho d-none" id="erroValor1"></div>
                                        </td>
                                    <tr/>
                                </tbody>
                            </table>
                            <button type="button" class="btn btn-azul btn-block btn-sm" onclick="adicionar()"/><i class="fas fa-plus"></i> Adicionar</button>
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
